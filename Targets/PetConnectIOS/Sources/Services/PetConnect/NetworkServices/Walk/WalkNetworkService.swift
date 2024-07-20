//
//  WalkNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 10.09.2023.
//

import Foundation
import Alamofire

enum WalksErrors:Error{
    case refreshToken
    case unknown
}

protocol WalkNetworkServiceProtocol{
    func findWalks(isActive:Bool) async throws -> FindWalksJsonResponse
    func startWalk(petId:UUID) async throws -> OneWalkJsonResponse
    func endWalk(petId:UUID, walkId:UUID, dc:Bool) async throws -> Bool
}

class WalkNetworkService:WalkNetworkServiceProtocol{
    func findWalks(isActive:Bool) async throws -> FindWalksJsonResponse{
        let url = URL(string: GeneralNetworkService.WalksControllerUrls.findAll() + "?isActive=\(isActive)&page=0&size=1000")!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:FindWalksJsonResponse = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: WalksErrors.refreshToken)}
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):

                    if let decodedData = try? JSONDecoder().decode(FindWalksJsonResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: WalksErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: WalksErrors.unknown)
                }
            }
            
        }
        
        return result
    }
    
    func startWalk(petId:UUID) async throws -> OneWalkJsonResponse{
        
        let url = URL(string: GeneralNetworkService.WalksControllerUrls.startWalk(petId: petId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:OneWalkJsonResponse = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: WalksErrors.refreshToken)}
            
            AF.request(url,method: .post, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    if let decodedData = try? JSONDecoder().decode(OneWalkJsonResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: WalksErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: WalksErrors.unknown)
                }
            }
        }
        
        return result
    }
    func endWalk(petId:UUID, walkId:UUID, dc:Bool) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.WalksControllerUrls.endWalk(petId: petId, walkId: walkId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let parameters = [
            "dc":dc
        ]
        
        let result:Bool = await withCheckedContinuation { continuation in
            AF.request(url, method: .post,parameters: parameters, encoder: .json ,headers: headers.getHeaders()).response { response in
                
                if response.response?.statusCode == 201{
                    continuation.resume(returning: true)
                }else{
                    continuation.resume(returning: false)
                }
            }
        }
        
        return result
    }
}
