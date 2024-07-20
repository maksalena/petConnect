//
//  BookTimeCollectionViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 09.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class BookTimeCollectionViewCell: UICollectionViewCell {
    
    lazy var mainView:UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(resource: .primary).cgColor
        view.layer.borderWidth = 1
        
        view.layer.cornerRadius = 18
        
        return view
    }()
    
    lazy var timeLabel:UILabel = {
        let label = UILabel()
        
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 13)
        label.textColor = .primary
        label.textAlignment = .center
        label.text = "13:00"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.contentView.addSubview(mainView)
        self.mainView.addSubview(timeLabel)
        
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(2)
        }
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func selectStyle(){
        self.timeLabel.textColor = .white
        self.mainView.backgroundColor = .primary
    }
    
    func unselectStyle(){
        self.timeLabel.textColor = .primary
        self.mainView.backgroundColor = .clear
    }
    
}
