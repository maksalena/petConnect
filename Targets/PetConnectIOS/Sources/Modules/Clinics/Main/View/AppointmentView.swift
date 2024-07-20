//
//  AppointmentView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 25.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class AppointmentView: UIView {
    
    var petImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .avatar)
        image.contentMode = .scaleAspectFit
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        
        return image
    }()
    
    
    var petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Чубака"
        label.font = .SFProDisplay(weight: .bold, ofSize: 20)
        
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "23 сентября, 13:00"
        label.font = .SFProDisplay(weight: .regualar, ofSize: 15)
        
        return label
    }()
    
    var specialist: UILabel = {
        let label = UILabel()
        label.text = "Терапевт"
        label.font = .SFProDisplay(weight: .regualar, ofSize: 16)
        
        return label
    }()
    
    var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "PetLife, Чистопольская 34"
        label.textColor = UIColor(named: "on-surface")?.withAlphaComponent(0.6)
        label.font = .SFProDisplay(weight: .regualar, ofSize: 13)
        
        return label
    }()
    
    var adressImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clinicAdress")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        self.addSubview(petImage)
        
        self.addSubview(petNameLabel)
        self.addSubview(dateLabel)
        
        self.addSubview(specialist)
        
        self.addSubview(adressImage)
        self.addSubview(adressLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()

        petImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(petImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(petImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        specialist.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(petImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        adressImage.snp.makeConstraints { make in
            make.top.equalTo(specialist.snp.bottom).offset(8)
            make.leading.equalTo(petImage.snp.trailing).offset(8)
        }
        
        adressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(adressImage)
            make.leading.equalTo(adressImage.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(self).inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    AppointmentView().showPreview()
})
#endif
