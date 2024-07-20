//
//  DoctorModel.swift
//  PetConnect
//
//  Created by Егор Завражнов on 22.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

struct DoctorModel{
    var id:UUID
    var email:String
    var phone:String
    var firstName:String
    var lastName:String
    var middleName:String
    var experience:Int // in years
    var specialization:SpecializationModel
    var clinics:[Clinic]
    var education:String
    var info:String
    var mark:(avr:Float, num:Int)

    
    var specializations:[SpecializationModel]
    
    var calendar:[DoctorCalendar]
    
    struct DoctorCalendar{
        var id:UUID
        var time:String
    }
    
    struct Clinic{
        var title:String
        var Address:String
    }
    
}

struct SpecializationModel{
    var id:UUID
    var value:String
    var price:Int
}
