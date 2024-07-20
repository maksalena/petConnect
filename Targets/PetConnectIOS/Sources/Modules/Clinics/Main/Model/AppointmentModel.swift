//
//  AppointmentModel.swift
//  PetConnect
//
//  Created by Алёна Максимова on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

struct AppointmentModel {
    var id: UUID
    var status: String
    var petName: String
    var day: String
    var time: String
    var specialization: String
    var price: Int
    var clinicName: String
    var address: String
    var name: String
    var compliance: String
    var destination:String
    var recomendation:String
    var hasRating: Bool
}
