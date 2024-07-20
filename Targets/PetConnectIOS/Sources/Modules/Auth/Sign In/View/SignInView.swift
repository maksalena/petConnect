//
//  SignInView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 26.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class SignInView: UIView {
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .boldSystemFont(ofSize: 32)
        
        return label
    }()
    
    lazy var loginCustomView: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Логин или email"
        textField.upperText = "Логин или email"
        textField.restorationIdentifier = "loginTextField"
        
        textField.keyboardType = .emailAddress
        textField.textFieldType = .username
        
        return textField
    }()
    
    lazy var customPasswordView: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Пароль"
        textField.upperText = "Пароль"
        textField.isSecure = true
        textField.restorationIdentifier = "passwordTextField"
        
        textField.keyboardType = .default
        textField.textFieldType = .password
        
        return textField
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    lazy var wrongPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Неверно введен логин или пароль"
        label.textColor = UIColor(named: "error")
        label.font = .systemFont(ofSize: 12)
        label.alpha = 0
        
        return label
    }()
    
    lazy var loadingUIView: LoadingUIView = {
        let view = LoadingUIView()
        return view
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(signInLabel)
        addSubview(loginCustomView)
        addSubview(customPasswordView)
        addSubview(logInButton)
        addSubview(wrongPasswordLabel)
        //addSubview(loadingUIView)
        
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
        
        loginCustomView.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(18)
            make.left.right.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(80)
        }
        
        customPasswordView.snp.makeConstraints { make in
            make.top.equalTo(loginCustomView.snp.bottom).inset(12)
            make.left.right.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(80)
        }
        
        wrongPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(customPasswordView.snp.bottom).inset(6)
            make.centerX.equalToSuperview()
            
        }
        
        logInButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(20).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
        
    }
}

