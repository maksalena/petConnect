//
//  ChooseDoctorPresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 22.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

protocol ChooseDoctorViewControllerProtocol:AnyObject{
    func reloadDoctorsList()
}

protocol ChooseDoctorPresenterProtocol:AnyObject{
    init(view:ChooseDoctorViewControllerProtocol, choosenData:(clinic:PetClinicModel, specialistIndex:Int?), clientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol)
    
    var doctors:[DoctorModel] { get }
    
    var clinic:PetClinicModel { get }
    var specialistIndex:Int? { get }
    
    var isNextPage:Bool { get }
    

    func searchDoctors(date:Date,reload:Bool)
    
}

class ChooseDoctorPresenter:ChooseDoctorPresenterProtocol{
    weak var view:ChooseDoctorViewControllerProtocol?
    
    var clientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol
    
    var doctors: [DoctorModel] = []
    
    var clinic:PetClinicModel
    var specialistIndex:Int?
    
    private var prevPage:Int = -1
    public var isNextPage:Bool = true
    
    
    required init(view:ChooseDoctorViewControllerProtocol, choosenData:(clinic:PetClinicModel, specialistIndex:Int?), clientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol) {
        self.view = view
        self.clientDoctorsNetworkService = clientDoctorsNetworkService
        self.clinic = choosenData.clinic
        self.specialistIndex = choosenData.specialistIndex
    }
    
    func searchDoctors(date:Date, reload: Bool) {
        if reload{
            self.prevPage = -1
            self.isNextPage = true
            self.doctors = []
        }
        
        if !self.isNextPage{
            return
        }
        
        Task{
            
            do {
                prevPage += 1
                let doctorsJson = try await self.clientDoctorsNetworkService.getClinicDoctorsWithCalendar(
                    specializationId: self.specialistIndex == nil ? nil : self.clinic.specializations[self.specialistIndex!].id,
                    clinicId: self.clinic.clinicId,
                    dateAt: date, // TODO

                    page: self.prevPage
                )
                
                self.isNextPage = doctorsJson.paging.after != nil

                
                DispatchQueue.main.async {
                    for doctor in doctorsJson.content{
                                                
                        var calendarList: [DoctorModel.DoctorCalendar] = []
                        
                        for calendar in doctor.calendars.times{

                            let compareDate = date > Date.now ? .now : date
                            
                            if date > .now || Date.timeStringToDate(date: date, time: calendar.time) > Date.now{
                                calendarList.append(
                                    DoctorModel.DoctorCalendar(
                                        id: calendar.id,
                                        time: calendar.time
                                    )
                                )
                            }
                            
//                            if Date.timeStringToDate(date: date > Date.now ? .now : date, time: calendar.time) > Date.now{
//                                calendarList.append(
//                                    DoctorModel.DoctorCalendar(
//                                        id: calendar.id,
//                                        time: calendar.time
//                                    )
//                                )
//                            }
                            
//                            calendarList.append(
//                                DoctorModel.DoctorCalendar(
//                                    id: calendar.id,
//                                    time: calendar.time
//                                )
//                            )
                            

                        }
                        
                        
                        
                        var experienceInt = 0
                        
                        if let yearString = doctor.experienceAt.split(separator: "-").first, let year = Calendar.current.dateComponents([.year], from: Date.now).year{
                            experienceInt = year - (Int(yearString) ?? year)
                        }
                        
                        var doctorClinics:[DoctorModel.Clinic] = []
                        
                        for doctorClinic in doctor.clinics {
                            doctorClinics.append(
                                DoctorModel.Clinic(
                                    title: doctorClinic.name,
                                    Address: doctorClinic.address
                                )
                            )
                        }
                        
                        var doctorSpecializations:[SpecializationModel] = []
                        
                        for doctorSpecialization in doctor.specializations {
                            doctorSpecializations.append(
                                SpecializationModel(
                                    id: doctorSpecialization.id,
                                    value: doctorSpecialization.value,
                                    price: -1
                                )
                            )
                        }
                        
                        if let choosenIndex = self.specialistIndex{
                            let newDoctor = DoctorModel(
                                id: doctor.id,
                                email: doctor.email,
                                phone: doctor.phone,
                                firstName: doctor.firstName,
                                lastName: doctor.lastName,
                                middleName: doctor.middleName,
                                experience: experienceInt,
                                specialization: .init(
                                    id: self.clinic.specializations[choosenIndex].id,
                                    value: self.clinic.specializations[choosenIndex].value,
                                    price: self.clinic.specializations[choosenIndex].price
                                ),
                                clinics: doctorClinics,
                                education: doctor.education,
                                info: doctor.info,

                                mark: (avr: doctor.rating?.avr ?? 0.0, num: doctor.rating?.count ?? 0),
                                specializations: doctorSpecializations,
                                calendar: calendarList
                            )
                            if !calendarList.isEmpty{
                                self.doctors.append(newDoctor)
                            }

                        }else{
                            for clinicSpecialization in self.clinic.specializations {
                                
                                if doctor.specializations.contains(where: { doctorSpecialization in
                                    doctorSpecialization.id == clinicSpecialization.id
                                }){
                                    let newDoctor = DoctorModel(
                                        id: doctor.id,
                                        email: doctor.email,
                                        phone: doctor.phone,
                                        firstName: doctor.firstName,
                                        lastName: doctor.lastName,
                                        middleName: doctor.middleName,
                                        experience: experienceInt,
                                        specialization: .init(
                                            id: clinicSpecialization.id,
                                            value: clinicSpecialization.value,
                                            price: clinicSpecialization.price
                                        ),
                                        clinics: doctorClinics,
                                        education: doctor.education,

                                        info: doctor.info, 
                                        mark: (avr: doctor.rating?.avr ?? 0.0, num: doctor.rating?.count ?? 0),
                                        specializations: doctorSpecializations,
                                        calendar: calendarList
                                    )
                                    if !calendarList.isEmpty{
                                        self.doctors.append(newDoctor)
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    self.view?.reloadDoctorsList()
                }
            } catch{
                self.prevPage = -1
                self.isNextPage = true
                self.doctors = []
            }
//            do{
//                let doctorsJson = try await self.clientDoctorsNetworkService.searchDoctors(page: self.prevPage + 1)
//                self.isNextPage = doctorsJson.paging.after != nil
//                
//                DispatchQueue.main.async {
//                    for doctor in doctorsJson.content{
//                        
//                        var specializations:[SpecializationModel] = []
//                        
//                        for specializationJson in doctor.specializations {
//                            let newSpecialization = SpecializationModel(
//                                id: specializationJson.id,
//                                value: specializationJson.value
//                            )
//                            specializations.append(newSpecialization)
//                        }
//                        
//                        var experienceInt = 0
//                        
//                        if let yearString = doctor.experienceAt.split(separator: "-").first, let year = Calendar.current.dateComponents([.year], from: Date.now).year{
//                            experienceInt = year - (Int(yearString) ?? year)
//                        }
//                        
//                        
//                        let newDoctor = DoctorModel(
//                            id: doctor.id,
//                            email: doctor.email,
//                            phone: doctor.phone,
//                            firstName: doctor.firstName,
//                            lastName: doctor.lastName,
//                            middleName: doctor.middleName,
//                            experience: experienceInt,
//                            specializations: specializations
//                        )
//                        
//                        self.doctors.append(newDoctor)
//                    }
//                    
//                    self.view?.reloadDoctorsList()
//                }
//
//            } catch{
//                
//            }
        }
    }
    
}

