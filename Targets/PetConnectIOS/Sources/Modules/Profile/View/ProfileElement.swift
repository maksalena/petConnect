//
//  ProfileElement.swift
//  PetConnect
//
//  Created by SHREDDING on 15.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class ProfileElement: UIView {
    lazy var HStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 16
        
        return view
    }()
    
    lazy var leftImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        image.tintColor = UIColor(hexString: "6D7A75")
        
        return image
    }()
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        return label
    }()
    
    lazy var separtor:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
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
        self.addSubview(HStackView)
        
        HStackView.addArrangedSubview(leftImage)
        HStackView.addArrangedSubview(label)
        self.addSubview(separtor)
        
        HStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.leading.trailing.equalToSuperview()
        }
        
        leftImage.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        separtor.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(HStackView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
