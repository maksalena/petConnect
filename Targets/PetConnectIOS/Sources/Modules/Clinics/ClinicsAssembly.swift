//
//  ClinicsAssembly.swift
//  PetConnect
//
//  Created by SHREDDING on 23.10.2023.
//

import Foundation
import UIKit

protocol ClinicsAssemblyProtocol{
    static func createClinicsListViewController() -> UIViewController
    static func createAppointmentListViewController(isNew:Bool) -> UIViewController
    static func createClinicProfileViewController() -> UIViewController
    
    static func createAppointmentTypeViewController(clinic: PetClinicModel) -> UIViewController
    static func createSpecialistViewController(clinic: PetClinicModel) -> UIViewController
    static func createServiceViewController() -> UIViewController
    static func createChooseDoctorViewController(choosenData: (clinic: PetClinicModel, specialistIndex: Int?)) -> UIViewController
    static func createDoctorProfileViewController(doctor:DoctorModel) -> UIViewController

    static func createDeclineViewController(appointment: AppointmentModel) -> UIViewController
    static func createRequestViewController(dateTime:(date:Date, timeId:UUID, timeString:String),doctor:DoctorModel, clinic:PetClinicModel) -> UIViewController
    static func createCheckDataViewController(
        dateTime: (
            date: Date,
            timeId: UUID,
            timeString: String
        ),
        doctor: DoctorModel,
        clinic: PetClinicModel,
        pet: PetRequest,
        compilance: String
    ) -> UIViewController

}

class ClinicsAssembly:ClinicsAssemblyProtocol {
    
    static func createClinicsListViewController() -> UIViewController {
        let view = ClinicsListViewController(navBar: .withBackButton, title: "Ветклиники")
        view.hidesBottomBarWhenPushed = true
        
        let clientClinicsNetworkService = ClientClinicsNetworkService()
        let presenter = ClinicsListPresenter(view: view, clientClinicsNetworkService: clientClinicsNetworkService)
        view.presenter = presenter
        
        return view
    }
    
    static func createAppointmentListViewController(isNew:Bool) -> UIViewController {
        let view = AppointmentListViewController(navBar: .withBackButton, title: "Все записи")
        view.hidesBottomBarWhenPushed = true
        
        let appointmentClinicsNetworkService = AppointmentClinicsNetworkService()
        let presenter = AppointmentListPresenter(view: view, appointmentNetworkService: appointmentClinicsNetworkService, isNew: isNew)
        view.presenter = presenter
        
        return view
    }
    
    static func createClinicProfileViewController() -> UIViewController {
        let view = ClinicProfileViewController(navBar: .withBackButton, backgroundColor: .clear)
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    static func createAppointmentTypeViewController(clinic: PetClinicModel) -> UIViewController {
        let view = AppointmentTypeViewController(navBar: .withBackButton,title: "Выберите способ записи")
        
        let presenter = AppointmentTypePresenter(view: view, clinic: clinic)
        view.presenter = presenter
        
        return view
    }
    
    static func createSpecialistViewController(clinic: PetClinicModel) -> UIViewController {
        let view = SpecialistViewController(navBar: .withBackButton, title: "Выберите специализацию")
        let presenter = SpecialistPresenter(view: view, clinic: clinic)
        view.presenter = presenter
        return view
    }
    
    static func createServiceViewController() -> UIViewController {
        let view = ServiceViewController(navBar: .withBackButton, title: "Выберите услугу")
        return view
    }
    
    static func createDoctorProfileViewController(doctor:DoctorModel) -> UIViewController {

        let view = DoctorProfileViewController(navBar: .withBackButton,title: "Врач", backgroundColor: .clear)

        
        let clientDoctorsNetworkService = ClientDoctorsNetworkService()
        let presenter = DoctorProfilePresenter(view: view, doctor: doctor, clientDoctorsNetworkService: clientDoctorsNetworkService)
        view.presenter = presenter
        return view
    }
    
    static func createChooseDoctorViewController(choosenData: (clinic: PetClinicModel, specialistIndex: Int?)) -> UIViewController {

        let view = ChooseDoctorViewController(navBar: .withBackButton, title: "Выберите врача и время", backgroundColor: .clear)

        
        let clientDoctorsNetworkService = ClientDoctorsNetworkService()
        
        let presenter = ChooseDoctorPresenter(view: view, choosenData: (clinic: choosenData.clinic, specialistIndex: choosenData.specialistIndex), clientDoctorsNetworkService: clientDoctorsNetworkService)
        
        view.presenter = presenter
        return view
    }
    

    static func createDeclineViewController(appointment: AppointmentModel) -> UIViewController {
        let view = DeclineAppointmentViewController(navBar: .withBackButton,title: "Детали записи", backgroundColor: .clear)
        view.hidesBottomBarWhenPushed = true
        
        
        let clinicsNetworkService = AppointmentClinicsNetworkService()
        let filesNetworkService = FilesNetworkService()
        let keychainService = KeyChainStorage()
        
        let presenter = DeclineAppointmentPresenter(view: view, appointment: appointment, clinicsNetworkService: clinicsNetworkService, filesNetworkService: filesNetworkService, keychainService: keychainService)

        view.presenter = presenter
        
        return view
    }
    
    static func createRequestViewController(dateTime:(date:Date, timeId:UUID, timeString:String), doctor:DoctorModel, clinic:PetClinicModel) -> UIViewController {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU") // Установка русской локали для названия месяцев и дней недели

        let formattedDate = dateFormatter.string(from: dateTime.date)
        
        let view = RequestViewController(navBar: .withBackButton, title: "\(formattedDate), \(dateTime.timeString)", backgroundColor: .clear)
        
        let petsNetworkService = PetsNetworkService()
        let presenter = RequestPresenter(
            view: view,
            dateTime: dateTime,
            doctor:doctor,
            clinic:clinic,
            petsNetworkService: petsNetworkService
        )
        
        view.presenter = presenter
        return view
    }
    
    static func createCheckDataViewController(
        dateTime: (
            date: Date,
            timeId: UUID,
            timeString: String),
        doctor: DoctorModel,
        clinic: PetClinicModel,
        pet: PetRequest,
        compilance: String
    ) -> UIViewController {
        let view = CheckDataViewController(navBar: .withBackButton, title: "Подтвердите данные", backgroundColor: .clear)
        
        
        let petsNetworkService = PetsNetworkService()
        let appointmentNetworkService = ClientDoctorsNetworkService()
        let presenter = CheckDataPresenter(
            view: view,
            dateTime: dateTime,
            doctor: doctor,
            clinic: clinic,
            pet: pet,
            compilance: compilance,
            petsNetworkService: petsNetworkService,
            appointmentNetworkService: appointmentNetworkService
        )
        
        view.presenter = presenter
        return view
    }
}
