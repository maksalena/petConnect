//
//  UsersNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation
import Alamofire

protocol UsersNetworkServiceProtocol{
    
    /// The request to server to check existing username
    /// - Parameter username: username value
    /// - Returns: true - if username exist
    func existUsername(username:String) async throws -> Bool
    
    /// The request to server to check existing email
    /// - Parameter email: email value
    /// - Returns: true - if email exist
    func existEmail(email:String) async throws -> Bool
    
    /// The request to server to signUp
    /// - Parameters:
    ///   - username: username value
    ///   - email: email value
    ///   - password: password value
    /// - Returns: true - is signUp is successuful
    func signUp(body: SignUpRequestStruct) async throws -> Bool
    
    /// The request to server to check code to activae account
    /// - Parameters:
    ///   - email: email value
    ///   - code: passCode value
    /// - Returns: true - if activation is ok
    func activation(email:String, code:String) async throws -> Bool
    
    /// The request to server to resend activation code
    /// - Parameter email: email value
    /// - Returns: true - if resend is ok
    func activtionResend(email:String) async throws -> Bool
    
    /// Request for delete account
    /// - Returns: true - if delete is successful
    func deleteAccount() async throws -> Bool
    
    /// Request for getting personal info
    /// - Returns: struct MeResponseJsonStruct? with user personl info
    func getMe() async throws -> MeResponseJsonStruct?
    
    func updateAvatar(imageId:UUID) async throws -> Bool
    
    func integrateUser() async throws
}

/// Possible errors in Users Network Service
enum UsersError:Error{
    case emailExist
    case usernameExist
    case unknown
    
}

/// Users Network Service
class UsersNetworkService:UsersNetworkServiceProtocol{

    func existUsername(username:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.usernameExist + "?username=\(username)")!
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: success! == Data("true".utf8) )
                case .failure(_):
                    continuation.resume(throwing: NSError(domain: "Unknown", code: 500) )
                }
            }
        }
        
        return result
    }
    
    func existEmail(email:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.existEmail + "?email=\(email)")!
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: String(data: success ?? Data(), encoding: .utf8).flatMap(Bool.init) ?? true )
                case .failure(_):
                    continuation.resume(throwing: NSError(domain: "Unknown", code: 500) )
                }
            }
        }
        
        return result
    }
    
    
    // MARK: - signUp
    func signUp(body: SignUpRequestStruct) async throws -> Bool{
        
        let signUpUrl = URL(string: GeneralNetworkService.UsersControllerUrls.signUp)!
                
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(signUpUrl, method: .post, parameters: body, encoder: .json).response { response in
                
                switch response.result {
                    
                case .success(let success):
                    if let error = try? JSONDecoder().decode(SignInErrorJsonStruct.self, from: success ?? Data()){
                        
                        switch error.message{
                            
                        case "Email already exists!":
                            continuation.resume(throwing: UsersError.emailExist)
                        case "Username already exists!":
                            continuation.resume(throwing: UsersError.usernameExist)
                        default:
                            continuation.resume(throwing: UsersError.unknown)
                        }
                        
                        return
                    }
                    
                    continuation.resume(returning: true)
                case .failure(_):
                    continuation.resume(throwing: UsersError.unknown)
                }
            }
        }
        
        return result
    }
    
    func activation(email:String, code:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.activation)!
        
        let body = ActivationRequestStruct(email: email, code: code)
        
        let result:Bool = await withCheckedContinuation { continuation in
            
            AF.request(url, method: .post, parameters: body, encoder: .json).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: String(data: success ?? Data(), encoding: .utf8).flatMap(Bool.init) ?? false )
                case .failure(_):
                    continuation.resume(returning: false)
                }
            }
        }
        
        return result
    }
    func activtionResend(email:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.activationResend + "?email=\(email)")!
        
        let result:Bool = await withCheckedContinuation { continuation in
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(_):
                    continuation.resume(returning: true)
                case .failure(_):
                    continuation.resume(returning: false)
                }
            }
        }
        
        return result
    }
    
    func deleteAccount() async throws -> Bool {
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.deleteUser)!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        if !refreshToken { return false }
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .delete, headers: headers.getHeaders()).response { response in
                
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
    
    func getMe() async throws -> MeResponseJsonStruct?{
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.getMyInfo)!
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        if !refreshToken { return nil }
        
        let result:MeResponseJsonStruct? = try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(let success):
                    if let responseDecoded = try? JSONDecoder().decode(MeResponseJsonStruct.self, from: success!){
                        continuation.resume(returning: responseDecoded)
                    }else{
                        continuation.resume(returning: nil)
                    }
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
        
        return result
    }
    
    func updateAvatar(imageId:UUID) async throws -> Bool{
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.updateAvatar)!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        if !refreshToken { return false }
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.upload(multipartFormData: { multipart in
                multipart.append(imageId.uuidString.data(using: .utf8)!, withName: "file-id")
            }, to:url, headers: headers.getHeaders()).response { response in
                switch response.result {
                case .success(_):
                    continuation.resume(returning: true)
                case .failure(_):
                    continuation.resume(throwing: UsersError.unknown)
                }
            }
        }
        
        return result
    }
    
    func integrateUser() async throws{
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.integrateUser)!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        if !refreshToken { return }
        
        
        let _:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .post, headers: headers.getHeaders()).response { response in
                
                switch response.response?.statusCode{
                case 200:
                    continuation.resume(returning: true)
                
                default:
                    continuation.resume(throwing: UsersError.unknown)
                }
            }
        }
        
    }
}
