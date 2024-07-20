//
//  PetClinicModel.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

struct PetClinicModel{
    let clinicId:UUID
    let title:String
    let address:String
    let schedule:String?
    let description:String
    let phone:String
    
    let specializations:[Specialization]
    
    struct Schedule{
        let startTime:Date
        let endDate:Date
    }
    
    struct Specialization{
        let id:UUID
        let value: String
        let price: Int
        
        let description: String?
    }
}
