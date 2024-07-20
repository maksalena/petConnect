//
//  DoctorControllerJson.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

final class ClientDoctorsJson{
    struct SearchClinicDoctorsWithCalendarResponse: Codable {
        let content: [OneDoctor]
        let paging: Paging
        let pageSize, pageNumber: Int
    }
    
    struct OneDoctor: Codable {
        let id:UUID
        let email, phone, firstName: String
        let lastName, middleName, experienceAt: String
        let specializations: [SpecializationSpecialization]
        let clinics: [Clinic]
        
        let calendars: Calendars
        let education, info: String
        let rating: Rating?
    }
    
    struct Rating:Codable{
        let avr:Float
        let count:Int
    }
    
    struct SpecializationSpecialization: Codable {
        let id: UUID
        let value: String
        let description: String?
    }
    
    struct Calendars: Codable {
        let id:UUID
        let dateAt: String
        let times: [Time]
    }
    
    struct Time: Codable {
        let id:UUID
        let time: String
//        let appointment: Appointment
    }
    
    struct Clinic: Codable {
        let id:UUID
        let name, address:String
        let specializations: [ClinicSpecialization]
    }
    
    struct ClinicSpecialization: Codable {
        let specialization: SpecializationSpecialization
        let price: Int
    }
    
    struct Paging: Codable {
        let before, after: String?

    }
}

final class AppointmentCreate{
    struct CreateAppointmentRequest: Codable {
        let petID: UUID
        let timeIDS: [UUID]
        let compliance: String
        let employeeSpecializationID: UUID

        enum CodingKeys: String, CodingKey {
            case petID = "petId"
            case timeIDS = "timeIds"
            case compliance
            case employeeSpecializationID = "employeeSpecializationId"
        }

    }
}
