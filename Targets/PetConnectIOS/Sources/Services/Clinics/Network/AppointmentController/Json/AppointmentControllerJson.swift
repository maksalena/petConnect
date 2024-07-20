//
//  AppointmentControllerJson.swift
//  PetConnect
//
//  Created by Алёна Максимова on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

class AppointmentJsonResponse{
    
    
    // MARK: - Welcome
    struct AppointmentWelcome: Codable {
        let content: [AppointmentContent]
        let paging: AppointmentPaging

    }
    
    // MARK: - Content
    struct AppointmentContent: Codable {
        let id: UUID
        let pet: Pet
        let compliance: String
        let status: String
        let conclusions: [Conclusion]
        let employeeSpecializationName: String
        let employeeSpecializationPrice: Int
        let clinic: Clinic
        let employee: Employee
        let calendarTime: [CalendarTime]
        let hasRating: Bool
    }
    
    struct Conclusion: Codable {
        let id: UUID
        let value: String
        let attribute:Attribute?
    }
    
    struct Attribute: Codable {
        let id:String
    }
    
    // MARK: - CalendarTime
    struct CalendarTime: Codable {
        let id:UUID
        let calendar: AppointmentCalendar
        let time: String
    }
    
    // MARK: - Calendar
    struct AppointmentCalendar: Codable {
        let id:UUID
        let dateAt: String
    }
    
    // MARK: - Clinic
    struct Clinic: Codable {
        let id:UUID
        let name, address: String
    }
    
    // MARK: - Employee
    struct Employee: Codable {
        let id:UUID
        let email, phone, firstName: String
        let lastName, middleName:String
    }
    
    // MARK: - Pet
    struct Pet: Codable {
        let id:UUID
        let name: String
    }
    
    // MARK: - Paging
    struct AppointmentPaging: Codable {
        let before: String?
        let after: String?
    }
}
