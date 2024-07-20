//
//  ProfileView.swift
//  PetConnect
//
//  Created by SHREDDING on 15.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class ProfileView: UIView {
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var contentView:UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var avatarImageView:UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 75
        view.contentMode = .scaleAspectFill
        view.image = UIImage(resource: .avatar)
        view.clipsToBounds = true
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var changePhotoButton:UIButton = {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(
                string: "Изменить фотографию",
                attributes: [.font: UIFont.SFProDisplay(weight: .regualar, ofSize: 16)!, .foregroundColor: UIColor(hexString: "6D7A75")]
            ),
            for: .normal
        )
        
        return button
    }()
    
    
    lazy var fullNameLabel:UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .medium, ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var VStackView:UIStackView = {
        let view = UIStackView()
        view.axis =  .vertical
        
        return view
    }()
    
    lazy var logIn:ProfileElement = {
        let view = ProfileElement()
        
        view.leftImage.image = UIImage(systemName: "person")
        view.label.text = "login"
        return view
    }()
    
    lazy var email:ProfileElement = {
        let view = ProfileElement()
        
        view.leftImage.image = UIImage(systemName: "envelope")
        view.label.text = "login"
        return view
    }()
    
    lazy var phone:ProfileElement = {
        let view = ProfileElement()
        
        view.leftImage.image = UIImage(systemName: "phone")
        view.label.text = "89047813590"
        return view
    }()
    
    lazy var notifications:ProfileElement = {
        let view = ProfileElement()
        
        view.leftImage.image = UIImage(systemName: "bell")
        view.label.text = "Уведомления"
        return view
    }()
    
    lazy var notificationsSwitch:UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
    }()
    
    lazy var deleteAccount:ProfileElement = {
        let view = ProfileElement()
        
        view.leftImage.image = UIImage(systemName: "trash")
        view.leftImage.tintColor = .primary
        
        view.label.text = "Удалить аккаунт"
        view.label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 16)
        view.label.textColor = .primary
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var logOut:ProfileElement = {
        let view = ProfileElement()
        
        view.leftImage.image = UIImage(systemName: "door.left.hand.open")
        view.leftImage.tintColor = .primary
        
        view.label.text = "Выход"
        view.label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 16)
        view.label.textColor = .primary
        
        view.separtor.isHidden = true
        
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(changePhotoButton)
        
        self.contentView.addSubview(fullNameLabel)
        
        self.contentView.addSubview(VStackView)
        
        self.VStackView.addArrangedSubview(logIn)
        self.VStackView.addArrangedSubview(email)
        self.VStackView.addArrangedSubview(phone)
        self.VStackView.addArrangedSubview(notifications)
        self.VStackView.addArrangedSubview(deleteAccount)
        self.VStackView.addArrangedSubview(logOut)
        
        self.notifications.HStackView.addArrangedSubview(notificationsSwitch)
        
        
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
            
        }
        
        changePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(changePhotoButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        VStackView.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
    }
    
}

import SwiftUI
#Preview(body: {
    ProfileView().showPreview()
})
