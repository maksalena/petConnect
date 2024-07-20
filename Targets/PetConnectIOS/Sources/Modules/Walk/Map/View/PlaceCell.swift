//
//  PlaceCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 15.09.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class PlaceCell: UICollectionViewCell {
        
    lazy var placeLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Место для прогулок"
        label.textColor =  UIColor(named: "darkGreen")
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "TabBarBgColor")
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        
        return label
    }()
    
    func setup(with title: String) {
        placeLabel.text = title
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupViews() {
        backgroundColor = .none
        
        addSubview(placeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            placeLabel.topAnchor.constraint(equalTo: topAnchor),
            placeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}

extension PlaceCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

