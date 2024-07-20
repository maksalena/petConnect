//
//  ChipView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 13.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class ChipView: UIView {
    
    private lazy var titleStack:UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        
        return stack
    }()
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 15)
        label.text = "Чип"
        
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
    
    lazy var chipNumber:CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Номер чипа"
        textField.upperText = "Номер чипа"
        
        textField.restorationIdentifier = "chipId"
        
        return textField
    }()
    
    lazy var chipDate:DatePickerField = {
        let textField = DatePickerField(
            upperText: "Дата имплантации",
            textFieldPlaceholder: "Дата имплантации",
            supportingText: "",
            mode: .date
        )
        
        textField.restorationIdentifier = "chipDate"
        return textField
    }()
    
    lazy var chipPlace:CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Место имплантации"
        textField.upperText = "Место имплантации"
        
        textField.restorationIdentifier = "chipPlace"
        
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
        
        
        textFieldsStack.addArrangedSubview(chipNumber)
        textFieldsStack.addArrangedSubview(chipDate)
        textFieldsStack.addArrangedSubview(chipPlace)
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
    ChipView().showPreview()
})
#endif
