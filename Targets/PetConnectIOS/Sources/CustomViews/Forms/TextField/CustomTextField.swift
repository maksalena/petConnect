//
//  CustomTextField.swift
//  PetConnect
//
//  Created by Егор Завражнов on 22.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Delegate Protocol
@objc protocol CustomTextFieldDelegate{
    @objc optional func customTextFieldDidChange(_ textField: UITextField)
    @objc optional func customTextFieldDidEndEditing(_ textField: UITextField)
    @objc optional func customTextFieldDidBeginEditing(_ textField: UITextField)
}

class CustomTextField: UIView {
    
    enum Colors{
        static let textColor:UIColor = .black
        static let focusedColor:UIColor = UIColor(resource: .greetingGreen)
        static let wrongValueColor:UIColor = UIColor(resource: .wrongValue)
    }
    
    public var delegate:CustomTextFieldDelegate?
    
    // MARK: - Views
    private lazy var borderView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        
        view.layer.cornerRadius = 28
        
        return view
    }()
    
    private lazy var upperLabelView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var upperLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 12)
        label.textColor = .greetingGreen
        label.textAlignment = .center
        
        return label
    }()
    
    internal lazy var textField:UITextField = {
        let textField = UITextField()
        textField.font = UIFont.SFProDisplay(weight: .medium, ofSize: 16)
        textField.textAlignment = .left
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        
//        textField.text = "TextField"
        return textField
    }()
    
    private lazy var supportingTextLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        
        label.numberOfLines = 0
//        label.text = "supporting Text Label"
        return label
    }()
    
    
    // MARK: - Public properties
    open var placeholder:String = ""{
        didSet{
            self.textField.placeholder = placeholder
        }
    }
    
    open var upperText:String = ""{
        didSet{
            self.upperLabel.text = upperText
        }
    }
    
    open var supportingText:String = ""{
        didSet{
            self.supportingTextLabel.text = supportingText
        }
    }
    
    open var isSecure:Bool = false{
        didSet{
            self.textField.isSecureTextEntry = isSecure
        }
    }
    
    open var isEnabled:Bool = true {
        didSet{
            if isEnabled{
                self.enable()
            }else{
                self.disable()
            }
        }
    }
    
    open var text: String = "" {
        didSet{
            self.textField.text = text
        }
    }
    
    open var keyboardType:UIKeyboardType = .default{
        didSet{
            self.textField.keyboardType = keyboardType
        }
    }
    
    open var textFieldType:UITextContentType = .name{
        didSet{
            self.textField.textContentType = textFieldType
        }
    }
    
    open var showUpperLabelWhenTextFieldIsEmpty:Bool = false
    open var showUpperLabelWhenTextFieldIsNotEmty:Bool = true
    
    open override var restorationIdentifier: String?{
        didSet{
            self.textField.restorationIdentifier = restorationIdentifier
        }
    }
    
    open var upperTextBackgroundColor:UIColor = .white{
        didSet{
            self.upperLabelView.backgroundColor = upperTextBackgroundColor
            self.upperLabel.backgroundColor = upperTextBackgroundColor
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
//        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        self.backgroundColor = .white
                
        self.addSubview(borderView)
        self.addSubview(upperLabelView)
        self.upperLabelView.addSubview(upperLabel)
        
        borderView.addSubview(textField)
        
        self.addSubview(supportingTextLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        // MARK: - Upper label
        upperLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview()
        }
        
        upperLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-7)
            make.leading.equalToSuperview().offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        supportingTextLabel.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom ).offset(4)
            make.trailing.leading.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}


// MARK: - public textField Functions
extension CustomTextField{
    
    public func setWrongValue(){
        self.borderView.layer.borderColor = Colors.wrongValueColor.cgColor
        self.upperLabel.textColor = Colors.wrongValueColor
        self.supportingTextLabel.textColor = Colors.wrongValueColor
        self.textField.tintColor = Colors.wrongValueColor
    }
    
    public func setCorrectValue(){
        self.borderView.layer.borderColor = Colors.focusedColor.cgColor
        self.upperLabel.textColor = Colors.focusedColor
        self.supportingTextLabel.textColor = Colors.focusedColor
        self.textField.tintColor = Colors.focusedColor
    }
    
}

// MARK: - private textField Functions
extension CustomTextField{
    private func showUpperText(){
        UIView.animate(withDuration: 0.3) {
            self.upperLabelView.layer.opacity = 1
        }
    }
    
    private func hideUpperText(){
        UIView.animate(withDuration: 0.3) {
            self.upperLabelView.layer.opacity = 0
        }
    }
    
    private  func enable(){
        self.textField.isUserInteractionEnabled = true
        self.layer.opacity = 1
        self.borderView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func disable(){
        self.textField.isUserInteractionEnabled = false
        self.layer.opacity = 0.5
        self.borderView.layer.borderColor = UIColor.systemGray3.cgColor
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate{
    
    @objc private func textFieldDidChange(){

        self.text = self.textField.text ?? ""
        delegate?.customTextFieldDidChange?(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.borderView.layer.borderColor = Colors.textColor.cgColor
        self.upperLabel.textColor = Colors.textColor
        self.supportingTextLabel.textColor = Colors.textColor
        
        if !self.showUpperLabelWhenTextFieldIsEmpty && !textField.hasText{
            self.hideUpperText()
        }
        
        if !self.showUpperLabelWhenTextFieldIsNotEmty && textField.hasText{
            self.hideUpperText()
        }
        delegate?.customTextFieldDidEndEditing?(textField)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showUpperText()
        self.borderView.layer.borderColor = Colors.focusedColor.cgColor
        self.upperLabel.textColor = Colors.focusedColor
        
        delegate?.customTextFieldDidBeginEditing?(textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    CustomTextField().showPreview()
})
#endif
