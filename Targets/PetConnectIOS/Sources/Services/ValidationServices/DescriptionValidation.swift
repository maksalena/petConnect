//
//  DescriptionValidation.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.09.2023.
//

import UIKit

class DescriptionValidation {
    
    /// Validator for time string
    /// - Parameter value: string value
    /// - Returns: true - if value length is less than 100
    static func validateDescription(value:String)->Bool{

        return (value.count < 100)
        
        
    }
}
