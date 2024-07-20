//
//  PetJsonResponse.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation

import Foundation

// MARK: - Get All Pets
struct AllPetsJsonResponse: Codable {
    let content: [OnePetJsonResponse]
    let paging: Paging
    let pageSize, pageNumber: Int
}

// MARK: - Content
struct OnePetJsonResponse: Codable {
    let id:UUID
    let name, breed, sex: String
    let dateOfBirth, createdAt, updateAt: String
    let type:String
    let hasClinicAccount: Bool
    
    let avatars: [AvatarJsonResponse]
    let identifications: [OneIdentificationResponse]
}

// MARK: - Paging
struct Paging: Codable {
    let before, after: String?
}


struct GetIdentificationsResponseJson: Codable {
    let content: [OneIdentificationResponse]
    let paging: Paging
    let pageSize, pageNumber: Int
}

// MARK: - Content
struct OneIdentificationResponse: Codable {
    let id:UUID
    let number, location: String
    let microChippedAt:String?
    let tattooingAt: String?
    let tattooNumber, distinctiveMark, reproductionData: String
    let createdAt, updateAt: String
}

// MARK: - Avatar
struct AvatarJsonResponse: Codable {
    let fileID: UUID?
    let filePath: String?
    let enable: Bool

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case filePath, enable
    }
}
