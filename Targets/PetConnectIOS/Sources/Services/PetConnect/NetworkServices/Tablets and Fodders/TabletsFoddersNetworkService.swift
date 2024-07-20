//
//  TabletsFoddersNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 07.09.2023.
//

import Foundation
import Alamofire

enum TabletFodderType{
    case tablet
    case fodder
}
enum TabletsFoddersError:Error{
    case unknown
    case refreshToken
}

protocol TabletsFoddersNetworkServiceProtocol{
    
    func create(_ type:TabletFodderType, petId:UUID, _ tabletFodder:CreateTabletsFoddersJsonRequest) async throws -> TabletsFoddersContent
    
    func findAll(_ type:TabletFodderType, petId:UUID) async throws -> FindAllTabletsFoddersJsonResponse
    
    func delete(_ type:TabletFodderType, petId:UUID, tabletFodderId:UUID) async throws -> Bool
    
    func update(_ type:TabletFodderType, petId:UUID, tabletFodderId:UUID, _ tabletFodder: CreateTabletsFoddersJsonRequest) async throws -> TabletsFoddersContent
    
    
}

class TabletsFoddersNetworkService:TabletsFoddersNetworkServiceProtocol{
    
    func create(_ type: TabletFodderType, petId: UUID, _ tabletFodder: CreateTabletsFoddersJsonRequest) async throws -> TabletsFoddersContent {
        
        var url:URL
        
        switch type {
        case .tablet:
            url = URL(string: GeneralNetworkService.ControllersUrls.tablet(petId: petId))!
        case .fodder:
            url = URL(string: GeneralNetworkService.ControllersUrls.fodder(petId: petId))!
        }
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:TabletsFoddersContent = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: TabletsFoddersError.refreshToken) }
            
            AF.request(url, method: .post, parameters: tabletFodder,encoder: .json, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    
                    if let decodedData = try? JSONDecoder().decode(TabletsFoddersContent.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: TabletsFoddersError.unknown)
                    }
                    
                case .failure(_):
                    continuation.resume(throwing: TabletsFoddersError.unknown)
                }
            }
        }
        
        return result
    }
    
    func findAll(_ type: TabletFodderType, petId: UUID) async throws -> FindAllTabletsFoddersJsonResponse {
        
        var url:URL
        
        switch type {
        case .tablet:
            url = URL(string: GeneralNetworkService.ControllersUrls.tablet(petId: petId) + "?size=100")!
        case .fodder:
            url = URL(string: GeneralNetworkService.ControllersUrls.fodder(petId: petId) + "?size=100")!
        }
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:FindAllTabletsFoddersJsonResponse = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: TabletsFoddersError.refreshToken) }
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    if let decodedData = try? JSONDecoder().decode(FindAllTabletsFoddersJsonResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: TabletsFoddersError.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: TabletsFoddersError.unknown)
                }
            }
        }
        
        return result
    }
    
    func delete(_ type: TabletFodderType, petId:UUID, tabletFodderId: UUID) async throws -> Bool {
        
        var url:URL
        
        switch type {
        case .tablet:
            url = URL(string: GeneralNetworkService.ControllersUrls.tablet(petId: petId) + "/\(tabletFodderId)")!
        case .fodder:
            url = URL(string: GeneralNetworkService.ControllersUrls.fodder(petId: petId) + "/\(tabletFodderId)")!
        }
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: TabletsFoddersError.refreshToken) }
            
            AF.request(url, method: .delete,headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 200{
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
    
    func update(_ type: TabletFodderType, petId:UUID, tabletFodderId: UUID, _ tabletFodder: CreateTabletsFoddersJsonRequest) async throws -> TabletsFoddersContent {
        
        var url:URL
        
        switch type {
        case .tablet:
            url = URL(string: GeneralNetworkService.ControllersUrls.tablet(petId: petId) + "/\(tabletFodderId)")!
        case .fodder:
            url = URL(string: GeneralNetworkService.ControllersUrls.fodder(petId: petId) + "/\(tabletFodderId)")!
        }
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:TabletsFoddersContent = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: TabletsFoddersError.refreshToken) }
            
            AF.request(url, method: .put, parameters: tabletFodder,encoder: .json, headers: headers.getHeaders()).response { response in
                                
                switch response.result {
                case .success(let success):
                    if let decodedData = try? JSONDecoder().decode(TabletsFoddersContent.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: TabletsFoddersError.unknown)
                    }
                    
                case .failure(_):
                    continuation.resume(throwing: TabletsFoddersError.unknown)
                }
            }
        }
        
        return result
    }
    
    
}
