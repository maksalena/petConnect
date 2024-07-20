//
//  ClientDoctorsNetworkService.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation
import Alamofire

protocol ClientDoctorsNetworkServiceProtocol{
    func getClinicDoctorsWithCalendar(specializationId:UUID?,clinicId:UUID,dateAt:Date, page:Int) async throws -> ClientDoctorsJson.SearchClinicDoctorsWithCalendarResponse
    
    func getDoctorById(id:UUID) async throws -> ClientDoctorsJson.OneDoctor
    
    func createAppointment(appointment:AppointmentCreate.CreateAppointmentRequest) async throws

}

class ClientDoctorsNetworkService:ClientDoctorsNetworkServiceProtocol{
    
    func getClinicDoctorsWithCalendar(specializationId:UUID?,clinicId:UUID,dateAt:Date, page:Int) async throws -> ClientDoctorsJson.SearchClinicDoctorsWithCalendarResponse{
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientDoctors.searchDoctors(specializationId: specializationId, clinicId: clinicId, dateAt: dateAt, page: page))!
        
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()
        
        let result: ClientDoctorsJson.SearchClinicDoctorsWithCalendarResponse = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                switch response.result {
                case .success(let success):
                    if let decoded = try? JSONDecoder().decode(ClientDoctorsJson.SearchClinicDoctorsWithCalendarResponse.self, from: success ?? Data()){
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
    
    func getDoctorById(id:UUID) async throws -> ClientDoctorsJson.OneDoctor{
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientDoctors.getDoctor(id: id))!
        
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()
        
        let result: ClientDoctorsJson.OneDoctor = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                
//                print(url)
//                print(try? JSONSerialization.jsonObject(with: response.data ?? Data()))
                switch response.result {
                case .success(let success):
                    if let decoded = try? JSONDecoder().decode(ClientDoctorsJson.OneDoctor.self, from: success ?? Data()){
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
    
    func createAppointment(appointment:AppointmentCreate.CreateAppointmentRequest) async throws{
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        if !refreshToken{
            throw ClientClinicsErrors.refreshToken
        }
        
        let url = URL(string: ClinicsGeneralNetworkService.ClientAppointments.createAppointment)!
        
        let headers = ClinicsGeneralNetworkService.Headers()
        headers.addClinicAccessTokenHeader()
        
        
        let _:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .post, parameters: appointment, encoder: .json, headers: headers.getHeaders()).response{ response in
                
                print(try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: [.mutableContainers]))
                switch response.response?.statusCode{
                case 200:
                    continuation.resume(returning: true)
                default:
                    if let decoced = try? JSONDecoder().decode(SignInErrorJsonStruct.self, from: response.data ?? Data()){
                       if decoced.status == "CONFLICT"{
                           continuation.resume(throwing: ClientClinicsErrors.CONFLICT)
                       }else{
                           continuation.resume(throwing: ClientClinicsErrors.unknown)
                       }
                    }else{
                        
                        continuation.resume(throwing: ClientClinicsErrors.unknown)
                    }
                }
                
            }
        }
    }
}
