//
//  PetTrackerNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 07.09.2023.
//

import Foundation
import Alamofire

protocol PetTrackerNetworkServiceProtocol{
    func createApplication(contact:CreateApplicationRequestJson) async throws -> Bool
}

class PetTrackerNetworkService:PetTrackerNetworkServiceProtocol{
    
    func createApplication(contact:CreateApplicationRequestJson) async throws  -> Bool{
        let url = URL(string: GeneralNetworkService.ControllersUrls.createApplication)!
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .post, parameters: contact, encoder: .json).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 201{
                        continuation.resume(returning: true)
                    }else{
                        continuation.resume(returning: false)
                    }
                case .failure(_):
                    continuation.resume(returning: false)
                }
            }
            
        }
        
        return result
    }
    
}
