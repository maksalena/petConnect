//
//  OneNotificationView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 10.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

protocol OneNotificationViewDelegate{
    func didRemove(index:Int)
}

class OneNotificationView: UIView {
    
    var delegate:OneNotificationViewDelegate?
    
    open var index:Int = 0{
        didSet{
            notificationLabel.text = "\(index) прием"
            amount.restorationIdentifier = "amount_\(index)"
            time.restorationIdentifier = "time_\(index)"
        }
    }
    
    private lazy var titleStack:UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalCentering
        stack.axis = .horizontal
        
        return stack
    }()
    
    private lazy var notificationLabel:UILabel = {
        let label = UILabel()
        label.text = "1 прием"
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var deleteButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(removeFromView), for: .touchUpInside)
        
        return button
    }()
    
    lazy var amount:CustomTextField = {
        let textField = CustomTextField()
        textField.upperText = "Количество шт/гр"
        textField.placeholder = "150 гр"
        textField.restorationIdentifier = "amount"
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var time:DatePickerField = {
        let view = DatePickerField(
            upperText: "Время ЧЧ:ММ",
            textFieldPlaceholder: "15:30",
            supportingText: "",
            mode: .time
        )
        view.restorationIdentifier = "time"
        
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
        self.addSubview(titleStack)
        titleStack.addArrangedSubview(notificationLabel)
        titleStack.addArrangedSubview(deleteButton)
        
        self.addSubview(amount)
        self.addSubview(time)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        amount.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        time.snp.makeConstraints { make in
            make.top.equalTo(amount.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func removeFromView(){
        self.removeFromSuperview()
        self.delegate?.didRemove(index: self.index)
    }

}

#if DEBUG
import SwiftUI
#Preview(body: {
    OneNotificationView().showPreview()
})
#endif
