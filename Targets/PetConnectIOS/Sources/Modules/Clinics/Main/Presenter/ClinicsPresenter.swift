//
//  ClinicsPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.10.2023.
//

import UIKit
import RealmSwift

protocol ClinicsViewProtocol: AnyObject {
    func fillNewAppointments()
    func fillOldAppointments()
}

protocol ClinicsPresenterProtocol: AnyObject {
    init(
        view: ClinicsViewProtocol,
        clinicsNetworkService: AppointmentClinicsNetworkServiceProtocol,
        filesNetworkService: FilesNetworkServiceProtocol,
        keychainService: KeyChainStorageProtocol
    )
    
    var newAppointments: [AppointmentModel] { get }
    var oldAppointments: [AppointmentModel] { get }
    
    func loadNewAppointment()
    func loadOldAppointment()
    func declineTapped(id: UUID)
    
}

class ClinicsPresenter: ClinicsPresenterProtocol {
    
    weak var view: ClinicsViewProtocol?
    var newAppointments:[AppointmentModel] = []
    var oldAppointments:[AppointmentModel] = []
    var index = "00"
    var clinicsNetworkService: AppointmentClinicsNetworkServiceProtocol?
    var filesNetworkService: FilesNetworkServiceProtocol?
    var keychainService: KeyChainStorageProtocol?
    
    
    required init(
        view: ClinicsViewProtocol,
        clinicsNetworkService: AppointmentClinicsNetworkServiceProtocol,
        filesNetworkService: FilesNetworkServiceProtocol,
        keychainService: KeyChainStorageProtocol) {
            self.view = view
            self.clinicsNetworkService = clinicsNetworkService
            self.filesNetworkService = filesNetworkService
            self.keychainService = keychainService
        }
    
    func loadNewAppointment() {
        newAppointments = []
        Task{
            do{
                let appointmentJson = try await self.clinicsNetworkService?.getAppointments(status: "NEW", page: 0)
                
                for currentAppointment in appointmentJson?.content ?? [] {
                    
                    newAppointments.append(AppointmentModel(
                        id: currentAppointment.id,
                        status: "new",
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
                    self.view?.fillNewAppointments()
                }
                
            } catch {
                print(123)
            }
        }
    }
    
    func loadOldAppointment() {
        oldAppointments = []
        Task{
            do{
                let appointmentJson = try await self.clinicsNetworkService?.getAppointments(status: "DONE", page: 0)
                
                for currentAppointment in appointmentJson?.content ?? [] {
                    
                    oldAppointments.append(AppointmentModel(
                        id: currentAppointment.id,
                        status: "old",
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
                    self.view?.fillOldAppointments()
                }
                
            } catch {
                print(1234)
            }
        }
    }
    
    func declineTapped(id: UUID) {
        Task{
            do{
                try await self.clinicsNetworkService?.declineAppointment(id: id)
                
            } catch {
                print(12345)
            }
        }
    }
}
