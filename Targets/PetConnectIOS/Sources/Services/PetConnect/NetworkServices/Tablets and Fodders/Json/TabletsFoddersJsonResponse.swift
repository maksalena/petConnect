//
//  TabletsFoddersJsonResponse.swift
//  PetConnect
//
//  Created by SHREDDING on 07.09.2023.
//

import Foundation

// MARK: - Welcome
struct FindAllTabletsFoddersJsonResponse: Codable {
    let content: [TabletsFoddersContent]
}

// MARK: - Content
struct TabletsFoddersContent: Codable {
    let id:UUID
    let name: String
    let periods: [TabletsFoddersOnePeriodJsonResponse]
    let untilAt, createdAt, updateAt: String
}
