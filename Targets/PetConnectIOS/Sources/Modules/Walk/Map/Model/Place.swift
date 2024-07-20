//
//  Place.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.09.2023.
//

import Foundation
import CoreLocation

enum PlaceCategory {
    case walking
    case playground
    case dangerous
    
    func getTitle() -> String {
        switch self {
            
        case .walking:
            return "Место для прогулок"
        case .playground:
            return "Dog friendly заведения"
        case .dangerous:
            return "Опасные места"
        }
    }
    
    init (category: String) {
        switch category {
        case "WALKS":
            self = .walking
        case "DOG_FRIENDLY":
            self = .playground
        case "DANGEROUS":
            self = .dangerous
        default:
            self = .walking
        }
    }
}

struct Place {
    var id: UUID
    var name: String = ""
    var description: String = ""
    var category: PlaceCategory = .walking
    
    var lattitude: CLLocationDegrees = 0
    var longtitude: CLLocationDegrees = 0
    
    mutating func setName(name: String){
        self.name = name
    }
    mutating func setDescription(description: String){
        self.description = description
    }
    mutating func setCategory(category: String){
        self.category = .init(category: category)
    }
    
    func getName() -> String {
        return name
    }
    func getDescription() -> String {
        return description
    }
    func getCategory() -> PlaceCategory {
        return category
    }
    
    /// - Returns: true - if data is empty
    func isEmptyData()->Bool{
        if name.isEmpty || description.isEmpty || description.count > 100 || category.getTitle().isEmpty {
            return true
        }
        return false
    }
}
