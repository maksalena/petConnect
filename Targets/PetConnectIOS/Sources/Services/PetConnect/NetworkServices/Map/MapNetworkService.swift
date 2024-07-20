//
//  MapNetworkService.swift
//  PetConnect
//
//  Created by Алёна Максимова on 15.09.2023.
//

import Foundation
import Alamofire

enum MapErrors:Error{
    case refreshToken
    case unknown
    case notFavorite
}

protocol MapNetworkServiceProtocol {
    func createMarker(pointJson: createPointRequestJson) async throws -> CreatedMarkerJsonResponse
    func getMarker(markerId:UUID) async throws -> MarkerJsonResponse
    func checkFavorite(markerId:UUID) async throws -> Content
    func searchMarkers(lat: Double, lng: Double, type: String, raduis:Int) async throws -> Markers
}

class MapNetworkService: MapNetworkServiceProtocol {
    
    // MARK: - Walks
    func createMarker(pointJson: createPointRequestJson) async throws -> CreatedMarkerJsonResponse {
        let url = URL(string: GeneralNetworkService.MapControllerUrls.createMarker())!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result: CreatedMarkerJsonResponse = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken) }
            
            
            AF.request(url, method: .post, parameters: pointJson, encoder: .json ,headers: headers.getHeaders()).response { response in
                
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                switch response.result {
                case .success(let success):
                    if let responseDecoded = try? JSONDecoder().decode(CreatedMarkerJsonResponse.self, from: success ?? Data() ){
                        continuation.resume(returning: responseDecoded)
                    }else{
                        continuation.resume(throwing: MapErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: MapErrors.unknown)
                }
            }
            
        }
    
        return result
    }
    
    func getMarker(markerId:UUID) async throws -> MarkerJsonResponse {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.getMarker(markerId: markerId))!
        print(url)
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:MarkerJsonResponse = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken)}
            
            AF.request(url,method: .get, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    //print(try? JSONSerialization.jsonObject(with: success!))
                    if let decodedData = try? JSONDecoder().decode(MarkerJsonResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: MapErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: MapErrors.unknown)
                }
            }
        }
        
        return result
    }
    
    func checkFavorite(markerId:UUID) async throws -> Content {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.checkFavorite(markerId: markerId))!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:Content = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken)}
            
            AF.request(url,method: .get, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    //print(try? JSONSerialization.jsonObject(with: success!))
                    if let decodedData = try? JSONDecoder().decode(Content.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: MapErrors.notFavorite)
                    }
                case .failure(_):
                    continuation.resume(throwing: MapErrors.unknown)
                }
            }
        }
        
        return result
    }
    
    func deleteMarker(markerId:UUID) async throws -> Bool {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.deleteMarker(markerId: markerId))!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken)}
            AF.request(url,method: .delete, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 200 {
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
    
    func searchMarkers(lat: Double, lng: Double, type: String, raduis:Int) async throws -> Markers {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.searchMarkers() + "?lat=\(lat)&lng=\(lng)&radiusMeters=\(raduis)&type=\(type)")!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result: Markers = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken)}
            
            AF.request(url,method: .get, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    if let decodedData = try? JSONDecoder().decode(Markers.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: MapErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: MapErrors.unknown)
                }
            }
        }
        
        return result
    }
    
    // MARK: - Likes
    
    func markLike(likeJson: setMyLike) async throws -> Bool {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.setLike())!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result: Bool = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume (throwing: TabletsFoddersError.refreshToken) }
            AF.request (url, method: .post, parameters: likeJson, encoder: .json, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 200 {
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
    
    func deleteLike(markerId: UUID) async throws -> Bool {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.deleteLike(markerId: markerId))!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken)}
            AF.request(url,method: .delete, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 200 {
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
    
    func markFavorite(favoriteJson: setFavorite) async throws -> Bool {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.setFavorite())!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result: Bool = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume (throwing: TabletsFoddersError.refreshToken) }
            AF.request (url, method: .post, parameters: favoriteJson, encoder: .json, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 200 {
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
    
    func deleteFavorite(markerId: UUID) async throws -> Bool {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.deleteFavorite(markerId: markerId))!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result :Bool = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken)}
            AF.request(url,method: .delete, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    if response.response?.statusCode == 200 {
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
    
    func getFavorite() async throws -> Favorites {
        
        let url = URL(string: GeneralNetworkService.MapControllerUrls.getFavorite() + "?size=10000")!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        
        let result:Favorites = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: MapErrors.refreshToken) }
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in

                switch response.result {
                case .success(let success):
                    if let dataDecoded = try? JSONDecoder().decode(Favorites.self, from: success ?? Data()){
                        continuation.resume(returning: dataDecoded)
                    }else{
                        continuation.resume(throwing: MapErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: MapErrors.unknown)
                }
                
            }
        }
        
        return result
    }
}

