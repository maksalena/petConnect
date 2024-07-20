//
//  UserDefaultsService.swift
//  PetConnect
//
//  Created by SHREDDING on 30.10.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

protocol UserDefaultsServiceProtocol{
    func isFirstLaunch() -> Bool
}

class UserDefaultsService:UserDefaultsServiceProtocol{
    enum Keys{
        static let isFirstLaunch = "isFirstLaunch"
    }
    
    let userDefaults = UserDefaults.standard
    
    func isFirstLaunch() -> Bool{
        if let _ = userDefaults.object(forKey: Keys.isFirstLaunch){
            return false
        }
        
        userDefaults.set(true, forKey: Keys.isFirstLaunch)
        
        return true
    }
}
