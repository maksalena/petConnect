//
//  FilesNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 02.09.2023.
//

import Foundation
import UIKit
import Alamofire
public enum FilesErrors:Error{
    case unknown
}
public enum UploadFileType:String{
    case petAvatar = "PET_AVATAR"
    case userAvatar = "USER_AVATAR"
}
protocol FilesNetworkServiceProtocol{
    func uploadPhoto(image:UIImage, _ type:UploadFileType) async throws -> uploadFileResponseJson
    func downloadPhoto(_ id:UUID) async throws -> Data?
    func downloadPhoto(_ byPath:String) async throws -> Data?
}

class FilesNetworkService:FilesNetworkServiceProtocol{
    func uploadPhoto(image:UIImage, _ type:UploadFileType) async throws -> uploadFileResponseJson{
        let url = URL(string: GeneralNetworkService.ControllersUrls.uploadPhotoUrl)!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let boundary = "Pet_AVATAR-\(UUID().uuidString)"
        
        var uploadHeaders = headers.getHeaders()
        
        uploadHeaders["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        
        let imageData = image.jpegData(compressionQuality: 1)!
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:uploadFileResponseJson = try await withCheckedThrowingContinuation { continuation in
        if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            
            AF.upload(multipartFormData: { multipart in
                multipart.append(type.rawValue.data(using: .utf8)!, withName: "storage-type")
                multipart.append(imageData, withName: "file", fileName: "123123123123123.jpg", mimeType: "image/png")
            
                
            }, to: url,headers: uploadHeaders).response { response in
                                
                switch response.result {
                case .success(let success):
                    if let decodedResponse = try? JSONDecoder().decode(uploadFileResponseJson.self, from: success ?? Data()){
                        continuation.resume(returning: decodedResponse)
                    }else{
                        continuation.resume(throwing: FilesErrors.unknown)
                    }
                case .failure(_):
                    print(321)
                    continuation.resume(throwing: FilesErrors.unknown)
                }
            }
            
        }
        
        return result
        
    }
    
    func downloadPhoto(_ id:UUID) async throws -> Data?{
        let url = URL(string: GeneralNetworkService.ControllersUrls.downLoadPhotoUrl(photoId: id))!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let uploadHeaders = headers.getHeaders()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
        
        let result:Data? = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            
            AF.request(url, method: .get, headers: uploadHeaders).response { response in
                switch response.result {
                case .success(let success):
                    if response.response?.statusCode == 200{
                        continuation.resume(returning: success)
                    }else{
                        continuation.resume(throwing: FilesErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: FilesErrors.unknown)
                }
            }
        }
        
        return result
    }
    
    func downloadPhoto(_ byPath:String) async throws -> Data?{
        let url = URL(string: byPath)!
        
        let headers = GeneralNetworkService.Headers()
        headers.addAccessTokenHeader()
        
        let uploadHeaders = headers.getHeaders()
        
        let refreshToken = try await AuthNetworkService.refreshToken()
                
        let result:Data? = try await withCheckedThrowingContinuation { continuation in
            
            if !refreshToken { continuation.resume(throwing: PetsError.refreshTokenError) }
            
            AF.request(url, method: .get, headers: uploadHeaders).response { response in
                switch response.result {
                case .success(let success):
                    if response.response?.statusCode == 200{
                        continuation.resume(returning: success)
                    }else{
                        continuation.resume(throwing: FilesErrors.unknown)
                    }
                case .failure(_):
                    continuation.resume(throwing: FilesErrors.unknown)
                }
            }
        }
        
        return result
    }
}
