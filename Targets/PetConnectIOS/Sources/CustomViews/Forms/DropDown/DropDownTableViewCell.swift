//
//  DropDownTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 13.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

final class DropDownTableViewCell: UITableViewCell {
    
    lazy var label:UILabel = {
        lazy var label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.contentView.addSubview(label)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = UIColor(resource: .dropDownTableViewBg)
        self.tintColor = .darkGray
                
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            
        }
        
    }
}
