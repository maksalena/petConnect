//
//  AppointmentListPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import RealmSwift

protocol AppointmentListViewProtocol: AnyObject {
    func reloadTablView()
}

protocol AppointmentListPresenterProtocol: AnyObject {
    init(
        view: AppointmentListViewProtocol,
        appointmentNetworkService: AppointmentClinicsNetworkServiceProtocol,
        isNew:Bool
    )
    
    var appointments: [AppointmentModel] { get }
    
    var isNextPage:Bool { get }
    func loadAppointments(reload:Bool)
}

class AppointmentListPresenter: AppointmentListPresenterProtocol {
    
    weak var view: AppointmentListViewProtocol?
    
    var appointments:[AppointmentModel] = []
    private var prevPage:Int = -1
    var isNextPage:Bool = true
    
    
    
    var isNew:Bool = true
    var appointmentNetworkService: AppointmentClinicsNetworkServiceProtocol?
    
    required init(
        view: AppointmentListViewProtocol,
        appointmentNetworkService: AppointmentClinicsNetworkServiceProtocol,
        isNew:Bool) {
            self.view = view
            self.appointmentNetworkService = appointmentNetworkService
            self.isNew = isNew
        }
    
    
    func loadAppointments(reload:Bool){
        if reload{
            self.prevPage = -1
            self.isNextPage = true
            self.appointments = []
        }
        
        if !self.isNextPage{
            return
        }
        
        Task{
            do{
                prevPage += 1
                let appointmentJson = try await self.appointmentNetworkService?.getAppointments(status: self.isNew == true ? "NEW" : "DONE", page: self.prevPage)
                
                self.isNextPage = appointmentJson?.paging.after != nil
                
                for currentAppointment in appointmentJson?.content ?? [] {
                    
                    appointments.append(AppointmentModel(
                        id: currentAppointment.id,
                        status: self.isNew == true ? "new" : "old",
                        petName: currentAppointment.pet.name,
                        day: currentAppointment.calendarTime[0].calendar.dateAt,
                        time: currentAppointment.calendarTime[0].time,
                        specialization: currentAppointment.employeeSpecializationName,
                        price: currentAppointment.employeeSpecializationPrice,
                        clinicName: currentAppointment.clinic.name,
                        address: currentAppointment.clinic.address,
                        name: "\(currentAppointment.employee.lastName) \(currentAppointment.employee.firstName) \(currentAppointment.employee.middleName)",
                        compliance: currentAppointment.compliance,
                        destination: currentAppointment.conclusions.first(where: { conclusion in
                            conclusion.attribute?.id == "DESTINATION"
                        })?.value ?? "",
                        recomendation: currentAppointment.conclusions.first(where: { conclusion in
                            conclusion.attribute?.id == "RECOMMENDATIONS"
                        })?.value ?? "",
                        hasRating: currentAppointment.hasRating
                    ))
                }
                
                DispatchQueue.main.async {
                    self.view?.reloadTablView()
                }
                
            } catch {
                self.prevPage = -1
                self.isNextPage = true
                self.appointments = []
            }
        }
    }
    
    
}

