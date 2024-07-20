//
//  NotificationPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import Foundation
import UIKit
import RealmSwift

public enum notificationFields{
    case category
    case name
    case date
}

protocol NotificationViewProtocol: AnyObject {
    
    func enableSaveButton()
    func disableSaveButton()
    func setWeakTime(_ textField: UITextField)
    func setStrongTime(_ textField: UITextField)
    func setWeakDate(_ textField: UITextField)
    func setStrongDate(_ textField: UITextField)
    
    func fillEditValues(notification:OneTabletsFoddersRealmModel)
    
    func popViewWithSuccessAlert(title:String)
    
}

protocol NotificationPresenterProtocol: AnyObject {
    init(
        view: NotificationViewProtocol,
        model: Notification,
        pet:PetHim,
        tabletsFodderNetworkServices:TabletsFoddersNetworkServiceProtocol,
        tabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol,
        isEdit:Bool,
        notification:OneTabletsFoddersRealmModel?
    )
    
    var notification:OneTabletsFoddersRealmModel? { get }
    var isEdit:Bool { get }
    var model: Notification? {get set}
    
    func setNotificationData(type: notificationFields, value: String)
    func setPrescriptionsData(value: [TabletsFoddersOnePeriodJsonResponse])
    func validateModelData()
    
    func savedTapped()
    func deleteTapped()
    
    func willAppear()
}

class NotificationPresenter: NotificationPresenterProtocol {
    weak var view: NotificationViewProtocol?
    var model: Notification?
    
    var tabletsFodderNetworkServices:TabletsFoddersNetworkServiceProtocol?
    var tabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol?
    
    var pet:PetHim?
    
    var isEdit:Bool
    var notification:OneTabletsFoddersRealmModel?
    
    
    required init(
        view: NotificationViewProtocol, model: Notification, pet:PetHim, tabletsFodderNetworkServices:TabletsFoddersNetworkServiceProtocol,tabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol, isEdit:Bool = false, notification:OneTabletsFoddersRealmModel? = nil) {
            self.view = view
            self.model = model
            self.pet = pet
            self.tabletsFodderNetworkServices = tabletsFodderNetworkServices
            self.tabletsFoddersRealmService = tabletsFoddersRealmService
            self.isEdit = isEdit
            self.notification = notification
            if let realmNotification = notification {
                self.model = Notification(
                    name: realmNotification.name,
                    date: realmNotification.untilAt.toString(),
                    category: realmNotification.type == .fodder ? .food : .medicine ,
                    prescriptions: {
                        var arr:[TabletsFoddersOnePeriodJsonResponse] = []
                        for i in realmNotification.periods{
                            arr.append(TabletsFoddersOnePeriodJsonResponse(count: i.count, time: i.time))
                        }
                        return arr
                    }()
                )
            }
    }
    
    func willAppear(){
        if isEdit && notification != nil{
            view?.fillEditValues(notification:self.notification!)
            
            self.model?.category = notification?.type == .fodder ? .food : .medicine
            self.model?.date = notification?.untilAt.toString() ?? ""
            self.model?.name = notification?.name ?? ""
            
            self.view?.enableSaveButton()
        }else{
            self.view?.disableSaveButton()
        }
    }
    
    func setNotificationData(type: notificationFields, value: String) {
        switch type {
        case .category:
            model?.setCategory(category: value)
        case .name:
            model?.setName(name: value)
        case .date:
            model?.setDate(date: value)
        }
        if (model?.isEmptyData() ?? true){
            view?.disableSaveButton()
        } else {
            view?.enableSaveButton()
        }
    }
    
    func setPrescriptionsData(value: [TabletsFoddersOnePeriodJsonResponse]) {
        model?.setPrescriptions(prescriptions: value)
    }
        
    func validateModelData(){
        var isValid = true
        
        if !DateValidation.validateDate(value: self.model?.date ?? ""){ isValid = false}
        if self.model?.name.count == 0{ isValid = false }
        
        for period in self.model?.prescriptions ?? []{
            if period.count == -1{
                isValid = false
                break
            }
            
            if !TimeValidation.validateTime(value: period.time) {
                isValid = false
                break
            }
        }
        
        if isValid{
            self.view?.enableSaveButton()
        }else{
            self.view?.disableSaveButton()
        }
    }
    
    func savedTapped() {
        if !isEdit{
            saveNotification()
        }else{
            updateNotification()
        }
        
    }
    
    func createTabletFodder(_ type: TabletsFoddersRealmType,_ tabletFodder:TabletsFoddersContent)->OneTabletsFoddersRealmModel{
        let periods = List<OnePeriodRealmModel>()
        
        for period in tabletFodder.periods{
            let time = period.time
            let splittedTime = time.split(separator: ":")
            var newTime:String = ""
            if splittedTime.count == 2{
                newTime = splittedTime.joined(separator: ":")
            }else if splittedTime.count > 2{
                newTime = splittedTime[0] + ":" + splittedTime[1]
            }else{
                newTime = Date.now.timeToString()
            }
            
            let newPeriod = OnePeriodRealmModel(count: period.count, time: newTime)
            periods.append(newPeriod)
        }
        
        let new = OneTabletsFoddersRealmModel(id: tabletFodder.id, name: tabletFodder.name, type: type, untilAt: Date.dateFromISO8601(tabletFodder.untilAt) ?? Date.now, periods: periods)
        return new
    }
    
    func saveNotification(){
        let newJson = CreateTabletsFoddersJsonRequest(
            name: model?.getName() ?? "",
            period: model?.getPrescriptions() ?? [],
            untilAt: Date.dateToString(model?.date ?? "")?.toISO8601() ?? Date.now.toISO8601()
        )
        
        Task{
            var type:TabletFodderType = .tablet
            var realmType:TabletsFoddersRealmType = .tablet
            
            switch model?.category{
            case .food:
                type = .fodder
                realmType = .fodder
            case .medicine:
                type = .tablet
                realmType = .tablet
            default:
                break
            }
            
            if let result = try await self.tabletsFodderNetworkServices?.create(type, petId: pet!.id!, newJson){
                
                DispatchQueue.main.sync {
                    let tabletFodder = self.createTabletFodder(realmType, result)
                    self.tabletsFoddersRealmService?.appendTabletFodder(petId: self.pet!.id!, tabletFodder: tabletFodder)
                    self.view?.popViewWithSuccessAlert(title: "Напоминание добавлено")
                }
            }
        }
    }
    
    func updateNotification(){
        let updateJson = CreateTabletsFoddersJsonRequest(
            name: model?.getName() ?? "",
            period: model?.getPrescriptions() ?? [],
            untilAt: Date.dateToString(model?.date ?? "")?.toISO8601() ?? Date.now.toISO8601()
        )
        
        let notificationId = self.notification!.id
        
        Task{
            
            var type:TabletFodderType = .tablet
            var realmType:TabletsFoddersRealmType = .tablet
            
            switch model?.category{
            case .food:
                type = .fodder
                realmType = .fodder
            case .medicine:
                type = .tablet
                realmType = .tablet
            default:
                break
            }
            
            if let result = try await self.tabletsFodderNetworkServices?.update(type, petId: pet!.id!, tabletFodderId: notificationId, updateJson){
                DispatchQueue.main.sync {
                    let tabletFodder = self.createTabletFodder(realmType, result)
                    self.tabletsFoddersRealmService?.modifyTabletFodder(petId: self.pet!.id!, id: notificationId, tabletFodder: tabletFodder)
                    self.view?.popViewWithSuccessAlert(title: "Напоминание обновлено")
                }

                
            }
        }
        
    }
    
    func deleteTapped(){
        var type:TabletFodderType = .tablet
        
        switch notification?.type{
        case .fodder:
            type = .fodder
        case .tablet:
            type = .tablet
                                            
        default:
            break
        }
        
        let deleteType = type
        let notificationId = self.notification!.id

        Task{
            if let _ = try await self.tabletsFodderNetworkServices?.delete(deleteType, petId: pet!.id!, tabletFodderId: notificationId){
                
                DispatchQueue.main.async {
                    self.tabletsFoddersRealmService?.deleteTabletFodder(petId: self.pet!.id!, by: notificationId)
                    self.view?.popViewWithSuccessAlert(title: "Напоминание удалено")
                }
            }
        }
        
    }
    
}

