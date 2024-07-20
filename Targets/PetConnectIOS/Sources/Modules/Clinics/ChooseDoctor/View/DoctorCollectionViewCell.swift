//
//  DoctorCollectionViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class DoctorCollectionViewCell: UICollectionViewCell {
    
    var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#E4EEE9")
        button.layer.cornerRadius = 16
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        return button
    }()
    
    func configure(title: String) {
        filterButton.setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(filterButton)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        filterButton.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

