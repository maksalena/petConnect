//
//  AppointmentClinicsNetworkService.swift
//  PetConnect
//
//  Created by Алёна Максимова on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import Alamofire

protocol AppointmentClinicsNetworkServiceProtocol{
    func getAppointments(status: String?, page:Int) async throws -> AppointmentJsonResponse.AppointmentWelcome
    func declineAppointment(id: UUID) async throws
    func sendRating(id: UUID, ratingJSON: createRatingRequestJson) async throws
}

class AppointmentClinicsNetworkService: AppointmentClinicsNetworkServiceProtocol {
    
    func getAppointments(status: String?, page:Int) async throws -> AppointmentJsonResponse.AppointmentWelcome {
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientDoctors.getAppointments(status: status ?? "", page: page))!
        
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()
        
        let result: AppointmentJsonResponse.AppointmentWelcome = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                
//                print(url)
//                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                switch response.result {
                case .success(let success):
                    
                    if let decoded = try? JSONDecoder().decode(AppointmentJsonResponse.AppointmentWelcome.self, from: success ?? Data()){
                        continuation.resume(returning: decoded)
                    }else{
                        continuation.resume(throwing: ClientClinicsErrors.unknown)
                    }
                case .failure(let failure):
                    continuation.resume(throwing: ClientClinicsErrors.unknown)
                }
            }
        }
        
        return result
    }
    
    func declineAppointment(id: UUID) async throws {
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientDoctors.cancelAppointment(id: id))!
        
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()

        let _: Bool = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: ClientClinicsErrors.refreshToken) }
            AF.request(url, method: .put ,headers: headers.getHeaders()).response { response in
                
                switch response.response?.statusCode{
                case 200:
                    continuation.resume(returning: true)
                default:
                    continuation.resume(throwing: ClientClinicsErrors.unknown)
                }
                
            }
            
        }
        
    }
    
    func sendRating(id: UUID, ratingJSON: createRatingRequestJson) async throws {
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientDoctors.sendRating(id: id))!
        
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()

        let _: Bool = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: ClientClinicsErrors.refreshToken) }
            AF.request(url, method: .post, parameters: ratingJSON, encoder: .json, headers: headers.getHeaders()).response { response in
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                switch response.response?.statusCode{
                case 200:
                    continuation.resume(returning: true)
                default:
                    continuation.resume(throwing: ClientClinicsErrors.unknown)
                }
                
            }
            
        }
    }
}

