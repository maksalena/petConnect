//
//  PetDetailSquare.swift
//  PetConnect
//
//  Created by SHREDDING on 19.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

final class PetDetailSquare: UIView {
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .regualar, ofSize: 15)
        label.textColor = .primary
        return label
    }()
    
    lazy var subTitle:UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .regualar, ofSize: 11)
        label.textColor = .systemGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
    }
    private func commonInit(){
        self.backgroundColor = UIColor(hexString: "A9BCA9").withAlphaComponent(0.36)
        self.addSubview(title)
        self.addSubview(subTitle)
    }
}
