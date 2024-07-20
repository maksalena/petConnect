//
//  TattooView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 13.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

class TattooView: UIView {

    private lazy var titleStack:UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        
        return stack
    }()
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 15)
        label.text = "Клеймо"
        
        return label
    }()
    
    lazy var closeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    lazy var textFieldsStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    lazy var tattooNumber:CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Номер клейма"
        textField.upperText = "Номер клейма"
        
        textField.restorationIdentifier = "markId"
        
        return textField
    }()
    
    lazy var tattooDate:DatePickerField = {
        let textField = DatePickerField(
            upperText: "Дата клеймирования",
            textFieldPlaceholder: "Дата клеймирования",
            supportingText: "",
            mode: .date
        )
        
        textField.restorationIdentifier = "markDate"
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.addSubview(titleStack)
        
        titleStack.addArrangedSubview(title)
        titleStack.addArrangedSubview(closeButton)
        
        self.addSubview(textFieldsStack)
        
        
        textFieldsStack.addArrangedSubview(tattooNumber)
        textFieldsStack.addArrangedSubview(tattooDate)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textFieldsStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}

#if DEBUG
import SwiftUI
#Preview(body: {
    TattooView().showPreview()
})
#endif
