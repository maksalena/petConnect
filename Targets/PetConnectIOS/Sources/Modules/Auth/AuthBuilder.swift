//
//  AuthBuilder.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import UIKit
protocol AuthBuilderProtocol{
    
    /// creates SignIn Page
    /// - Returns: signIn UIViewController
    static func createSignInPage()->UIViewController
    
    /// creates SignUp Page
    /// - Returns: SignUp UIViewController
    ///
    static func createSignUpPage()->UIViewController
    
    /// creates account confirmation Page
    /// - Parameters:
    ///   - email: email value
    ///   - password: password value
    /// - Returns: account confirmation UIViewController
    static func createEmailConfirmationPage(model:SignUpModel)->UIViewController
}

class AuthBuilder:AuthBuilderProtocol{
    
    static func createSignInPage() -> UIViewController {
        let view = SignInViewController(navBar: .withBackButton, title: "")
        let model = signInModel()
        let networkService = AuthNetworkService()
        let keyChainService = KeyChainStorage()
        let presenter = SignInPresenter(view: view, model: model, networkService: networkService, keyChainService: keyChainService)
        view.presenter = presenter
        return view
    }
    
    static func createSignUpPage() -> UIViewController {
        let view = SignUpViewController(navBar: .withBackButton, title: "")
        let model = SignUpModel()
        let networkService = UsersNetworkService()
        let presenter = SignUpPresenter(view: view, model: model, networkService:networkService)
        view.presenter = presenter
        return view
    }
    
    static func createEmailConfirmationPage(model:SignUpModel)->UIViewController{
        let view = EmailConfirmationViewController(navBar: .withBackButton, title: "")
        let networkService = UsersNetworkService()
        let authNetworkService = AuthNetworkService()
        let keyChainService = KeyChainStorage()
        let presenter = EmailConfirmationPresenter(view: view,networkService: networkService, authNetworkService: authNetworkService, keyChainService: keyChainService, model:model)
        
        view.presenter = presenter
        return view
    }
    
}
