//
//  ProfileClinicCollectionViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 25.10.2023.
//

import UIKit
import SnapKit

class ProfileClinicCollectionViewCell: UICollectionViewCell {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(ClinicInfoTableViewCell.self, forCellReuseIdentifier: "ClinicInfoTableViewCell")
        tableView.register(ClinicServicesTableViewCell.self, forCellReuseIdentifier: "ClinicServicesTableViewCell")
        tableView.register(ClinicDoctorsTableViewCell.self, forCellReuseIdentifier: "ClinicDoctorsTableViewCell")
        tableView.register(ClinicSendFeedbackTableViewCell.self, forCellReuseIdentifier: "ClinicSendFeedbackTableViewCell")
        tableView.register(ClinicFeedbackTableViewCell.self, forCellReuseIdentifier: "ClinicFeedbackTableViewCell")
        
        return tableView
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
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
