//
//  SignInViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 26.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit

class SignInViewController: BaseUIViewController {
    
    var presenter: SignInPresenterProtocol?
    
    private func view() -> SignInView {
        return view as! SignInView
    }
    
    override func loadView() {
        super.loadView()
        self.view = SignInView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        
        view().loadingUIView = LoadingUIView(baseView: view())
        disableLogInButton()
        view().logInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
    }
    
    fileprivate func configureTextFields(){
        view().loginCustomView.delegate = self
        view().customPasswordView.delegate = self
        
    }
        
    
    // MARK: - Actions
    
    @objc func signInTapped(_ sender: Any) {
        view().loadingUIView.activate()
        presenter?.signInTapped()
    }
    
}

extension SignInViewController: CustomTextFieldDelegate {
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
        case "loginTextField":
            presenter?.setSignInData(type: .login, value: textField.text ?? "")
            
        case "passwordTextField":
            presenter?.setSignInData(type: .password, value: textField.text ?? "")
            
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        hideSignInError()
    }
    
}


extension SignInViewController: SignInViewProtocol {
    
    func showSignInError() {
        view().loadingUIView.deactivate()
        view().wrongPasswordLabel.layer.opacity = 1
    }
    func hideSignInError() {
        view().loadingUIView.deactivate()
        view().wrongPasswordLabel.layer.opacity = 0
    }
    
    func enableLogInButton() {
        view().logInButton.isEnabled = true
        view().logInButton.backgroundColor = UIColor(named: "GreetingGreen")
        view().logInButton.setTitleColor(.white, for: .normal)
    }
    
    func disableLogInButton() {
        view().logInButton.isEnabled = false
        view().logInButton.backgroundColor = .lightGray.withAlphaComponent(0.2)
        view().logInButton.setTitleColor(.gray, for: .normal)
    }
    
    func goToConfirmEmail(email: String, password: String) {
        view().loadingUIView.deactivate()
        
        let controller = AuthBuilder.createEmailConfirmationPage(
            model: SignUpModel(
                email: email,
                password: password
            )
        )
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToMainPage() {
        view().loadingUIView.deactivate()
        MainBuilder.setMainWindow(window: self.view.window)
    }
    
}
