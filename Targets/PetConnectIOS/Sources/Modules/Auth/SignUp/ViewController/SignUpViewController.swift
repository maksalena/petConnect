//
//  SignUpViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit

class SignUpViewController: BaseUIViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    private func view() -> SignUpView {
        return view as! SignUpView
    }
    
    override func loadView() {
        super.loadView()
        self.view = SignUpView()
    }
    
    //private var loadingUIView:LoadingUIView!
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObservers()
        configureTextFields()
        disableRegisrationButton()
        view().signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        //view().loadingUIView = LoadingUIView(baseView: view())
        
    }
    
    fileprivate func configureTextFields(){
        view().usernameCustomTextField.delegate = self
        
        view().firstNameCustomTextField.delegate = self
        view().secondNameCustomTextField.delegate = self
        view().middleNameCustomTextField.delegate = self
        
        view().emailCustomTextField.delegate = self
        view().phoneCustomTextField.delegate = self
        view().passwordCustomTextField.delegate = self
        view().confirmPasswordCustomTextField.delegate = self
        
    }
    
    fileprivate func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification){
        
        if var keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboard = self.view.convert(keyboard, from: nil)
            
            var contentInset:UIEdgeInsets = self.view().scrollView.contentInset
            contentInset.bottom = keyboard.size.height - self.view().signUpButton.frame.height
            self.view().scrollView.contentInset = contentInset
        }
        
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.view().scrollView.contentInset = contentInset
    }
    

    @objc func signUpTapped(_ sender: Any) {
        view().errorLabel.setOpacity(opacity: 0, animated: true)
        //view().loadingUIView.activate()
        presenter?.signUpTapped()
    }
    
}

extension SignUpViewController:CustomTextFieldDelegate{
    
    func customTextFieldShouldReturn(_ textField: UITextField) {
        view().scrollView.setContentOffset(.zero, animated: true)
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        view().errorLabel.setOpacity(opacity: 0, animated: true)
        
        switch textField.restorationIdentifier{
            
        case "passwordTextField":
            customTextFieldDidChange(textField)
        
        case "phoneTextField":
            customTextFieldDidChange(textField)
            textField.addDoneCancelToolbar(showCancelButton: false)
        
        case "emailTextField":
            customTextFieldDidChange(textField)
            
        default:
            break
        }
    }
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
            
        case "loginTextField":
            presenter?.setLogin(value: textField.text ?? "")
            
        case "firstNameTextField":
            presenter?.setFirstName(value: textField.text ?? "")
        
        case "secondNameTextField":
            presenter?.setSecondName(value: textField.text ?? "")
        
        case "middleNameTextField":
            presenter?.setMiddleName(value: textField.text ?? "")
            
        case "emailTextField":
            presenter?.setEmail(value: textField.text ?? "")
            
        case "phoneTextField":
            presenter?.setPhone(value: textField.text ?? "")
            
        case "passwordTextField":
            presenter?.setPassword(value: textField.text ?? "")
            
        case "confirmPasswordTextField":
            presenter?.setConfirmPassword(value: textField.text ?? "")
            
        default:
            break
        }
        
        presenter?.textFieldChanged()
    }
    
    func customTextFieldDidChange(_ textField: UITextField) {
        if textField.restorationIdentifier == "passwordTextField"{
            presenter?.passwordDidChange(value: textField.text ?? "")
        }else if textField.restorationIdentifier == "phoneTextField"{
            presenter?.phoneDidChange(value: textField.text ?? "")
        } else if textField.restorationIdentifier == "emailTextField"{
            presenter?.emailDidChange(value: textField.text ?? "")
        }
    }
    
}

extension SignUpViewController:SignUpViewProtocol{
    
    func enableRegisrationButton() {
        view().signUpButton.isEnabled = true
        view().signUpButton.backgroundColor = UIColor(named: "GreetingGreen")
        view().signUpButton.setTitleColor(.white, for: .normal)
    }
    
    func disableRegisrationButton() {
        view().signUpButton.isEnabled = false
        view().signUpButton.backgroundColor = .lightGray.withAlphaComponent(0.2)
        view().signUpButton.setTitleColor(.gray, for: .normal)
    }
    
    func setWeakPassword(){
        view().passwordCustomTextField.setWrongValue()
    }
    
    func setStrongPassword(){
        view().passwordCustomTextField.setCorrectValue()
    }
    
    func setWrongPhone(){
        view().phoneCustomTextField.setWrongValue()
    }
    
    func setCorrectPhone(){
        view().phoneCustomTextField.setCorrectValue()
    }
    
    func setWrongEmail(){
        view().emailCustomTextField.setWrongValue()
    }
    func setCorrectEmail(){
        view().emailCustomTextField.setCorrectValue()
    }
    
    func usernameExist() {
        view().errorLabel.text = "Такой логин уже существует"
        view().errorLabel.setOpacity(opacity: 1, animated: true)
        //view().loadingUIView.deactivate()
    }
    
    func emailExist() {
        view().errorLabel.text = "Такой email уже существует"
        view().errorLabel.setOpacity(opacity: 1, animated: true)
        //view().loadingUIView.deactivate()
    }
    
    func unknownError() {
        view().errorLabel.text = "Неизвестная ошибка"
        view().errorLabel.setOpacity(opacity: 1, animated: true)
        //view().loadingUIView.deactivate()
    }
    
    func goToEmailConfirmation(){
        //view().loadingUIView.deactivate()
        if let model = presenter?.model{
            let controller = AuthBuilder.createEmailConfirmationPage(model: model)
            
            self.navigationController?.pushViewController(controller, animated: true)
            self.navigationController?.viewControllers.remove(at: (self.navigationController?.viewControllers.endIndex)! - 2)
        }
        
    }
    
}
