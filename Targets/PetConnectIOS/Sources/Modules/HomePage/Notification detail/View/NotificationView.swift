//
//  NotificationView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 09.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class NotificationView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
    
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()

        return contentView
    }()
    
    var category: DropDownMenu = {
        let view = DropDownMenu(
            items: ["Корм", "Лекарство"],
            placeholder: "Категория*"
        )
        
        view.cornerRadius = 30
        
        return view
    }()
    
    lazy var name:CustomTextField = {
        let textField = CustomTextField()
        textField.restorationIdentifier = "nameTextField"
        textField.upperText = "Название*"
        textField.placeholder = "Название*"
        return textField
    }()
    
    lazy var date:DatePickerField = {
        let view = DatePickerField(
            upperText: "Дата окончания*",
            textFieldPlaceholder: "Дата окончания*",
            supportingText: "01.01.2023",
            mode: .date
        )
        
        view.restorationIdentifier = "dateTextField"
        
        return view
    }()
    
    
    lazy var notificationsStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        
        return stack
    }()
    
    lazy var addButton: UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.image = UIImage(systemName: "plus")
        conf.imagePlacement = .leading
        conf.imagePadding = 8
        conf.buttonSize = .mini
        conf.baseForegroundColor = .primary
        
        let button = UIButton(configuration: conf)
        button.setTitle("Добавить прием", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        return button
    }()
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .clear
        stack.spacing = 12
        
        return stack
    }()
    
    lazy var saveButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.cornerStyle = .capsule
        conf.baseBackgroundColor = .primary
        
        let button = UIButton(configuration: conf)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        var conf = UIButton.Configuration.bordered()
        conf.cornerStyle = .capsule
        conf.baseForegroundColor = UIColor(resource: .error)
        conf.baseBackgroundColor = .clear
        
        let button = UIButton(configuration: conf)
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.layer.borderColor = UIColor(resource: .error).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 22
        
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        self.addSubview(scrollView)
        self.addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(saveButton)
        
        
        self.scrollView.addSubview(contentView)
        
        self.contentView.addSubview(category)
        self.contentView.addSubview(name)
        self.contentView.addSubview(date)
        self.contentView.addSubview(notificationsStack)
        self.contentView.addSubview(addButton)
    }
    
    public func addDeleteButton(){
        buttonsStack.addArrangedSubview(deleteButton)
        self.layoutSubviews()
    }
    
    public func addNotification(view:OneNotificationView){
        self.notificationsStack.addArrangedSubview(view)
        UIView.transition(with: notificationsStack, duration: 0.3, options: .transitionCrossDissolve) {
            self.layoutSubviews()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(saveButton.snp.top)
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        category.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(category.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        notificationsStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(date.snp.bottom).offset(8)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.top.equalTo(notificationsStack.snp.bottom).offset(12)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    NotificationView().showPreview()
})
#endif
