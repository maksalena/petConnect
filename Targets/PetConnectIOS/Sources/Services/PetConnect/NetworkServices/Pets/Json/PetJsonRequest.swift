//
//  PetJsonRequest.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation

struct createPetRequestJson: Codable {
    let name:String
    let breed:String
    let sex:String
    let dateOfBirth:String
    let type:String
}

struct CreateIdentificationRequestJson:Codable{
    let number, microChippedAt, location, tattooNumber: String
    let tattooingAt, distinctiveMark, reproductionData: String
}
