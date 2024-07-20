//
//  DynamicHeightCollectionView.swift
//  PetConnect
//
//  Created by Егор Завражнов on 18.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        return collectionViewLayout.collectionViewContentSize
    }

}
