//
//  PetsNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation
import Alamofire

enum PetsError:Error{
    case unknown
    case errorParseJson
    case refreshTokenError
}

protocol PetsNetworkServiceProtocol{
    func getAllPets() async throws -> AllPetsJsonResponse
    func createPet(petJson:createPetRequestJson) async throws -> OnePetJsonResponse
    
    func updatePet(petId:UUID, petJson:createPetRequestJson) async throws -> OnePetJsonResponse
    
    func deletePet(petId:UUID) async throws -> Bool
    
    func updateAvatar(petId:UUID, imageId:UUID) async throws -> Bool
    
    func getIdentification(petId:UUID) async throws -> GetIdentificationsResponseJson
    
    func setIdentification(petId:UUID, identification: CreateIdentificationRequestJson) async throws -> OneIdentificationResponse
    
    func updateIdentification(petId:UUID, identificationId:UUID ,identification: CreateIdentificationRequestJson) async throws -> OneIdentificationResponse
    
    func integratePet(petId:UUID) async throws
}

class PetsNetworkService:PetsNetworkServiceProtocol{
    
    func getAllPets() async throws -> AllPetsJsonResponse{
        let url = URL(string: GeneralNetworkService.PetsControllerUrls.getAllPets + "?size=10000")!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        
        let result:AllPetsJsonResponse = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data() ))
                
                switch response.result {
                case .success(let success):
                    if let dataDecoded = try? JSONDecoder().decode(AllPetsJsonResponse.self, from: success ?? Data()){
                        continuation.resume(returning: dataDecoded)
                    }else{
                        continuation.resume(throwing: PetsError.errorParseJson)
                    }
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
                
            }
        }
        
        return result
    }
    
    func createPet(petJson:createPetRequestJson) async throws -> OnePetJsonResponse{
        let url = URL(string: GeneralNetworkService.PetsControllerUrls.createPet)!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        
        let result:OnePetJsonResponse = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            AF.request(url, method: .post, parameters: petJson, encoder: .json ,headers: headers.getHeaders()).response { response in
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                
                switch response.result {
                case .success(let success):
                    if let responseDecoded = try? JSONDecoder().decode(OnePetJsonResponse.self, from: success ?? Data() ){
                        continuation.resume(returning: responseDecoded)
                    }else{
                        continuation.resume(throwing: PetsError.errorParseJson)
                    }
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
            
        }
        
        return result
    }
    
    func updatePet(petId:UUID, petJson:createPetRequestJson) async throws -> OnePetJsonResponse{
        let url = URL(string: GeneralNetworkService.PetsControllerUrls.updatePet(petId: petId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        
        let result:OnePetJsonResponse = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            AF.request(url, method: .put, parameters: petJson, encoder: .json ,headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    if let responseDecoded = try? JSONDecoder().decode(OnePetJsonResponse.self, from: success ?? Data() ){
                        continuation.resume(returning: responseDecoded)
                    }else{
                        continuation.resume(throwing: PetsError.errorParseJson)
                    }
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
            
        }
        
        return result
    }
    
    func deletePet(petId:UUID) async throws -> Bool{
        let url = URL(string: GeneralNetworkService.PetsControllerUrls.deletePet(petId: petId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{return false}
        
        let result:Bool = await withCheckedContinuation { continuation in
            
            AF.request(url, method: .delete, headers: headers.getHeaders()).response { response in
                if response.response?.statusCode == 200{
                    continuation.resume(returning: true)
                }else{
                    continuation.resume(returning: false)
                }
            }
            
        }
        
        return result
        
        
    }
    
    func updateAvatar(petId:UUID, imageId:UUID) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.PetsControllerUrls.updateAvatar(petId: petId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        if !refreshToken { return false }
        
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.upload(multipartFormData: { multipart in
                multipart.append(imageId.uuidString.data(using: .utf8)!, withName: "file-id")
            },to:url,headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    continuation.resume(returning: true)
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
        }
        
        return result
    }
    
    func getIdentification(petId:UUID) async throws -> GetIdentificationsResponseJson{
        
        let url = URL(string: GeneralNetworkService.IdentificationsControllerUrls.get(petId: petId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:GetIdentificationsResponseJson = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
//                //print(try? JSONSerialization.jsonObject(with: response.data!))
                
                switch response.result {
                case .success(let success):
                                       
                    if let decodedData = try? JSONDecoder().decode(GetIdentificationsResponseJson.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: PetsError.unknown)
                    }
                    
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
        }
        
        return result
        
    }
    
    func setIdentification(petId:UUID, identification: CreateIdentificationRequestJson) async throws -> OneIdentificationResponse{
        
        let url = URL(string: GeneralNetworkService.IdentificationsControllerUrls.create(petId: petId))!
                
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:OneIdentificationResponse = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            
            AF.request(url, method: .post,parameters: identification, encoder: .json, headers: headers.getHeaders()).response { response in
                //print(try? JSONSerialization.jsonObject(with: response.data!))
                switch response.result {
                case .success(let success):
                    if let decodedData = try? JSONDecoder().decode(OneIdentificationResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: PetsError.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
        }
        
        return result
    }
    
    func updateIdentification(petId:UUID, identificationId:UUID ,identification: CreateIdentificationRequestJson) async throws -> OneIdentificationResponse{
        let url = URL(string: GeneralNetworkService.IdentificationsControllerUrls.update(petId: petId, identificationId: identificationId))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:OneIdentificationResponse = try await withCheckedThrowingContinuation { continuation in
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            
            AF.request(url, method: .put ,parameters: identification, encoder: .json, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    if let decodedData = try? JSONDecoder().decode(OneIdentificationResponse.self, from: success ?? Data()){
                        continuation.resume(returning: decodedData)
                    }else{
                        continuation.resume(throwing: PetsError.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
        }
        
        return result
        
    }
    
    
    func integratePet(petId:UUID) async throws{
        let _ = try await AuthNetworkService.refreshToken()
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let url = URL(string: GeneralNetworkService.ClinicControllerUrls.integratePet)!
        
        let parameter = ["petId":petId]
        
        let _:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .post, parameters: parameter, encoder: .json, headers: headers.getHeaders()).response { response in
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                
                switch response.response?.statusCode{
                case 200:
                    continuation.resume(returning: true)
                default:
                    continuation.resume(throwing: PetsError.unknown)
                }
            }
        }
    }
    
}
