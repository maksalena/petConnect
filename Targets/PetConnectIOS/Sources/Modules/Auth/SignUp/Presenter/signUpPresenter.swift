//
//  signUpPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

protocol SignUpViewProtocol:AnyObject{
    func enableRegisrationButton()
    func disableRegisrationButton()
    
    func setWeakPassword()
    func setStrongPassword()
    
    func setWrongPhone()
    func setCorrectPhone()
    
    func setWrongEmail()
    func setCorrectEmail()
    
    func usernameExist()
    func emailExist()
    func unknownError()
    
    func goToEmailConfirmation()
}

protocol SignUpPresenterProtocol:AnyObject{
    var model:SignUpModel { get }
    init(view:SignUpViewProtocol, model:SignUpModel, networkService:UsersNetworkServiceProtocol)
    
    func textFieldChanged()
    func passwordDidChange(value:String)
    
    func phoneDidChange(value:String)
    func emailDidChange(value:String)
    
    
    func setFirstName(value:String)
    
    func setSecondName(value:String)
    
    func setMiddleName(value:String)
    /// Set login to model
    /// - Parameter value: login value
    func setLogin(value:String)
    
    /// Set email to model
    /// - Parameter value: email value
    func setEmail(value:String)
    
    
    /// Set Phone to model
    /// - Parameter value: phone value
    func setPhone(value:String)
    
    /// Set password to model
    /// - Parameter value: password value
    func setPassword(value:String)
    
    /// Set confirm password to model
    /// - Parameter value: confirm password value
    func setConfirmPassword(value:String)
    
    func signUpTapped()
}
class SignUpPresenter:SignUpPresenterProtocol{
    weak var view:SignUpViewProtocol?
    var model:SignUpModel
    var networkService:UsersNetworkServiceProtocol?
    
    
    required init(view:SignUpViewProtocol, model:SignUpModel, networkService:UsersNetworkServiceProtocol) {
        self.view = view
        self.model = model
        self.networkService = networkService
    }
    
    func textFieldChanged(){
        
        if !(model.isEmptyData()) &&
            AuthValidation.validatePassword(value: (model.password)) &&
            AuthValidation.validateEmail(value: model.email)
            && AuthValidation.validatePhone(value: model.phone)
            && model.password == model.confirmPassword{
            
            view?.enableRegisrationButton()
        }else{
            view?.disableRegisrationButton()
        }
    }
    
    func passwordDidChange(value:String){
        if !AuthValidation.validatePassword(value: value) {
            view?.setWeakPassword()
        }else{
            view?.setStrongPassword()
        }
    }
    
    func phoneDidChange(value:String){
        if !AuthValidation.validatePhone(value: value) {
            view?.setWrongPhone()
        }else{
            view?.setCorrectPhone()
        }
    }
    
    func emailDidChange(value:String){
        if !AuthValidation.validateEmail(value: value) {
            view?.setWrongEmail()
        }else{
            view?.setCorrectEmail()
        }
    }
    
    func setFirstName(value:String){
        model.firstName = value
    }
    
    func setSecondName(value:String){
        model.secondName = value
    }
    
    func setMiddleName(value:String){
        model.middleName = value
    }
    
    func setLogin(value:String){
        model.username = value
    }
    
    func setPhone(value:String){
        model.phone = value
    }
    
    func setEmail(value:String){
        model.email = value
    }
    
    func setPassword(value:String){
        model.password = value
    }
    
    func setConfirmPassword(value:String){
        model.confirmPassword = value
    }
    
    func signUpTapped(){
        Task {
            do{
                // check existing username
                                
                let isSignUp = try await networkService?.signUp(
                    body: SignUpRequestStruct(
                        firstName: model.firstName,
                        lastName: model.secondName,
                        middleName: model.middleName,
                        username: model.username,
                        email: model.email,
                        phone: model.phone,
                        password: model.password
                    )
                )
                                                
                if !(isSignUp ?? false){
                    DispatchQueue.main.async {
                        self.view?.unknownError()
                        return
                    }
                }else{
                    DispatchQueue.main.sync {
                        self.view?.goToEmailConfirmation()
                    }
                }
                
                
            }catch UsersError.emailExist {
                
                DispatchQueue.main.async {
                    self.view?.emailExist()
                }
                
            } catch UsersError.usernameExist{
                
                DispatchQueue.main.async {
                    self.view?.usernameExist()
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.view?.unknownError()
                }
                return
            }
            
        }
    }
    
}
