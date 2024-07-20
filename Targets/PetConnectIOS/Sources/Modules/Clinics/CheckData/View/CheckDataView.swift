//
//  CheckDataView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 28.10.2023.
//

import UIKit
import SnapKit

class CheckDataView: UIView {
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
    }()
    
    lazy var scrollContent:UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var specialization: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Специализация врача"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var doctor: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Врач"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var dateTime: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Дата и время"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var pet: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Питомец"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var complance: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Жалобы"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var clinic: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Клиника"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var price: CheckDataItem = {
        let item = CheckDataItem()
        item.titleLabel.text = "Стоимость"
        item.descriptionLabel.text = "test"
        
        return item
    }()
    
    lazy var stack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Записаться на прием", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        self.addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        
        scrollContent.addSubview(stack)
        
        stack.addArrangedSubview(specialization)
        stack.addArrangedSubview(doctor)
        stack.addArrangedSubview(dateTime)
        stack.addArrangedSubview(pet)
        stack.addArrangedSubview(complance)
        stack.addArrangedSubview(clinic)
        stack.addArrangedSubview(price)
        
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(saveButton.snp.top)
        }
        
        scrollContent.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
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
    CheckDataView().showPreview()
})
#endif




