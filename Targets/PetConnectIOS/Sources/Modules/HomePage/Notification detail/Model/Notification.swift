//
//  Notification.swift
//  PetConnect
//
//  Created by Алёна Максимова on 20.08.2023.
//

import Foundation
import UIKit

enum Category {
    case food
    case medicine
    
    func getTitle() -> String {
        switch self {
            
        case .food:
            return "Корм"
        case .medicine:
            return "Лекарство"
        }
    }
    
    func getCategory(category: String) -> Category {
        switch category {
        case "Корм":
            return .food
        case "Лекарство":
            return .medicine
        default:
            return .food
        }
    }
    
    func getImage() -> UIImage? {
        switch self {
        
        case .food:
            return UIImage(named: "dogBowl")
        case .medicine:
            return UIImage(named: "dogMedicine")
        }
    }
    
    func getBackgroundColor() -> UIColor? {
        switch self {
        
        case .food:
            return UIColor(named: "foodNotifCell")
        case .medicine:
            return UIColor(named: "medicineNotifCell")
        }
    }
}

struct Notification {
    var name: String = ""
    var date: String = ""
    var category: Category = .food
    var prescriptions: [TabletsFoddersOnePeriodJsonResponse] = []
    
    mutating func setName(name: String){
        self.name = name
    }
    mutating func setDate(date: String){
        self.date = date
    }
    mutating func setCategory(category: String){
        self.category = self.category.getCategory(category: category)
    }
    mutating func setPrescriptions(prescriptions: [TabletsFoddersOnePeriodJsonResponse]){
        self.prescriptions = prescriptions
    }
    
    func getName() -> String {
        return name
    }
    func getDate() -> String {
        return date
    }
    func getCategory() -> Category {
        return category
    }
    func getPrescriptions() -> [TabletsFoddersOnePeriodJsonResponse] {
        return prescriptions
    }
    
    /// - Returns: true - if data is empty
    func isEmptyData()->Bool{
        if name.isEmpty || date.isEmpty || category.getTitle().isEmpty {
            return true
        }
        return false
    }
}

class NotificationPlaceholder {
    static var notifications: [Notification] = []
}
