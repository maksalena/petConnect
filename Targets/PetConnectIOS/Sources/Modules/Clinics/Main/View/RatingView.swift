//
//  RatingView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 30.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class RatingView: UIView {
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Оцените приём врача"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy var star1: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "star"), for: .normal)
        button.setBackgroundImage(UIImage(named: "star"), for: .highlighted)
        
        return button
    }()
    
    lazy var star2: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "star"), for: .normal)
        button.setBackgroundImage(UIImage(named: "star"), for: .highlighted)
        return button
    }()
    
    lazy var star3: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "star"), for: .normal)
        button.setBackgroundImage(UIImage(named: "star"), for: .highlighted)
        return button
    }()
    
    lazy var star4: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "star"), for: .normal)
        button.setBackgroundImage(UIImage(named: "star"), for: .highlighted)
        return button
    }()
    
    lazy var star5: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "star"), for: .normal)
        button.setBackgroundImage(UIImage(named: "star"), for: .highlighted)
        return button
    }()
    
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        button.backgroundColor = UIColor(named: "surface")
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(ratingLabel)
        addSubview(starStackView)
        starStackView.addArrangedSubview(star1)
        starStackView.addArrangedSubview(star2)
        starStackView.addArrangedSubview(star3)
        starStackView.addArrangedSubview(star4)
        starStackView.addArrangedSubview(star5)
        addSubview(acceptButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        starStackView.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(36)
        }
        
        
        acceptButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    RatingView().showPreview()
})
#endif


