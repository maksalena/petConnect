//
//  AppointmentListView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class AppointmentListView: UIView {
    
    lazy var appointmentListTableView: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = UITableView.automaticDimension
        
        table.register(AppointmentViewCell.self, forCellReuseIdentifier: "AppointmentCell")
        table.register(LoadDoctorsTableViewCell.self, forCellReuseIdentifier: "LoadDoctorsTableViewCell")
        
        table.backgroundColor = .white
        table.separatorStyle = .none
        
        return table
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(appointmentListTableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        appointmentListTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

