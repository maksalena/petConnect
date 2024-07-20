//
//  DatePickerField.swift
//  PetConnect
//
//  Created by SHREDDING on 20.09.2023.
//

import UIKit

class DatePickerField: CustomTextField{
    
    var datePicker:UIDatePicker!
        
    init(upperText: String, textFieldPlaceholder: String, supportingText: String, mode: UIDatePicker.Mode) {
        super.init(frame: .zero)
        
        datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = mode
        
        
        self.upperText = upperText
        self.placeholder = textFieldPlaceholder
        self.supportingText = supportingText
        
        commonInit()
    }
    
    
    func commonInit(){
        
        self.textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func datePickerChanged(){
        switch datePicker.datePickerMode {
        case .time:
            self.text = datePicker.date.timeToString()
            self.delegate?.customTextFieldDidChange?(self.textField)
        case .date:
            self.text = datePicker.date.toString()
            self.delegate?.customTextFieldDidChange?(self.textField)
        case .dateAndTime:
            break
        case .countDownTimer:
            break
        @unknown default:
            break
        }
        
    }
}
