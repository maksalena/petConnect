//
//  BookTimeCellTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 09.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class BookTimeCellTableViewCell: UITableViewCell {

    lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.restorationIdentifier = "BookTimeCollectionView"
        collectionView.isScrollEnabled = false
        
        collectionView.register(BookTimeCollectionViewCell.self, forCellWithReuseIdentifier: "BookTimeCollectionViewCell")
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.contentView.addSubview(collectionView)
        
        self.collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}
