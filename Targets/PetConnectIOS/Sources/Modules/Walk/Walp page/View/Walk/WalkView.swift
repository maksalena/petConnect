//
//  WalkView.swift
//  PetConnect
//
//  Created by SHREDDING on 12.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

final class WalkView: UIView {
    
    public lazy var mapButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        
        let map = MKMapView()
        map.isUserInteractionEnabled = false
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor(named: "darkGreen")
        configuration.baseBackgroundColor = UIColor(named: "select")
        configuration.buttonSize = .medium
        configuration.title = "Смотреть места на карте"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.isUserInteractionEnabled = false
        
        view.addSubview(map)
        view.addSubview(button)
        
        map.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
                
        return view
    }()
    
    public lazy var walkType:HBSegmentedControl = {
        let segment = HBSegmentedControl()
        
        segment.items = ["Действующие", "Завершенные"]
        segment.font = .systemFont(ofSize: 15)
        segment.backgroundColor = .clear
        segment.borderColor = .clear
        segment.selectedLabelColor = UIColor(named: "darkGreen") ?? .white
        segment.unselectedLabelColor = .black
        segment.thumbColor = UIColor(named: "select") ?? .green
        segment.selectedIndex = 0
                
        return segment
    }()
    
    public lazy var walksCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WalksCollectionViewCell.self, forCellWithReuseIdentifier: "WalksCollectionViewCell")
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
                
        return collectionView
    }()
    
    
    public lazy var addPetButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(named: "buttonAdd"), for: .normal)
      button.transform = CGAffineTransformMakeScale(1.3, 1.3)
      return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.addSubview(mapButton)
        self.addSubview(walkType)
        self.addSubview(walksCollectionView)
        
        self.addSubview(addPetButton)
        
        
        mapButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        
        walkType.snp.makeConstraints { make in
            make.top.equalTo(mapButton.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        walksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(walkType.snp.bottom)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        addPetButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(60)
        }
                
    }
    
}
