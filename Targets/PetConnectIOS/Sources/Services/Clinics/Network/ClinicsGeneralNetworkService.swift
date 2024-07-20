//
//  ClinicsGeneralNetworkService.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation
import Alamofire

final class ClinicsGeneralNetworkService{
    
    // MARK: - URLS
    
    static let clientsDomainV1 = "https://api-clinic.pet-connect.ru/v1/clients"
    static let clientsDomainV2 = "https://api-clinic.pet-connect.ru/v2/clients"
    
    final class ClientClinics{
        
        static func searchClinicsUrl(page:Int) -> String{
            return "\(clientsDomainV1)/clinics?page=\(page)&size=10"
        }
    }
    
    final class ClientDoctors{
        static func searchDoctors(specializationId:UUID?, clinicId:UUID?, dateAt:Date?, page:Int) -> String{
            var main = "\(clientsDomainV2)/doctors?"
            
            if let specialization = specializationId{
                main += "specializationId=\(specialization)&"
            }
            if let clinic = clinicId{
                main += "clinicId=\(clinic)&"
            }
            if let date = dateAt{
                main += "dateAt=\(date.toStringYearFirst())&"
            }
            main += "page=\(page)&size=10"
            
            return main

        }
        
        static func getDoctor(id:UUID) ->String{
            return "\(clientsDomainV2)/doctors/\(id)"
        }
        
        static func getAppointments(status: String?, page:Int) -> String{
            return "\(clientsDomainV2)/appointments?status=\(status ?? "")&page=\(page)&size=10"
        }
        
        static func cancelAppointment(id: UUID) -> String{
            return "\(clientsDomainV2)/appointments/\(id)/cancel"
        }
        
        static func sendRating(id: UUID) -> String {
            return "\(clientsDomainV2)/appointments/\(id)/rating"
        }
        
    }
    final class ClientAppointments{
        static let createAppointment = "\(clientsDomainV2)/appointments"
    }
    
    
    
    final class Headers{
        private var headers:[String:String] = [:]
        let keyChainService = KeyChainStorage()
        
        private enum Keys{
            static let clinicAccessToken = "Authorization"
            
        }
        
        public func getHeaders()->HTTPHeaders{
            return HTTPHeaders(headers)
        }
        
        public func addClinicAccessTokenHeader(){
            
            headers[Keys.clinicAccessToken] = "Bearer \(keyChainService.getClinicAccessToken() ?? "")"
        }
    }
}
