//
//  AppointmentTimeCollectionViewCell.swift
//  PetConnect
//
//  Created by Егор Завражнов on 18.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class AppointmentTimeCollectionViewCell: UICollectionViewCell {
    
    lazy var time:UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .medium, ofSize: 12)
        label.textColor = .primary
        
        label.text = "16:00"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = UIColor(hexString: "E4EEE9")
        
        self.contentView.addSubview(time)
        self.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        time.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
