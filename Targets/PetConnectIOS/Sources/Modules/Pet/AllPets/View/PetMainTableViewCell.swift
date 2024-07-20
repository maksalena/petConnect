//
//  PetCollectionView.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import UIKit
import SnapKit

final class PetCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "PetCellID"
    
    lazy var imagePet: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    let imageGender: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let namePet: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro", size: 16)
        label.textColor = UIColor(named: "textColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let porodaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let petInfoView:UIView = {
        let stackView = UIView()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 30
        self.backgroundColor = .systemGray6
        self.addSubview(imagePet)
        self.addSubview(petInfoView)
        
        
        petInfoView.addSubview(namePet)
        petInfoView.addSubview(imageGender)
        petInfoView.addSubview(porodaLabel)
        petInfoView.addSubview(ageLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imagePet.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.width.equalTo(115)
        }
        
        petInfoView.snp.makeConstraints { make in
            make.centerY.equalTo(imagePet)
            make.leading.equalTo(imagePet.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(101)
        }
        
        namePet.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(2)
        }
        
        imageGender.snp.makeConstraints { make in
            make.centerY.equalTo(namePet)
            make.leading.equalTo(namePet.snp.trailing).offset(5)
            make.height.width.equalTo(16)
        }
        
        porodaLabel.snp.makeConstraints { make in
            make.top.equalTo(namePet.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    public func configure(_ pet:PetHim){
        let components = Date.dateToString(pet.birthday)?.timeIntervalSince()
        self.namePet.text = pet.name
        self.porodaLabel.text = pet.breed
        self.ageLabel.text = "\(components?.year ?? 0), \(components?.month ?? 0) г"
        
        self.imagePet.image = pet.image ?? UIImage(named: "avatar")
        
        if pet.gender == .male{
            self.imageGender.image = UIImage(named: "male")
        }else if pet.gender == .female{
            self.imageGender.image = UIImage(named: "female")
        }else{
            self.imageGender.image = nil
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
