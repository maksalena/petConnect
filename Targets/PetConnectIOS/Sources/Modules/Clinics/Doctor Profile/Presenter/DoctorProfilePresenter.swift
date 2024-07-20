//
//  DoctorProfilePresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 20.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

protocol DoctorProfileViewProtocol:AnyObject{
    func fillValues()
}

protocol DoctorProfilePresenterProtocol:AnyObject{
    init(view:DoctorProfileViewProtocol, doctor:DoctorModel, clientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol)
    
    var doctor:DoctorModel { get }
    
    func loadDoctor()
}
class DoctorProfilePresenter:DoctorProfilePresenterProtocol{
    weak var view:DoctorProfileViewProtocol?
    
    var doctor:DoctorModel
    
    var clientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol
    
    required init(view:DoctorProfileViewProtocol, doctor:DoctorModel, clientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol) {
        self.view = view
        self.doctor = doctor
        self.clientDoctorsNetworkService = clientDoctorsNetworkService
    }
    
    func loadDoctor(){
        Task{
            do{
                let doctorJson = try await self.clientDoctorsNetworkService.getDoctorById(id: self.doctor.id)
                
                var calendarList: [DoctorModel.DoctorCalendar] = []
                
                for calendar in doctorJson.calendars.times{
                    calendarList.append(
                        DoctorModel.DoctorCalendar(
                            id: calendar.id,
                            time: calendar.time
                        )
                    )
                }
                
                var experienceInt = 0
                
                if let yearString = doctorJson.experienceAt.split(separator: "-").first, let year = Calendar.current.dateComponents([.year], from: Date.now).year{
                    experienceInt = year - (Int(yearString) ?? year)
                }
                
                var doctorClinics:[DoctorModel.Clinic] = []
                
                for doctorClinic in doctorJson.clinics {
                    doctorClinics.append(
                        DoctorModel.Clinic(
                            title: doctorClinic.name,
                            Address: doctorClinic.address
                        )
                    )
                }
                
                var doctorSpecializations:[SpecializationModel] = []
                
                for doctorSpecialization in doctorJson.specializations {
                    doctorSpecializations.append(
                        SpecializationModel(
                            id: doctorSpecialization.id,
                            value: doctorSpecialization.value,
                            price: -1
                        )
                    )
                }
                
                self.doctor.id = doctorJson.id
                self.doctor.email = doctorJson.email
                self.doctor.phone = doctorJson.phone
                self.doctor.firstName = doctorJson.firstName
                self.doctor.lastName = doctorJson.lastName
                
                self.doctor.middleName = doctorJson.middleName
                self.doctor.experience = experienceInt
                self.doctor.clinics = doctorClinics
                self.doctor.education = doctorJson.education
                self.doctor.info = doctorJson.info
                self.doctor.specializations = doctorSpecializations
                self.doctor.calendar = calendarList
                
                DispatchQueue.main.async {
                    self.view?.fillValues()
                }
                
            }catch{
                
            }
        }
    }
}
