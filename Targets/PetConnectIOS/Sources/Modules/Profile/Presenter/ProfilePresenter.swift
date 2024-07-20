//
//  ProfilePresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import Foundation
import UIKit

protocol ProfileViewProtocol:AnyObject{
    func logOutSuccessfull()
    func logOutError()
    
    func deleteError()
    func deleted()
    
    func setFullname(name: String)
    func setEmail(email:String)
    func setUsername(username:String)
    func setUserPhoto(image:Data?)
    func setPhone(phone:String)
    
    func setLodingView()
    func endRefreshing()
    
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, authNetworkService:AuthNetworkService, usersNetworkService:UsersNetworkService, keyChainService:KeyChainStorageProtocol, filesNetworkService:FilesNetworkServiceProtocol, imageRealmService:ImageRealmServiceProtocol)
    
    func logOutTapped()
    func deleteTapped()
    
    
    func getPersonalInfo()
    func loadPersonalInfo()
    func isValidEmail(email:String) -> Bool
    
    func uploadPhoto(image:UIImage)
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    
    var authNetworkService:AuthNetworkService?
    var usersNetworkService:UsersNetworkService?
    var keyChainService:KeyChainStorageProtocol?
    var filesNetworksService:FilesNetworkServiceProtocol?
    var imageRealmService:ImageRealmServiceProtocol?
    
    required init(view: ProfileViewProtocol, authNetworkService:AuthNetworkService, usersNetworkService:UsersNetworkService, keyChainService:KeyChainStorageProtocol, filesNetworkService:FilesNetworkServiceProtocol,imageRealmService:ImageRealmServiceProtocol) {
        self.view = view
        self.authNetworkService = authNetworkService
        self.keyChainService = keyChainService
        self.usersNetworkService = usersNetworkService
        self.filesNetworksService = filesNetworkService
        self.imageRealmService = imageRealmService
    }
    
    func logOutTapped(){
        Task{
            let logOutResult = try await authNetworkService?.logOut()
            if (logOutResult ?? false){
                DispatchQueue.main.async {
                    self.view?.logOutSuccessfull()
                    self.deleteData()
                }
                
            }else{
                DispatchQueue.main.async {
                    self.view?.logOutError()
                }
            }
        }
        
    }
    
    func deleteTapped() {
        Task{
            let deleteResult = try await usersNetworkService?.deleteAccount()
            if (deleteResult ?? false){
                DispatchQueue.main.async {
                    self.view?.deleted()
                    self.deleteData()
                }
            }else{
                DispatchQueue.main.async {
                    self.view?.deleteError()
                }
            }
        }
        
    }
    
    func getPersonalInfo(){
        let email = keyChainService?.getEmail()
        let username = keyChainService?.getUsername()
        
        let phone = keyChainService?.getPhone()
        let fullName = "\(keyChainService?.getSecondName() ?? "") \(keyChainService?.getFirstName() ?? "") \(keyChainService?.getMiddleName() ?? "")"
        
        if email == nil || username == nil{
            view?.setLodingView()
        }else{
            view?.setEmail(email: email ?? "")
            view?.setUsername(username: username ?? "")
            view?.setPhone(phone: phone ?? "")
            view?.setFullname(name: fullName)
        }
        
        if let image = keyChainService?.getUserPhoto(){
            view?.setUserPhoto(image: image)
        }
        
        self.loadPersonalInfo()
        
    }
    
    func loadPersonalInfo(){
        Task{
            if let personalInfo = try await usersNetworkService?.getMe(){
                var image:Data?
                
                keyChainService?.setId(id: personalInfo.id)
                keyChainService?.setEmail(email: personalInfo.email)
                keyChainService?.setPhone(phone: personalInfo.phone)
                keyChainService?.setIsClinicAccount(personalInfo.hasClinicAccount)
                
                keyChainService?.setUsername(username: personalInfo.username)
                
                keyChainService?.setFirstName(firstName: personalInfo.firstName ?? "")
                keyChainService?.setSecondName(secondName: personalInfo.lastName ?? "")
                keyChainService?.setMiddleName(middleName: personalInfo.middleName ?? "")
                
                keyChainService?.setCreatedAt(createdAt: personalInfo.createdAt)
                keyChainService?.setUpdatedAt(updatedAt: personalInfo.updateAt)
                
                if !personalInfo.hasClinicAccount{
                    do{
                        try await usersNetworkService?.integrateUser()
                        keyChainService?.setIsClinicAccount(true)
                        let _ = try await AuthNetworkService.refreshToken()
                    } catch{
                        
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.view?.setEmail(email: personalInfo.email)
                    self.view?.setUsername(username: personalInfo.username)
                    self.view?.setPhone(phone: personalInfo.phone)
                }
                
                if let photoId = personalInfo.avatars.first?.fileID{
                    DispatchQueue.main.sync {
                        image = self.imageRealmService?.getImage(by: photoId)
                    }
                    
                    if image == nil{
                        if let photoPath = personalInfo.avatars.first?.filePath{
                            image = try await self.filesNetworksService?.downloadPhoto(photoPath)
                            
                            if image != nil{
                                DispatchQueue.main.sync {
                                    
                                    self.imageRealmService?.setImage(id: photoId, imageData: image!, filePath: photoPath)
                                    keyChainService?.setUserPhoto(image: image!)
                                }
                            }
                        }
                    }
                    
                }else{
                    keyChainService?.deleteUserPhoto()
                }
                
                DispatchQueue.main.sync {
                    self.view?.setUserPhoto(image: image)
                    self.view?.endRefreshing()
                }
                
            }
        }
    }
    
    func isValidEmail(email:String) -> Bool{
        return email == self.keyChainService?.getEmail()
    }
    
    private func deleteData(){
        self.keyChainService?.deleteAccessToken()
        self.keyChainService?.deleteRefreshToken()
        
        self.keyChainService?.deleteEmail()
        self.keyChainService?.deleteUsername()
        self.keyChainService?.deleteId()
        self.keyChainService?.deleteCreatedAt()
        self.keyChainService?.deleteUpdatedAt()
    }
    
    func uploadPhoto(image:UIImage){
        Task{
            if let uploadResult = try await self.filesNetworksService?.uploadPhoto(image: image, .userAvatar){
                
                
                DispatchQueue.main.async {
                    self.imageRealmService?.setImage(id: uploadResult.id, imageData: image.jpegData(compressionQuality: 1)!, filePath: uploadResult.path)
                    
                    self.keyChainService?.setUserPhoto(image: image.jpegData(compressionQuality: 1)!)
                }
                
                
                let addedPhotoResult = try await self.usersNetworkService?.updateAvatar(imageId: uploadResult.id)
                
                
            }
        }
        
    }
    
}
