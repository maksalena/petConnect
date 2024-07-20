//
//  RequestView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 28.10.2023.
//

import UIKit
import SnapKit

class RequestView: UIView {
    var pet: DropDownMenu = {
        let menu = DropDownMenu(placeholder: "Выбрать")
        
        menu.cornerRadius = 28
        
        return menu
    }()
//    var claim: CustomTextField!
    
    lazy var claim: CustomTextField = {
        let textField = CustomTextField()
        
        textField.upperText = "Жалобы"
        textField.placeholder = "Жалобы"
        
        return textField
    }()
    
    var saveButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.baseBackgroundColor = .primary
        conf.baseForegroundColor = .white
        conf.cornerStyle = .capsule
        let button = UIButton(configuration: conf)
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.isEnabled = false
        
        return button
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(pet)
        addSubview(claim)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pet.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        claim.snp.makeConstraints { make in
            make.top.equalTo(pet.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}



#if DEBUG
import SwiftUI
#Preview(body: {
    RequestView().showPreview()
})
#endif



