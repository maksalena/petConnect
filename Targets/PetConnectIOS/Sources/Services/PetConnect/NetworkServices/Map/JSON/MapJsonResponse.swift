//
//  MapJsonResponse.swift
//  PetConnect
//
//  Created by Алёна Максимова on 15.09.2023.
//

import Foundation

// MARK: - Create Marker
struct CreatedMarkerJsonResponse: Codable {
    let id, userID, title, description: String
    let type: String
    let location: [[Double]]
    let createdAt, updateAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title, description, type, location, createdAt, updateAt
    }
}

// MARK: - Get Marker
struct MarkerJsonResponse: Codable {
    let id: String
    let user: User
    let title, description, type: String
    let location: [[Double]]
    let likes, dislikes: Int
    let myLike: MyLike
    let createdAt, updateAt: String
    let favorite: Bool
}

// MARK: - User
struct User: Codable {
    let id, username: String
    let avatars: [Avatar]
}

// MARK: - MyLike
struct MyLike: Codable {
    let isLike: String
}

// MARK: - Avatar
struct Avatar: Codable {
    let fileID: String
    let filePath: String
    let enable: Bool
    let createdAt, updateAt: String

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case filePath, enable, createdAt, updateAt
    }
}


// MARK: - Search for markers
struct FoundMarkersJsonResponse: Codable {
    let id, userID, title, description: String
    let type: String
    let location: [[Double]]
    let createdAt, updateAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title, description, type, location, createdAt, updateAt
    }
}

typealias Markers = [FoundMarkersJsonResponse]

// MARK: - Favorites
struct Favorites: Codable {
    let content: [Content]
    let paging: Paging
    let pageSize, pageNumber: Int
}

// MARK: - Content
struct Content: Codable {
    let id: ID
    let createdAt, updateAt: String
}

// MARK: - ID
struct ID: Codable {
    let walkingMarker: WalkingMarker
}

// MARK: - WalkingMarker
struct WalkingMarker: Codable {
    let id, userID, title, description: String
    let type: String
    let location: [[Double]]
    let createdAt, updateAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title, description, type, location, createdAt, updateAt
    }
}
