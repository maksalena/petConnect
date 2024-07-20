//
//  HomePagePresenter.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit
import RealmSwift

protocol HomePageViewControllerProtocol: AnyObject {
    func reloadTableView()
    func reloadPetsCollectionView()
    func successAlert(message:String)
}

protocol HomePagePresenterProtocol:AnyObject{
    init(view:HomePageViewControllerProtocol, tabletsFoddersNetworkService:TabletsFoddersNetworkServiceProtocol,tabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol,
         petsNetworkService:PetsNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol)
    
    var selectedIndex:IndexPath? { get set }
    var tabletsFodders:[UUID:TabletsFoddersRealmModel?] { get }
    
    func loadTabletsFoddersFromServer(petId:UUID)
    func loadTabletsFoddersFromRealm(petId:UUID)
    
    func deletePet(petId:UUID)
    func deleteNotification(petId:UUID, type:TabletFodderType, id:UUID)
    
}

class HomePagePresenter:HomePagePresenterProtocol{
    weak var view:HomePageViewControllerProtocol?
    
    var tabletsFoddersNetworkService:TabletsFoddersNetworkServiceProtocol?
    var tabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol?
    
    var petsNetworkService:PetsNetworkServiceProtocol?
    var petsRealmService:PetsRealmServiceProtocol?
    
    
    var selectedIndex:IndexPath? = nil
    
    var tabletsFodders:[UUID:TabletsFoddersRealmModel?] = [:]
        
    required init(view:HomePageViewControllerProtocol,tabletsFoddersNetworkService:TabletsFoddersNetworkServiceProtocol,tabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol, petsNetworkService:PetsNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol) {
        self.view = view
        self.tabletsFoddersNetworkService = tabletsFoddersNetworkService
        self.tabletsFoddersRealmService = tabletsFoddersRealmService
        self.petsNetworkService = petsNetworkService
        self.petsRealmService = petsRealmService
        
        if let allTabletsFodders = self.tabletsFoddersRealmService?.getAllTabletsFodders(){
            for object in allTabletsFodders{
                tabletsFodders[object.petId] = object
            }
        }
    }
    
    func createTabletFodder(_ type: TabletsFoddersRealmType,_ tabletFodder:TabletsFoddersContent) -> OneTabletsFoddersRealmModel  {
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
    func loadTabletsFoddersFromRealm(petId:UUID){
        self.tabletsFodders[petId] = self.tabletsFoddersRealmService?.getTabletFodder(by: petId)
        
        view?.reloadTableView()
    }
    
    func loadTabletsFoddersFromServer(petId:UUID){
        Task{
            do {
                let tabletsFodders = List<OneTabletsFoddersRealmModel>()
                
                if let tablets = try  await self.tabletsFoddersNetworkService?.findAll(.tablet ,petId:petId){
                                        
                    for tabletFodder in tablets.content{
                        
                        tabletsFodders.append(self.createTabletFodder(.tablet, tabletFodder))
                    }
                    
                }
                if let fodders = try  await self.tabletsFoddersNetworkService?.findAll(.fodder ,petId:petId){
                    
                    for tabletFodder in fodders.content{
                        
                        tabletsFodders.append(self.createTabletFodder(.fodder, tabletFodder))
                    }
                }
                
                let newTabletFodder = TabletsFoddersRealmModel(petId: petId, tabletsFodders: tabletsFodders)
                DispatchQueue.main.sync {
                    self.tabletsFoddersRealmService?.setTabletFodder(newTabletFodder)
                    self.tabletsFodders[petId] = newTabletFodder
                    view?.reloadTableView()
                }
            }catch{
                print("loadTabletsFoddersFromServer Error")
            }

        }
        
    }
    
    func deletePet(petId:UUID){
        Task{
            let isdeleted:Bool = try await self.petsNetworkService?.deletePet(petId:petId) ?? false
            
            if isdeleted{
                DispatchQueue.main.async {
                    self.petsRealmService?.deletePet(by: petId)
                    self.view?.reloadPetsCollectionView()
                    self.view?.successAlert(message: "Питомец удален")
                }
            }
        }
    }
    
    func deleteNotification(petId:UUID, type:TabletFodderType, id:UUID){
        
        Task{
            if let _ = try await self.tabletsFoddersNetworkService?.delete(type, petId: petId, tabletFodderId: id){
                
                DispatchQueue.main.sync {
                    self.tabletsFoddersRealmService?.deleteTabletFodder(petId: petId, by: id)
                    self.view?.reloadTableView()
                    self.view?.successAlert(message: "Напоминание удалено")
                    
                }
            }
        }
        
    }
    
}
