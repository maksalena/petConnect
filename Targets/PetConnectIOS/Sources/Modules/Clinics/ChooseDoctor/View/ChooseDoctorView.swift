//
//  ChooseDoctorView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class ChooseDoctorView: UIView {
    
    lazy var filterDoctorCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
//        collectionViewLayout.itemSize = CGSize(width: 100, height: 36)
        
        let collectionvView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionvView.isPagingEnabled = false
        collectionvView.showsHorizontalScrollIndicator = false
        collectionvView.backgroundColor = .clear
        
        collectionvView.register(DoctorCollectionViewCell.self, forCellWithReuseIdentifier: "DoctorCollectionViewCell")
        
        collectionvView.restorationIdentifier = "filterDoctorCollectionView"
        
        return collectionvView
    }()
    
    lazy var calendarView:CalendarCustomView = {
        let calendar = CalendarCustomView()
        
        return calendar
    }()
    
    lazy var doctorTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.restorationIdentifier = "doctorTableView"
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
        tableView.register(DoctorTableViewCell.self, forCellReuseIdentifier: "DoctorTableViewCell")
        tableView.register(LoadDoctorsTableViewCell.self, forCellReuseIdentifier: "LoadDoctorsTableViewCell")
        
        
        
        return tableView
    }()
    
    lazy var noDoctorsLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы не смогли найти свободных врачей\n в этот день. Выберите, пожалуйста,\n другую дату"
        label.textAlignment = .center
        label.textColor = UIColor(named: "outline")
        label.numberOfLines = 3
        label.isHidden = true
        
        return label
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(filterDoctorCollectionView)
        addSubview(calendarView)
        addSubview(doctorTableView)
        addSubview(noDoctorsLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        filterDoctorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        
        calendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(filterDoctorCollectionView.snp.bottom)
            make.height.equalTo(140)
        }
        
        doctorTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(calendarView.snp.bottom)
            
        }
        
        noDoctorsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calendarView.snp.bottom).offset(30)
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    ChooseDoctorView().showPreview()
})
#endif
