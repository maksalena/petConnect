//
//  SignUpModel.swift
//  PetConnect
//
//  Created by SHREDDING on 15.08.2023.
//

import Foundation

struct SignUpModel{
    var firstName:String = ""
    var secondName:String = ""
    var middleName:String = ""
    
    var username:String = ""
    var email:String = ""
    var phone:String = ""
    var password:String = ""
    var confirmPassword:String = ""
    
    
    /// check username or email or password or confirmPassword is empty
    /// - Returns: true - if atleast one value is empty
    func isEmptyData()->Bool{
        return username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || phone.isEmpty || firstName.isEmpty || secondName.isEmpty
    }
}
