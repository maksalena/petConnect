//
//  AppointmentViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class AppointmentViewCell: UITableViewCell {
    
    lazy var mainView:UIView = {
        return UIView()
    }()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        self.mainView.layer.cornerRadius = 20
        self.mainView.backgroundColor = .white
        
        self.mainView.layer.shadowRadius = 4
        self.mainView.layer.shadowColor = UIColor(red: 0.43, green: 0.48, blue: 0.46, alpha: 1).cgColor
        self.mainView.layer.shadowOpacity = 0.15
        self.mainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.contentView.addSubview(mainView)
        
        self.mainView.addSubview(petImage)
        
        self.mainView.addSubview(petNameLabel)
        self.mainView.addSubview(dateLabel)
        
        self.mainView.addSubview(specialist)
        
        self.mainView.addSubview(adressImage)
        self.mainView.addSubview(adressLabel)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
        mainView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
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
    AppointmentViewCell().showPreview()
})
#endif

