//
//  CheckDataItem.swift
//  PetConnect
//
//  Created by Егор Завражнов on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class CheckDataItem: UIView {
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .SFProDisplay(weight: .regualar, ofSize: 15)
        label.textColor = .gray
        
        return label
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var divider:UIView = {
        let view = UIView()
        view.backgroundColor = .init(hexString: "E7E7E7")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(divider)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

}
