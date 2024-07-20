//
//  ClientClinicsJson.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

final class ClientClinicsJson{
    struct SearchClinicsResponse: Codable {
        let content: [Content]
        let paging: Paging
        let pageSize, pageNumber: Int
    }

    // MARK: - Content
    struct Content: Codable {
        let id:UUID
        let name, address: String
        let schedule:String?
        let description:String
        let phone: String?
        
        let specializations: [SpecializationElement]
    }
    
    struct SpecializationElement: Codable {
        let specialization: SpecializationSpecialization
        let price: Int
    }
    
    struct SpecializationSpecialization: Codable {
        let id:UUID
        let value: String
        let description: String?
    }

    // MARK: - Paging
    struct Paging: Codable {
        let before, after: String?
    }
}
