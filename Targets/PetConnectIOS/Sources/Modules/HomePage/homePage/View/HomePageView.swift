//
//  HomePageView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 05.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class HomePageView: UIView {
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var scrollContent:UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var petsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PetsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    private lazy var notificationsStack:UIStackView = {
        let stack = UIStackView()
        
        stack.distribution = .equalCentering
        stack.axis = .horizontal
        
        return stack
    }()
    
    private lazy var notificationLabel: UILabel = {
       let label = UILabel()
        
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 16)
        label.text = "Напоминания"
        
        return label
    }()
    
    lazy var newNotification:UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.baseForegroundColor = UIColor(resource: .green)
        
        conf.imagePlacement = .leading
        conf.imagePadding = 8
        
        conf.image = UIImage(systemName: "plus")
        
        let button = UIButton(configuration: conf)
        button.setTitle("Добавить", for: .normal)
        return button
    }()
    
    lazy var notificationTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(NotificationsTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    lazy var tableViewPlacholder: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 18)
        
        label.text = "Здесь будут отображаться напоминания для ваших питомцев"
        
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
        self.backgroundColor = .white
        
        self.addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        
        
        scrollContent.addSubview(petsCollectionView)
        
        scrollContent.addSubview(notificationsStack)
        notificationsStack.addArrangedSubview(notificationLabel)
        notificationsStack.addArrangedSubview(newNotification)
        
        scrollContent.addSubview(tableViewPlacholder)
        
        scrollContent.addSubview(notificationTableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            
        }
        scrollContent.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.petsCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        notificationsStack.snp.makeConstraints { make in
            make.top.equalTo(petsCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
                
        notificationTableView.snp.makeConstraints { make in
            make.top.equalTo(notificationsStack.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(300)
            make.bottom.equalToSuperview()
        }
        
        tableViewPlacholder.snp.makeConstraints { make in
            make.top.equalTo(notificationTableView).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    public func setTableViewHeight(height:CGFloat){
        notificationTableView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        self.scrollContent.layoutIfNeeded()
    }
    
    public func showPetsCollectionView(){
        UIView.transition(with: petsCollectionView, duration: 0.3) {
            
            self.petsCollectionView.snp.updateConstraints { make in
            make.height.equalTo(150)
        }
        
        
            self.scrollContent.layoutIfNeeded()
        }
    }
    
    public func hidePetsCollectionView(){
        UIView.transition(with: petsCollectionView, duration: 0.3) {
            
            self.petsCollectionView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        
        
            self.scrollContent.layoutIfNeeded()
        }
    }

}

#if DEBUG
import SwiftUI
#Preview(body: {
    HomePageView().showPreview()
})
#endif
