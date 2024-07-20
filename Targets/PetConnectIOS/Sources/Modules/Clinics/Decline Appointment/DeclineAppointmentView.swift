//
//  DeclineAppointmentView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class DeclineAppointmentView: UIView {
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    lazy var scrollContent:UIView = {
        let view = UIView()
        
        return view
    }()
    
    
    lazy var ratingView: RatingView = {
        let view = RatingView()
        view.layer.opacity = 0
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var ratingCoverView:UIView = {
        let view = UIView()
        view.layer.opacity = 0
        view.backgroundColor = .black
        return view
    }()
    
    lazy var infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "approvedAppointment")
        image.layer.cornerRadius = 20
        image.layer.shadowColor = UIColor(resource: .shadow).cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize(width: 1, height: 1)
        image.layer.shadowRadius = 8
        
        return image
    }()
    
    var petNameLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Питомец"
        view.descriptionLabel.text = "Чубака"
        
        return view
    }()
    
    var specialisationLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Специализация врача"
        view.descriptionLabel.text = "Терапевт"
        
        return view
    }()
    
    var doctorLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Врач"
        view.descriptionLabel.text = "Шевченко Виктор Анатольевич"
        
        return view
    }()
    
    var dateAndTimeLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Дата и время"
        view.descriptionLabel.text = "10 сентября, 16:00"
        
        return view
    }()
    
    var complaineLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Жалобы"
        view.descriptionLabel.text = "Собака что то съела на улице и плохо себя чувствует"
        
        return view
    }()
    
    var clinicNameAndAddressLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Клиника"
        view.descriptionLabel.text = "PetLife, Чистопольская 34"
        
        return view
    }()
    
    var diagnoz: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Назначения"
        view.descriptionLabel.text = "Иссечение новообразования с обязательным гистологическим исследованием, коррекция назначений по результатам исследований"
        
        return view
    }()
    
    var recomendations: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Рекомендации"
        view.descriptionLabel.text = "Побольше поить водой..."
        
        return view
    }()
    
    var priceLabel: CheckDataItem = {
        let view = CheckDataItem()
        view.titleLabel.text = "Стоимость"
        view.descriptionLabel.text = "1000 ₽"
        
        return view
    }()
    
    lazy var itemsStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
    }()
    
    var declineButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить приём", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: "error"), for: .normal)
        button.layer.borderColor = UIColor(named: "error")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        
        addSubview(ratingCoverView)
        addSubview(ratingView)
        
        scrollContent.addSubview(itemsStack)
        
        itemsStack.addArrangedSubview(petNameLabel)
        itemsStack.addArrangedSubview(dateAndTimeLabel)
        itemsStack.addArrangedSubview(doctorLabel)
        itemsStack.addArrangedSubview(specialisationLabel)
        itemsStack.addArrangedSubview(complaineLabel)
        itemsStack.addArrangedSubview(clinicNameAndAddressLabel)
        
        addSubview(declineButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setStar(button:UIButton, isFilled:Bool){
        if isFilled{
            button.setBackgroundImage(UIImage(named: "filledStar"), for: .normal)
            button.setBackgroundImage(UIImage(named: "filledStar"), for: .highlighted)
        }
        else{
            button.setBackgroundImage(UIImage(named: "star"), for: .normal)
            button.setBackgroundImage(UIImage(named: "star"), for: .highlighted)
        }
    }
    
    public func configureNew(){
        itemsStack.insertArrangedSubview(infoImage, at: 0)
        itemsStack.addArrangedSubview(priceLabel)
        declineButton.layer.opacity = 1
        self.layoutSubviews()
    }
    
    public func configureRecent(){
        itemsStack.addArrangedSubview(diagnoz)
        itemsStack.addArrangedSubview(recomendations)
        declineButton.layer.opacity = 0
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(declineButton.snp.top)
        }
        
        scrollContent.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
        
        ratingCoverView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(160)
        }
        
        itemsStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        declineButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    DeclineAppointmentView().showPreview()
})
#endif
