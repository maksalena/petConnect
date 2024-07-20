//
//  PetWalkTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 20.09.2023.
//

import UIKit
import SnapKit

class PetWalkTableViewCell: UITableViewCell {
    
    enum PetWalkType{
        case current
        case finished
    }
        
    lazy var bgView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var petImage:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var upperLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .medium, ofSize: 12)
        return label
    }()
    
    lazy var petNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        return label
    }()
    
    lazy var wcLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.addSubview(bgView)
        self.bgView.addSubview(upperLabel)
        self.bgView.addSubview(petImage)
        self.bgView.addSubview(petNameLabel)
        self.bgView.addSubview(wcLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        upperLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(12)
        }
        
        petImage.snp.makeConstraints { make in
            make.top.equalTo(upperLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(petImage.snp.centerY)
            make.leading.equalTo(petImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(20)
        }
        
        wcLabel.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
    }
        
    public func configure(type:PetWalkType, name: String, image petAvatar: UIImage, date:String? = nil, dc:Bool = false) {
        
        petNameLabel.text = name
        petImage.image = petAvatar
        
        switch type {
        case .current:
            bgView.backgroundColor = UIColor(named: "Blue")
            upperLabel.text = "На прогулке"
            upperLabel.textColor = .white
            petNameLabel.textColor = .white
            wcLabel.text = ""
            wcLabel.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(0)
            }
        case .finished:
            bgView.backgroundColor = UIColor(named: "LightBlue")
            upperLabel.text = date ?? ""
            upperLabel.textColor = .black
            petNameLabel.textColor = .black
            
            wcLabel.text =  "Ваш питомец \(dc == true ? "" : "не ")сходил в туалет" 
            
            wcLabel.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(20)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
