//
//  SpecializationCollectionViewCell.swift
//  PetConnect
//
//  Created by Егор Завражнов on 20.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

class SpecializationCollectionViewCell: UICollectionViewCell {
    var title: UILabel = {
        let label = UILabel()
        label.textColor = .primary
        label.font = .SFProDisplay(weight: .medium, ofSize: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    func configure(title: String) {
        self.title.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(title)
        
        contentView.backgroundColor = UIColor(hexString: "#E4EEE9")
        contentView.layer.cornerRadius = 10

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
