//
//  TimeValidation.swift
//  PetConnect
//
//  Created by Алёна Максимова on 04.09.2023.
//

import UIKit

class TimeValidation {
    
    /// Validator for time string
    /// - Parameter value: time value
    /// - Returns: true - if time is avaliable
    static func validateTime(value:String)->Bool{

        let timeRegex = "^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$"
        
        let timePred = NSPredicate(format:"SELF MATCHES %@", timeRegex)
        
        return timePred.evaluate(with: value)
        
        
    }
}
