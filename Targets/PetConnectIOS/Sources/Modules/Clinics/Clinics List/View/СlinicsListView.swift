//
//  СlinicsListView.swift
//  PetConnect
//
//  Created by SHREDDING on 23.10.2023.
//

import UIKit
import SnapKit

final class ClinicsListView: UIView {
    
    lazy var searchController:UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        return searchController
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        
        collectionView.register(OneClinicCollectionViewCell.self, forCellWithReuseIdentifier: "clinicCell")
        
        collectionView.register(LoadClinicsCollectionViewCell.self, forCellWithReuseIdentifier: "LoadClinicsCollectionViewCell")
        return collectionView
    }()
    
    init(){
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = .white
        self.addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
    }
    
}

//import SwiftUI
//#Preview(body: {
//    ClinicsListView().showPreview()
//})
