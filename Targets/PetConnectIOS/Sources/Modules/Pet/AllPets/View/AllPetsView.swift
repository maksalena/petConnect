//
//  AllPetsView.swift
//  PetConnect
//
//  Created by SHREDDING on 19.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class AllPetsView: UIView {
    public lazy var addPetButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(named: "buttonAdd"), for: .normal)
      button.transform = CGAffineTransformMakeScale(1.3, 1.3)
      return button
    }()
    
    public lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        collection.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.cellID)
        collection.alwaysBounceVertical = true
        
        return collection
    }()
    
    public lazy var refreshControl:UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = .systemBackground
        
        self.addSubview(collectionView)
        self.addSubview(addPetButton)
        
        collectionView.addSubview(refreshControl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        addPetButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.right.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
}
