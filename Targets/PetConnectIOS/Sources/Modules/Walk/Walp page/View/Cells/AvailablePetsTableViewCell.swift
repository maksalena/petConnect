//
//  AvailablePetsTableViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 07.09.2023.
//

import UIKit

protocol AvailablePetsTableViewCellDelegate: AnyObject {
    func buttonPressed()
}

class AvailablePetsTableViewCell: UITableViewCell {
    
    weak var delegate: AvailablePetsTableViewCellDelegate?
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var petName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(named: "TextBlue")
        
        return label
    }()
    
    public lazy var petImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        
        return image
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
    
    public func configure(name nameLable: String, image petAvatar: UIImage) {
        petName.text = nameLable
        petImage.image = petAvatar
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 60)])
        
    }
    
    private func setupViews() {
        addSubview(bgView)
        bgView.addSubview(petName)
        bgView.addSubview(petImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
            bgView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            petImage.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            petImage.heightAnchor.constraint(equalToConstant: 40),
            petImage.widthAnchor.constraint(equalToConstant: 40),
            petImage.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            
            petName.centerYAnchor.constraint(equalTo: petImage.centerYAnchor),
            petName.leadingAnchor.constraint(equalTo: petImage.trailingAnchor, constant: 15),
            
        ])
    }
}


