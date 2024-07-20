//
//  DateValidation.swift
//  PetConnect
//
//  Created by Алёна Максимова on 04.09.2023.
//

import UIKit

class DateValidation {
    
    /// Validator for date string
    /// - Parameter value: date value
    /// - Returns: true - if date is avaliable
    static func validateDate(value:String)->Bool{

        let dateRegex = "[0-9]{2}.[0-9]{2}.[0-9]{4}"
        
        let datePred = NSPredicate(format:"SELF MATCHES %@", dateRegex)
        
        return datePred.evaluate(with: value)
        
        
    }
}
