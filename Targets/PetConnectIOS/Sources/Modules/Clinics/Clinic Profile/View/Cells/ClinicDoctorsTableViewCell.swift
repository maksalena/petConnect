//
//  ClinicDoctorsTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 27.10.2023.
//

import UIKit
import SnapKit

class ClinicDoctorsTableViewCell: UITableViewCell {
    
    lazy var mainView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
//        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor(resource: .shadow).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 8
        return view
    }()
    
    lazy var verticalStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var doctorImage:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        imageView.image = UIImage(resource: .petDetail)
        return imageView
    }()
    
    lazy var firstName:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.text = "Петров"
        return label
    }()
    
    lazy var fullName:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.text = "Анатолий Валерьевич"
        return label
    }()
    
    let markView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 4
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var starImage:UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    lazy var mark:UILabel = {
        let label = UILabel()
        label.text = "5.0 (18 отзывов)"
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    lazy var specialization:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .darkGray
        label.text = "Терапевт, Стаж 10 лет"
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
        self.selectionStyle = .none
        
        self.contentView.addSubview(mainView)
        
        self.mainView.addSubview(doctorImage)
        self.mainView.addSubview(verticalStackView)

        self.markView.addArrangedSubview(starImage)
        self.markView.addArrangedSubview(mark)
        self.verticalStackView.addArrangedSubview(firstName)
        self.verticalStackView.addArrangedSubview(fullName)
        self.verticalStackView.addArrangedSubview(markView)
        self.verticalStackView.addArrangedSubview(specialization)
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(6)
        }
        
        doctorImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.width.height.equalTo(100)
        }
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(doctorImage.snp.trailing).offset(16)
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        UIView.animate(withDuration: animated == true ? 0.3 : 0) {
            self.mainView.layer.opacity = selected == true ? 0.7 : 1
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: animated == true ? 0.3 : 0) {
            self.mainView.layer.opacity = highlighted == true ? 0.7 : 1
        }
    }
    
    
}
