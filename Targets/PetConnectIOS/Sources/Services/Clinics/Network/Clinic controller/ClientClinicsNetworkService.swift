//
//  ClinicsNetworkService.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation
import Alamofire

enum ClientClinicsErrors:Error{
    case refreshToken
    case unknown
    case CONFLICT
}

protocol ClientClinicsNetworkServiceProtocol{
    
    func searchClinics(page:Int) async throws -> ClientClinicsJson.SearchClinicsResponse
}

class ClientClinicsNetworkService:ClientClinicsNetworkServiceProtocol{
    
    func searchClinics(page: Int) async throws -> ClientClinicsJson.SearchClinicsResponse {
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientClinics.searchClinicsUrl(page: page))
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()
        
        let result:ClientClinicsJson.SearchClinicsResponse = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url!, method: .get, headers: headers.getHeaders()).response { response in
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                
                switch response.result {
                case .success(let success):
                    
                    if let decoded = try? JSONDecoder().decode(ClientClinicsJson.SearchClinicsResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decoded)
                    }else{
                        continuation.resume(throwing: ClientClinicsErrors.unknown)
                    }
                    
                case .failure(_):
                    continuation.resume(throwing: ClientClinicsErrors.unknown)
                }
            }
        }
        
        return result
    }
    
}
