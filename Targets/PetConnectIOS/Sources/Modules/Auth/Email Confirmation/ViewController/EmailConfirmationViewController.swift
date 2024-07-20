//
//  EmailConfirmationViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit

class EmailConfirmationViewController: BaseUIViewController {
    
    var presenter: EmailConfirmationPresenterProtocol?
    
    //private var loadingUIView:LoadingUIView!
    
    private func view() -> EmailConfirmationView {
        return view as! EmailConfirmationView
    }
    
    override func loadView() {
        super.loadView()
        self.view = EmailConfirmationView()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        
        view().confirmButton.isEnabled = false
        view().confirmButton.backgroundColor = .lightGray.withAlphaComponent(0.2)
        view().confirmButton.setTitleColor(.gray, for: .normal)
        
        let codeStackViewTap = UITapGestureRecognizer(target: self, action: #selector(codeTapped))
        view().codeStackView.addGestureRecognizer(codeStackViewTap)
        
        view().resentButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
        view().confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        //self.loadingUIView = LoadingUIView(baseView: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view().firstDigitTextField.becomeFirstResponder()
        
        if !(presenter?.isValidEmail() ?? false){
            self.showEnterEmailAlert()
        }
        
    }
    
    
    /// configure passCode text field
    fileprivate func configureTextFields(){
        
        view().firstDigitTextField.addTarget(self, action: #selector(textFieldDidChange) , for: .editingChanged)
        view().secondDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view().thirdDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view().fourthDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        
        view().firstDigitTextField.delegate = self
        view().secondDigitTextField.delegate = self
        view().thirdDigitTextField.delegate = self
        view().fourthDigitTextField.delegate = self
    }
    
    /// handle the tap to stack view
    @objc func codeTapped(){
        view().firstDigitTextField.isUserInteractionEnabled = true
        view().firstDigitTextField.becomeFirstResponder()
        
        view().firstDigitTextField.text = ""
        view().secondDigitTextField.text = ""
        view().thirdDigitTextField.text = ""
        view().fourthDigitTextField.text = ""
        presenter?.passCode = []
    }
    
    /// handle changing text fields
    @objc func textFieldDidChange() {
        if view().firstDigitTextField.isFirstResponder {
            if view().firstDigitTextField.hasText {
                nextTextField(textField: view().firstDigitTextField, nextTextField: view().secondDigitTextField)
                if let digit = Int(view().firstDigitTextField.text ?? "") {
                    presenter?.passCode.append(digit)
                }
               
            }
        } else if view().secondDigitTextField.isFirstResponder {
            if view().secondDigitTextField.hasText {
                nextTextField(textField: view().secondDigitTextField, nextTextField: view().thirdDigitTextField)
                if let digit = Int(view().secondDigitTextField.text ?? "") {
                    presenter?.passCode.append(digit)
                }
            }
        } else if view().thirdDigitTextField.isFirstResponder {
            if view().thirdDigitTextField.hasText {
                nextTextField(textField: view().thirdDigitTextField, nextTextField: view().fourthDigitTextField)
                if let digit = Int(view().thirdDigitTextField.text ?? "") {
                    presenter?.passCode.append(digit)
                }
            }
        } else if view().fourthDigitTextField.isFirstResponder {
            if view().fourthDigitTextField.hasText {
                nextTextField(textField: view().fourthDigitTextField, nextTextField: nil)
                if let digit = Int(view().fourthDigitTextField.text ?? "") {
                    presenter?.passCode.append(digit)
                }
            }
        }
        if presenter?.passCode.count == 4 {
            view().confirmButton.isEnabled = true
            view().confirmButton.backgroundColor = UIColor(named: "GreetingGreen")
            view().confirmButton.setTitleColor(.white, for: .normal)
        }
    }
    
    
    @objc func confirmTapped() {
        //loadingUIView.activate()
        presenter?.confirmTapped()
    }
    
    @objc func resendTapped() {
        //loadingUIView.activate()
        presenter?.resendTapped()
    }
    
    
    /// set up next textfield
    /// - Parameters:
    ///   - textField: current TextField
    ///   - nextTextField: will setup TextField
    fileprivate func nextTextField(textField: UITextField, nextTextField: UITextField?) {
        if let next = nextTextField{
            next.isUserInteractionEnabled = true
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        textField.isUserInteractionEnabled = false
    }
    
    func showEnterEmailAlert() {
        let alert = UIAlertController(title: "Ваш аккаунт не активирован", message: "Введите ваш Email", preferredStyle: .alert)
        alert.addTextField()
        let actionSend = UIAlertAction(title: "Отправить код подтверждения", style: .default) { action in
            
            self.presenter?.setEmail(email: alert.textFields?[0].text ?? "")
            self.presenter?.resendTapped()
        }
        actionSend.isEnabled = false
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?.first, queue: .main) { _ in
            actionSend.isEnabled = AuthValidation.validateEmail(value: alert.textFields?.first?.text ?? "")
        }
        
        alert.addAction(actionSend)
        self.present(alert, animated: true)
    }
    
}

extension EmailConfirmationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if "0123456789".contains(string) {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addDoneCancelToolbar(showCancelButton: false)
    }
    
}

extension EmailConfirmationViewController: EmailConfirmationViewProtocol {
    func confirmationError() {
        //loadingUIView.deactivate()
        let alert = UIAlertController(title: "Ошибка подтверждения", message: "Повторите попытку", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func confrimationOk() {
        //loadingUIView.deactivate()

        MainBuilder.setMainWindow(window: view.window)
    }
    
    func resendOk() {
        //loadingUIView.deactivate()
        let alert = UIAlertController(title: "Код подтверждения был отправлен на почту", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func resendError() {
        //loadingUIView.deactivate()
        let alert = UIAlertController(title: "Ошибка отправки кода подтверждения", message: "Повторите попытку", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
}
