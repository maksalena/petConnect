//
//  GreetingView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class GreetingView: UIView {
    
    lazy var appTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        
        let appTitleString = NSMutableAttributedString(
            string: "Pet",
            attributes: [
                .foregroundColor : UIColor.black,
                .font : UIFont(name: "SFProDisplay-Regular", size: 34)!
            ]
        )
        
        appTitleString.append(
            NSAttributedString(
                string: "Connect",
                attributes: [
                    .foregroundColor : UIColor(named: "GreetingGreen")!,
                    .font : UIFont(name: "SFProDisplay-Regular", size: 34)!
                ]
            )
        )
        
        label.attributedText = appTitleString
        
        return label
    }()
    
    lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Привет!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var dogImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Greeting")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = UIColor(named: "select")
        button.setTitleColor(UIColor(named: "GreetingGreen"), for: .normal)
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = UIColor(named: "GreetingGreen")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addSubview(appTitle)
        addSubview(greetingLabel)
        addSubview(dogImage)
        addSubview(signInButton)
        addSubview(signUpButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        appTitle.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.right.left.equalToSuperview()
            make.height.equalTo(30)
        }
        
        greetingLabel.snp.makeConstraints { make in
            make.top.equalTo(appTitle.snp.bottom).offset(20)
            make.right.left.equalToSuperview()
            make.height.equalTo(30)
        }
        
        dogImage.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(signInButton.snp.bottom).inset(15)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(15).inset(15)
            make.height.equalTo(44)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            
        }
        
        signInButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(15).inset(15)
            make.height.equalTo(44)
            make.bottom.equalTo(signUpButton.snp.top).inset(-15)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    GreetingView().showPreview()
})
#endif
