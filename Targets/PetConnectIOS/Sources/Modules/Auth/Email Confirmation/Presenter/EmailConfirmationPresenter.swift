//
//  EmailConfirmationPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation

protocol EmailConfirmationViewProtocol:AnyObject{
    func confirmationError()
    func confrimationOk()
    
    func resendOk()
    func resendError()
    
}

protocol EmailConfirmationPresenterProtocol:AnyObject{
    var passCode:[Int] { get set }
    var model:SignUpModel { get }
    init(
        view:EmailConfirmationViewProtocol,
        networkService:UsersNetworkServiceProtocol,
        authNetworkService:AuthNetworkServiceProtocol?,
        keyChainService:KeyChainStorageProtocol,
        model:SignUpModel)
    
    func confirmTapped()
    func resendTapped()
    func setEmail(email:String)
    func isValidEmail()->Bool
    
}
class EmailConfirmationPresenter:EmailConfirmationPresenterProtocol{
    var model:SignUpModel
    weak var view:EmailConfirmationViewProtocol?
    let networkService:UsersNetworkServiceProtocol?
    var authNetworkService:AuthNetworkServiceProtocol?
    var keyChainService:KeyChainStorageProtocol?

    var passCode:[Int] = []
    
    required init(
        view:EmailConfirmationViewProtocol,
        networkService:UsersNetworkServiceProtocol ,
        authNetworkService:AuthNetworkServiceProtocol?,
        keyChainService:KeyChainStorageProtocol,
        model:SignUpModel) {
        self.view = view
        self.networkService = networkService
        self.model = model
        self.authNetworkService = authNetworkService
        self.keyChainService = keyChainService
    }
    
    func confirmTapped(){
        let code = String(passCode[0]) + String(passCode[1]) + String(passCode[2]) + String(passCode[3])
        
        Task{
            
            let result = try await networkService?.activation(email:model.email, code: code)
            
            if (result ?? false){
                let login = try await authNetworkService?.signIn(login: model.email, password: model.password)
                
                if login != nil{
                    keyChainService?.saveAccessToken(token: login!.0)
                    keyChainService?.saveRefreshToken(token: login!.1)
                    keyChainService?.saveClinicAccessToken(token: login!.2)
                    DispatchQueue.main.async {
                        self.view?.confrimationOk()
                    }
                }

            }else{
                DispatchQueue.main.async {
                    self.view?.confirmationError()
                }
            }
            
        }
    }
    
    func resendTapped(){
        Task{
            let result = try await networkService?.activtionResend(email: model.email)
            
            if (result ?? false){
                DispatchQueue.main.async {
                    self.view?.resendOk()
                }
            }else{
                DispatchQueue.main.async {
                    self.view?.resendError()
                }
            }
            
        }
    }
    
    func setEmail(email:String){
        self.model.email = email
    }
    
    func isValidEmail()->Bool{
        return AuthValidation.validateEmail(value: self.model.email)
    }
    
}
