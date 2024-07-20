//
//  EmailConfirmationView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 28.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class EmailConfirmationView: UIView {
    
    lazy var codeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()

    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "На вашу почту был отправлен код, введите его\n ниже"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var firstDigitTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var secondDigitTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var thirdDigitTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var fourthDigitTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var noCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Не пришел код?"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var resentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить еще раз", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    lazy var underscore1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        return view
    }()
    
    lazy var underscore2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        return view
    }()
    
    lazy var underscore3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        return view
    }()
    
    lazy var underscore4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        return view
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(infoLabel)
        addSubview(noCodeLabel)
        addSubview(resentButton)
        addSubview(confirmButton)
        
        addSubview(underscore1)
        addSubview(underscore2)
        addSubview(underscore3)
        addSubview(underscore4)
        
        addSubview(codeStackView)
        codeStackView.addArrangedSubview(firstDigitTextField)
        codeStackView.addArrangedSubview(secondDigitTextField)
        codeStackView.addArrangedSubview(thirdDigitTextField)
        codeStackView.addArrangedSubview(fourthDigitTextField)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        codeStackView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(noCodeLabel.snp.top).offset(-40)
        }
        
        noCodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstDigitTextField.snp.leading).offset(15)
            make.height.equalTo(50)
        }
        
        resentButton.snp.makeConstraints { make in
            make.trailing.equalTo(fourthDigitTextField.snp.trailing).inset(15)
            make.top.equalTo(noCodeLabel.snp.top)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
        
        firstDigitTextField.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        secondDigitTextField.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        thirdDigitTextField.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        fourthDigitTextField.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        underscore1.snp.makeConstraints { make in
            make.top.equalTo(firstDigitTextField.snp.bottom).offset(3)
            make.leading.equalTo(firstDigitTextField.snp.leading)
            make.height.equalTo(1)
            make.width.equalTo(firstDigitTextField.snp.width)
        }
        
        underscore2.snp.makeConstraints { make in
            make.top.equalTo(secondDigitTextField.snp.bottom).offset(3)
            make.leading.equalTo(secondDigitTextField.snp.leading)
            make.height.equalTo(1)
            make.width.equalTo(secondDigitTextField.snp.width)
        }
        
        underscore3.snp.makeConstraints { make in
            make.top.equalTo(thirdDigitTextField.snp.bottom).offset(3)
            make.leading.equalTo(thirdDigitTextField.snp.leading)
            make.height.equalTo(1)
            make.width.equalTo(thirdDigitTextField.snp.width)
        }
        
        underscore4.snp.makeConstraints { make in
            make.top.equalTo(fourthDigitTextField.snp.bottom).offset(3)
            make.leading.equalTo(fourthDigitTextField.snp.leading)
            make.height.equalTo(1)
            make.width.equalTo(fourthDigitTextField.snp.width)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    EmailConfirmationView().showPreview()
})
#endif
