//
//  RequestModel.swift
//  PetConnect
//
//  Created by Егор Завражнов on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

struct RequestSelectedModel{
    var pet:PetRequest? = nil
    var compliance:String? = nil
}

struct PetRequest{
    let id:UUID
    let name:String
    let hasClinicAccount:Bool
}
