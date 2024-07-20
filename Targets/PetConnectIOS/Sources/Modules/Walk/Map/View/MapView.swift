//
//  MapView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 26.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapView: UIView {
    
    lazy var map: MKMapView = {
        let map = MKMapView()
        
        if #available(iOS 16.0, *) {
            let conf = MKHybridMapConfiguration(elevationStyle: .realistic)
            conf.showsTraffic = false
            
            map.preferredConfiguration = conf
        }
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        map.mapType = .standard
        map.showsCompass = false
        return map
    }()
    
    lazy var addPlaceButton: UIButton = {
        let button = UIButton()
        button.setTitle("＋  Добавить место", for: .normal)
        button.setTitleColor(UIColor(named: "darkGreen"), for: .normal)
        button.backgroundColor = UIColor(named: "select")
        button.layer.cornerRadius = 18
        
        return button
    }()
    
    lazy var buttonsCV: UICollectionView = {
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.minimumInteritemSpacing = 16
        categoryLayout.scrollDirection = .horizontal
        
        let element = UICollectionView(frame: CGRectZero, collectionViewLayout: categoryLayout)
        
        element.backgroundColor = .none
        element.showsHorizontalScrollIndicator = false
        
        element.register(PlaceCell.self, forCellWithReuseIdentifier: PlaceCell.identifier)
        
        return element
    }()
    
    lazy var locationButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = .gray
        button.layer.cornerRadius = 22
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
        self.backgroundColor = .white
        
        self.addSubview(map)
        self.addSubview(addPlaceButton)
        self.addSubview(buttonsCV)
        self.addSubview(locationButton)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        map.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        addPlaceButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.53)
            make.bottom.equalToSuperview().inset(110)
            make.centerX.equalToSuperview()
        }
        
        buttonsCV.snp.makeConstraints { make in
            make.top.equalTo(addPlaceButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        locationButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(addPlaceButton.snp.top).offset(-36)
        }
    }
    
}

#if DEBUG
import SwiftUI
#Preview(body: {
    MapView().showPreview()
})
#endif
