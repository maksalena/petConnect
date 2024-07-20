//
//  NoAppointmentView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 11.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class NoAppointmentView: UIView {
    
    var noAppointmentLabel: UILabel = {
        let label = UILabel()
        label.text = "На ближайшее время прёмов не\n запланировано"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    var makeAppointmentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Записаться", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        button.backgroundColor = UIColor(named: "surface")
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(noAppointmentLabel)
        addSubview(makeAppointmentButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        noAppointmentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        makeAppointmentButton.snp.makeConstraints { make in
            make.top.equalTo(noAppointmentLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    NoAppointmentView().showPreview()
})
#endif
