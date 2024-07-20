//
//  CheckDataPresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

protocol CheckDataViewProtocol:AnyObject{
    func fillValues()
    
    func appointmentAdded()
    func conflictTime()
    func unknownError()
}

protocol CheckDataPresenterProtocol:AnyObject{
    init(
        view:CheckDataViewProtocol,
        dateTime:(
            date:Date,
            timeId:UUID,
            timeString:String),
        doctor:DoctorModel,
        clinic:PetClinicModel,
        pet:PetRequest,
        compilance:String,
        petsNetworkService:PetsNetworkServiceProtocol,
        appointmentNetworkService:ClientDoctorsNetworkServiceProtocol
    )
    
    var dateTime:(date:Date, timeId:UUID, timeString:String) { get }
    var doctor:DoctorModel { get }
    var clinic:PetClinicModel { get }
    var pet:PetRequest { get }
    var compilance:String { get }
    
    func viewWillAppear()
    
    func addAppointment()
}

class CheckDataPresenter:CheckDataPresenterProtocol{
    
    weak var view:CheckDataViewProtocol?
    
    var dateTime:(date:Date, timeId:UUID, timeString:String)
    var doctor:DoctorModel
    var clinic:PetClinicModel
    var pet:PetRequest
    var compilance:String
    
    var petsNetworkService:PetsNetworkServiceProtocol
    
    var appointmentNetworkService:ClientDoctorsNetworkServiceProtocol
    
    required init(
        view: CheckDataViewProtocol,
        dateTime: (date: Date, timeId: UUID, timeString: String),
        doctor: DoctorModel,
        clinic: PetClinicModel,
        pet: PetRequest,
        compilance: String,
        
        petsNetworkService:PetsNetworkServiceProtocol,
        appointmentNetworkService:ClientDoctorsNetworkServiceProtocol
    ) {
        self.view = view
        self.dateTime = dateTime
        self.doctor = doctor
        self.clinic = clinic
        self.pet = pet
        self.compilance = compilance
        self.petsNetworkService = petsNetworkService
        self.appointmentNetworkService = appointmentNetworkService
        
        
    }
    
    func viewWillAppear(){
        view?.fillValues()
    }
    
    func addAppointment(){
        Task{
            
            do {
                if !pet.hasClinicAccount{
                    try await petsNetworkService.integratePet(petId:pet.id)
                }
                
                try await appointmentNetworkService.createAppointment(
                    appointment: AppointmentCreate.CreateAppointmentRequest(
                        petID: pet.id,
                        timeIDS: [dateTime.timeId],
                        compliance: compilance,
                        employeeSpecializationID: doctor.specialization.id
                    )
                )
                DispatchQueue.main.async {
                    self.view?.appointmentAdded()
                }
                
            } catch ClientClinicsErrors.CONFLICT{
                DispatchQueue.main.async {
                    self.view?.conflictTime()
                }
                
            } catch{
                DispatchQueue.main.async {
                    self.view?.unknownError()
                }
            }
            
            

        }
    }
    
}
