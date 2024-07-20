//
//  WalkJsonResponse.swift
//  PetConnect
//
//  Created by SHREDDING on 10.09.2023.
//

import Foundation

// MARK: - Welcome
struct FindWalksJsonResponse: Codable {
    let content: [OneWalkJsonResponse]
    let pageSize, pageNumber: Int
}

// MARK: - Content
struct OneWalkJsonResponse: Codable {
    let id: UUID
    let pet: OnePetJsonResponse
    let updateAt:String
    let dc: Bool
}
