//
//  AddPetView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 22.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class AddPetView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
    
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()

        return contentView
    }()
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar.png")
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 36
                
        return image
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить фотографию", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        
        return button
    }()
    
    lazy var name:CustomTextField = {
        let textField = CustomTextField()
        textField.upperText = "Имя*"
        textField.placeholder = "Имя*"
        
        textField.keyboardType = .default
        textField.textFieldType = .name
        
        textField.restorationIdentifier =  "nameTextField"
        return textField
    }()
    
    lazy var typeAnimal:DropDownMenu = {
        let menu = DropDownMenu(placeholder: "Тип*")
        menu.upperLabel.text = "Тип*"
        menu.restorationIdentifier =  "typeTextField"
        menu.cornerRadius = 28
        
        return menu
    }()
    
    lazy var breed:CustomTextField = {
        let textField = CustomTextField()
        textField.upperText = "Порода*"
        textField.placeholder = "Порода*"
        
        textField.restorationIdentifier =  "breedTextField"
        return textField
    }()
    
    lazy var birthday:DatePickerField = {
        let view = DatePickerField(
            upperText: "Дата рождения*",
            textFieldPlaceholder: "Дата рождения*",
            supportingText: "",
            mode: .date
        )
        
        view.restorationIdentifier = "birthdayTextField"
        
        return view
    }()
    
    lazy var gender:HBSegmentedControl = {
        let view = HBSegmentedControl()
        view.items = ["девочка", "мальчик"]
        view.borderColor = .clear
        view.selectedLabelColor = UIColor(named: "darkGreen") ?? .white
        view.unselectedLabelColor = .black
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .white
        view.thumbColor = UIColor(named: "select") ?? .green
        view.selectedIndex = 0
        
        return view
    }()
    
    lazy var additionalInfoStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        return stack
    }()
    
    lazy var addChip: UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.baseForegroundColor = UIColor(resource: .primary)
        conf.image = UIImage(systemName: "plus")
        conf.imagePlacement = .leading
        conf.buttonSize = .small
        conf.imagePadding = 8
        
        let button = UIButton(configuration: conf)
        button.setTitle("Добавить чип", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    lazy var addMark: UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.baseForegroundColor = UIColor(resource: .primary)
        conf.image = UIImage(systemName: "plus")
        conf.imagePlacement = .leading
        conf.buttonSize = .small
        conf.imagePadding = 8
        
        let button = UIButton(configuration: conf)
        button.setTitle("Добавить клеймо", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    lazy var chipView:ChipView = {
        let view = ChipView()
        
        view.restorationIdentifier = "chip"
        
        return view
    }()
    
    lazy var tattooView:TattooView = {
        let view = TattooView()
        
        view.restorationIdentifier = "mark"
        
        return view
    }()
    
    
    lazy var buttonsStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
    }()
    lazy var saveButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.baseBackgroundColor = UIColor(resource: .primary)
        conf.cornerStyle = .capsule
        
        let button = UIButton(configuration: conf)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить питомца", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.error, for: .normal)
        button.layer.borderColor = UIColor(resource: .error).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 21
        
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
        self.backgroundColor = .white
        
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(addPhotoButton)
        self.contentView.addSubview(name)
        self.contentView.addSubview(typeAnimal)
        self.contentView.addSubview(breed)
        self.contentView.addSubview(birthday)
        
        self.contentView.addSubview(gender)
        
        self.contentView.addSubview(additionalInfoStack)
        
        self.additionalInfoStack.addArrangedSubview(addChip)
        self.additionalInfoStack.addArrangedSubview(addMark)
        
        self.addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(saveButton)
        
        
        self.typeAnimal.configure()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(buttonsStack.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        avatarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        
        typeAnimal.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        breed.snp.makeConstraints { make in
            make.top.equalTo(typeAnimal.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        birthday.snp.makeConstraints { make in
            make.top.equalTo(breed.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        gender.snp.makeConstraints { make in
            make.top.equalTo(birthday.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        additionalInfoStack.snp.makeConstraints { make in
            make.top.equalTo(gender.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    public func addDeleteButton(){
        buttonsStack.addArrangedSubview(deleteButton)
    }
    
    public func addChipView(){
        self.additionalInfoStack.insertArrangedSubview(chipView, at: 0)
        addChip.removeFromSuperview()
        self.layoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) { [self] in
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    public func addTattooView(){
        self.additionalInfoStack.insertArrangedSubview(tattooView, at: 1)
        addMark.removeFromSuperview()
        
        self.layoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) { [self] in
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    public func removeChipView(){
        self.additionalInfoStack.insertArrangedSubview(addChip, at: 0)
        chipView.removeFromSuperview()
    }
    
    public func removeTattooView(){
        self.additionalInfoStack.insertArrangedSubview(addMark, at: 1)
        tattooView.removeFromSuperview()
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    AddPetView().showPreview()
})
#endif
