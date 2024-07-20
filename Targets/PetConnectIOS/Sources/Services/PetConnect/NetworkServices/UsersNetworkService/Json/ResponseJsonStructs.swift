//
//  ResponseJsonStructs.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation

struct MeResponseJsonStruct: Decodable{
    let id:String
    
    let firstName:String?
    let lastName:String?
    let middleName:String?
    
    let email:String
    let username:String
    let phone:String
    let hasClinicAccount:Bool
    let createdAt:String
    let updateAt:String
    
    let avatars:[AvatarJsonResponse]
}
