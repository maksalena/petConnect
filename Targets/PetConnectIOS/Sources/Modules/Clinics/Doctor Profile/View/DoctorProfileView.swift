//
//  DoctorProfileView.swift
//  PetConnect
//
//  Created by SHREDDING on 07.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class DoctorProfileView: UIView {
    // MARK: - Views
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var contentView:UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var doctorImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .medicalWorker)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var specializations:DynamicHeightCollectionView = {
        let layout = LeftAligmentCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 4

        let collection = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SpecializationCollectionViewCell.self, forCellWithReuseIdentifier: "SpecializationCollectionViewCell")
        
        collection.restorationIdentifier = "calendar"
        collection.isScrollEnabled = false
        
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    lazy var fullName:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 28)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Петров Анатолий\nВалерьевич"
        return label
    }()
    
    lazy var experienceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        
        label.text = "Стаж: 21 год"
        return label
    }()
    
    lazy var jobPlaceTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        
        label.text = "Место работы"
        return label
    }()
    
    lazy var jobPlace:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        
        label.text = "Ветклиника “PetLife” на ул. Чистопольская 34/1, Казань"
        return label
    }()
    
    lazy var educationTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        
        label.text = "Образование"
        return label
    }()
    
    lazy var educationDescription:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        
        label.text = "Окончил Сибирский государственный медицинский университет, в связи с чем ему присуждена квалификация врача по специальности \"Лечебное дело\" (диплом с отличием ВСА 0201261 Рег.№86 от 27.06.2005г.).Прошел подготовку в клинической ординатуре по специальности \"Терапия\" рег.№806 от 31.08.2008г."
        return label
    }()
    
    lazy var additionalInfoTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        
        label.text = "Дополнительная информация"
        return label
    }()
    
    lazy var additionalInfoDescription:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        
        label.text = "Сертификат №0670316136763 \"Терапия\" подтвержден до 10.02.2023г.\n\nСертификат №0170310883654 \"Кардиология\" подтвержден до 25.02.2024г."
        return label
    }()
    
    // MARK: - inits
    
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
        
        contentView.addSubview(doctorImage)
        contentView.addSubview(specializations)
        
        contentView.addSubview(fullName)
        contentView.addSubview(experienceLabel)
        
        contentView.addSubview(jobPlaceTitle)
        contentView.addSubview(jobPlace)
        
        contentView.addSubview(educationTitle)
        contentView.addSubview(educationDescription)
        
        contentView.addSubview(additionalInfoTitle)
        contentView.addSubview(additionalInfoDescription)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        doctorImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(doctorImage.snp.width).multipliedBy(0.75)

        }
        
        specializations.snp.makeConstraints { make in
            make.top.equalTo(doctorImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        fullName.snp.makeConstraints { make in
            make.top.equalTo(specializations.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        experienceLabel.snp.makeConstraints { make in
            make.top.equalTo(fullName.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        jobPlaceTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(experienceLabel.snp.bottom).offset(16)
        }
        
        jobPlace.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(jobPlaceTitle.snp.bottom).offset(8)
        }
        
        educationTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(jobPlace.snp.bottom).offset(16)
        }
        
        educationDescription.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(educationTitle.snp.bottom).offset(8)
        }
        
        additionalInfoTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(educationDescription.snp.bottom).offset(16)
        }
        
        additionalInfoDescription.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(additionalInfoTitle.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    DoctorProfileView().showPreview()
})
#endif
