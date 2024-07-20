//
//  SignUpView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    // MARK: - @IBOutlets
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    lazy var scrollContent: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .boldSystemFont(ofSize: 32)
        
        return label
    }()
    
    lazy var firstNameCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Имя"
        textField.upperText = "Имя"
        textField.restorationIdentifier = "firstNameTextField"
        
        return textField
    }()
    
    lazy var secondNameCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Фамилия"
        textField.upperText = "Фамилия"
        textField.restorationIdentifier = "secondNameTextField"
        
        return textField
    }()
    
    lazy var middleNameCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Отчество (Необзятельно)"
        textField.upperText = "Отчество"
        textField.restorationIdentifier = "middleNameTextField"
        
        return textField
    }()
    
    lazy var usernameCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Логин"
        textField.upperText = "Логин"
        textField.restorationIdentifier = "loginTextField"
        
        return textField
    }()
    
    lazy var phoneCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Номер телефона"
        textField.upperText = "Номер телефона"
        textField.restorationIdentifier = "phoneTextField"
        
        textField.supportingText = "Телефон должен начинаться с кода страны"
        
        textField.keyboardType = .phonePad
        
        return textField
    }()
    
    lazy var emailCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Email"
        textField.upperText = "Email"
        textField.restorationIdentifier = "emailTextField"
        
        textField.textFieldType = .countryName
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    lazy var passwordCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Пароль"
        textField.upperText = "Пароль"
        textField.supportingText = "Пароль должен содержать не менее 8-ми символов, в том числе цифры, прописные и строчные буквы латинского алфавита а также специальный символ"
        
        textField.restorationIdentifier = "passwordTextField"
        
        textField.textFieldType = .oneTimeCode
        textField.isSecure = true
        
        return textField
    }()
    
    lazy var confirmPasswordCustomTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Повторите пароль"
        textField.upperText = "Повторите пароль"
        textField.restorationIdentifier = "confirmPasswordTextField"
        
        textField.textFieldType = .oneTimeCode
        textField.isSecure = true
        
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 1
        label.textColor = UIColor(named: "error")
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var textFieldsStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(signInLabel)
        
        addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        
        scrollContent.addSubview(textFieldsStack)
        
        textFieldsStack.addArrangedSubview(firstNameCustomTextField)
        textFieldsStack.addArrangedSubview(secondNameCustomTextField)
        textFieldsStack.addArrangedSubview(middleNameCustomTextField)
        textFieldsStack.addArrangedSubview(phoneCustomTextField)
        
        textFieldsStack.addArrangedSubview(usernameCustomTextField)
        textFieldsStack.addArrangedSubview(emailCustomTextField)
        textFieldsStack.addArrangedSubview(passwordCustomTextField)
        textFieldsStack.addArrangedSubview(confirmPasswordCustomTextField)
        textFieldsStack.addArrangedSubview(errorLabel)
        
        addSubview(signUpButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(15)
            make.bottom.equalTo(signUpButton.snp.top).offset(-15)
            make.leading.trailing.equalToSuperview()
        }
        
        scrollContent.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        textFieldsStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    SignUpView().showPreview()
})
#endif

