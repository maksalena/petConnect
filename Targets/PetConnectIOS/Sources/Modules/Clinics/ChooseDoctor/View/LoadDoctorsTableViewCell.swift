//
//  LoadDoctorsTableViewCell.swift
//  PetConnect
//
//  Created by Егор Завражнов on 29.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class LoadDoctorsTableViewCell: UITableViewCell {
    
    lazy var acitivity:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.contentView.addSubview(acitivity)
        acitivity.startAnimating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        acitivity.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }

}
