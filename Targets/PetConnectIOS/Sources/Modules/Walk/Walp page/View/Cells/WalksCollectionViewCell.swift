//
//  WalksCollectionViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 12.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class WalksCollectionViewCell: UICollectionViewCell {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(PetWalkTableViewCell.self, forCellReuseIdentifier: "PetWalkTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "NavBarBgColor")
        return tableView
    }()
    
    lazy var placeholder:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = UIColor(hexString: "6D7A75")
        label.numberOfLines = 0
        label.textAlignment = .center
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
        self.addSubview(tableView)
        self.addSubview(placeholder)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        placeholder.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}
