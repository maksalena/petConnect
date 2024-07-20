//
//  MapRequestJson.swift
//  PetConnect
//
//  Created by Алёна Максимова on 15.09.2023.
//

import Foundation

// MARK: - Map

struct createPointRequestJson: Codable {
    let title, description, type: String
    let location: Location
    let radiusMeters: Double
}

struct Location: Codable {
    let x, y: Double
}

// MARK: - Likes

struct setMyLike: Codable {
    let walkingMarkerID, isLike: String

    enum CodingKeys: String, CodingKey {
        case walkingMarkerID = "walkingMarkerId"
        case isLike
    }
}

struct setFavorite: Codable {
    let walkingMarkerID: String

    enum CodingKeys: String, CodingKey {
        case walkingMarkerID = "walkingMarkerId"
    }
}
