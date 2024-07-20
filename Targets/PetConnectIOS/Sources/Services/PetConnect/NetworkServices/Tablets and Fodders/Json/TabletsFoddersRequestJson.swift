//
//  TabletsFoddersRequestJson.swift
//  PetConnect
//
//  Created by SHREDDING on 07.09.2023.
//

import Foundation

struct CreateTabletsFoddersJsonRequest: Codable {
    let name: String
    let period: [TabletsFoddersOnePeriodJsonResponse]
    let untilAt: String
}

// MARK: - Period
struct TabletsFoddersOnePeriodJsonResponse: Codable {
    var count: Int
    var time: String
}
