//
//  GeneralNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import Alamofire

protocol GeneralNetworkServiceProtocol{
    static var domain:String { get }
}

class GeneralNetworkService{
    /// General domain for requests to server
    static let mainDomain:String = "https://api.pet-connect.ru/"
    static let filesDomain:String = "https://file.pet-connect.ru/"
    
    /// Possible request controllers urls
    public enum ControllersUrls{
        static let auth =  GeneralNetworkService.mainDomain + "auth/"
        static let users = GeneralNetworkService.mainDomain + "users/"
        static let pets = GeneralNetworkService.mainDomain + "pets"
        
        static func tablet(petId:UUID)->String{
            return GeneralNetworkService.mainDomain + "pets/\(petId)/tablets"
        }
        
        static func fodder(petId:UUID)->String{
            return GeneralNetworkService.mainDomain + "pets/\(petId)/fodders"
        }
        static func identifications(petId:UUID)->String{
            return GeneralNetworkService.mainDomain + "pet/\(petId)/identifications"
        }
        
        static let walks = GeneralNetworkService.mainDomain + "pet"
        
        
        static let walkinMarker = GeneralNetworkService.mainDomain + "walking-markers"
        
        static let uploadPhotoUrl = GeneralNetworkService.mainDomain + "files"
        
        static func downLoadPhotoUrl(photoId:UUID)->String{
            return GeneralNetworkService.mainDomain + "files/private/\(photoId)"
        }
        
        static let createApplication = GeneralNetworkService.mainDomain + "pet/tracker/application"
    }
    
    /// Possible urls for auth controller
    public enum AuthControllerUrls{
        static let signIn = GeneralNetworkService.ControllersUrls.auth + "sign-in"
        static let refreshToken = GeneralNetworkService.ControllersUrls.auth + "refresh-token"
        static let logout = GeneralNetworkService.ControllersUrls.auth + "logout"
    }
    
    /// Possible url for users controller
    public enum UsersControllerUrls{
        static let updateUser = ControllersUrls.users + ""
        static let deleteUser = ControllersUrls.users + ""
        static let signUp = ControllersUrls.users + "sign-up"
        static let getMyInfo = ControllersUrls.users + "me"
        static let usernameExist = ControllersUrls.users + "exist-username"
        static let existEmail = ControllersUrls.users + "exist-email"
        
        static let activation = ControllersUrls.users + "activation"
        static let activationResend = ControllersUrls.users + "activation/resend"
        
        static let updateAvatar = ControllersUrls.users + "avatars"
        
        static let integrateUser = GeneralNetworkService.mainDomain + "v1/clinics/users/integration"
        
    }
    
    public enum PetsControllerUrls{
        static let getAllPets = ControllersUrls.pets
        static let createPet = ControllersUrls.pets
        
        static func deletePet(petId:UUID) -> String{
            return ControllersUrls.pets + "/\(petId)"
            
        }
        
        static func updatePet(petId:UUID) -> String{
            return ControllersUrls.pets + "/\(petId)"
        }
        
        static func updateAvatar(petId:UUID) -> String{
            return ControllersUrls.pets + "/\(petId)/avatars"
        }
    }
    
    public enum WalksControllerUrls{
        
        static func findAll() -> String{
            return ControllersUrls.walks + "/walks"
        }
        
        static func startWalk(petId:UUID) -> String {
            return ControllersUrls.walks + "/\(petId)/walks"
        }
        
        static func endWalk(petId:UUID, walkId:UUID) -> String{
            return ControllersUrls.walks + "/\(petId)/walks/\(walkId)/end"
        }
    }
    
    public enum MapControllerUrls {
        static func createMarker() -> String{
            return ControllersUrls.walkinMarker
        }
        
        static func getMarker(markerId: UUID) -> String {
            return ControllersUrls.walkinMarker + "/\(markerId)"
        }
        
        static func deleteMarker(markerId: UUID) -> String {
            return ControllersUrls.walkinMarker + "/\(markerId)"
        }
        
        static func searchMarkers() -> String{
            return ControllersUrls.walkinMarker + "/search"
        }
        
        static func setLike() -> String{
            return ControllersUrls.walkinMarker + "-likes"
        }
        
        static func deleteLike(markerId: UUID) -> String{
            return ControllersUrls.walkinMarker + "-likes/\(markerId)"
        }
        
        static func setFavorite() -> String{
            return ControllersUrls.walkinMarker + "-favourites"
        }
        
        static func getFavorite() -> String{
            return ControllersUrls.walkinMarker + "-favourites"
        }
        
        static func checkFavorite(markerId: UUID) -> String{
            return ControllersUrls.walkinMarker + "-favourites/\(markerId)"
        }
        
        static func deleteFavorite(markerId: UUID) -> String{
            return ControllersUrls.walkinMarker + "-favourites/\(markerId)"
        }
    }
    
    public enum IdentificationsControllerUrls{
        
        static func update(petId:UUID,identificationId:UUID)->String{
            return GeneralNetworkService.ControllersUrls.identifications(petId: petId) + "/\(identificationId)"
        }
        
        static func delete(petId:UUID,identificationId:UUID)->String{
            return GeneralNetworkService.ControllersUrls.identifications(petId: petId) + "/\(identificationId)"
        }
        
        static func get(petId:UUID)->String{
            return GeneralNetworkService.ControllersUrls.identifications(petId: petId)
        }
        
        static func create(petId:UUID)->String{
            return GeneralNetworkService.ControllersUrls.identifications(petId: petId)
        }
    }
    
    public enum ClinicControllerUrls{
        static let integratePet = "\(GeneralNetworkService.mainDomain)v1/clinics/pets/integration"
    }
            
    public class Headers{
        private var headers:[String:String] = [:]
        let keyChainService = KeyChainStorage()
        
        private enum Keys{
            static let accessToken = "Authorization"
            
            static let deviceId = "deviceId"
            static let firebaseToken = "token"
            
        }
        
        public func getHeaders()->HTTPHeaders{
            return HTTPHeaders(headers)
        }
        
        public func addAccessTokenHeader(){
            
            headers[Keys.accessToken] = "Bearer \(keyChainService.getAccessToken() ?? "")"
        }
        
        public func addFirebaseToken(){
            headers[Keys.firebaseToken] = keyChainService.getFirebaseToken()
        }
        public func addDeviceId(){
            headers[Keys.deviceId] = keyChainService.getDeviceId()
        }
        
    }
}
