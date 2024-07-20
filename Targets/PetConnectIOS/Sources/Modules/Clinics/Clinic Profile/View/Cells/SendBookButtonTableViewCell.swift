//
//  SendBookButtonTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 09.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class SendBookButtonTableViewCell: UITableViewCell {
    
    lazy var button:UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.cornerStyle = .capsule
        conf.baseBackgroundColor = .primary
        
        let button = UIButton(configuration: conf)
        button.setTitle("Записаться", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
}
