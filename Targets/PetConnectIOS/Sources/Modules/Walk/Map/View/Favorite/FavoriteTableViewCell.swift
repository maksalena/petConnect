//
//  FavoriteTableViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 03.10.2023.
//

import UIKit

protocol FavoriteTableViewCellDelegate: AnyObject {
    func buttonPressed()
}

class FavoriteTableViewCell: UITableViewCell {
    
    weak var delegate: FavoriteTableViewCellDelegate?
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        return label
    }()
    
    private lazy var type: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "outline")
        
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(name nameLable: String, type typeLable: String) {
        title.text = nameLable
        type.text = typeLable
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 60)])
        
    }
    
    private func setupViews() {
        addSubview(title)
        addSubview(type)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            title.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            type.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            type.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            type.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            type.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
}



