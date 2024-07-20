//
//  ClinicFeedbackTableViewCellTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 01.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit
import UIColorExtensions

class ClinicFeedbackTableViewCell: UITableViewCell {
    
    lazy var mainView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var profilePhoto:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .avatar)
        return view
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.text = "Антон"
        return label
    }()
    
    lazy var starsHStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        
        for _ in 0..<5{
            let star = UIImageView(image: UIImage(systemName: "star.fill"))
            star.tintColor = .systemYellow
            view.addArrangedSubview(star)
            star.snp.makeConstraints { make in
                make.width.height.equalTo(16)
            }
        }
        
        return view
    }()
    
    lazy var dateAgo:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        label.textColor = UIColor(hexString: "6D7A75")
        label.text = "1 month ago"
        return label
    }()
    
    lazy var feedbackLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 9
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = UIColor(hexString: "191C1B")
        label.text = "Хочу выразить огромную благодарность всему персоналу за лечение моего котика. Вежливые, отзывчивые, все хошо объяснили. Рыжик теперь не болеет и готов к новым приключениям :)"
        return label
    }()
    
    lazy var likeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.tintColor = UIColor(hexString: "6D7A75")
        return button
    }()
    
    lazy var numberOfLikes:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .medium, ofSize: 12)
        label.textColor = UIColor(hexString: "6F7975")
        label.text = "12"
        return label
    }()
    
    lazy var numberOfDisLikes:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .medium, ofSize: 12)
        label.textColor = UIColor(hexString: "6F7975")
        label.text = "1"
        return label
    }()
    
    lazy var disLikeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.tintColor = UIColor(hexString: "6D7A75")
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        self.selectionStyle = .none
        
        self.contentView.addSubview(mainView)
        self.mainView.addSubview(profilePhoto)
        self.mainView.addSubview(nameLabel)
        self.mainView.addSubview(starsHStackView)
        self.mainView.addSubview(dateAgo)
        self.mainView.addSubview(feedbackLabel)
        
        self.mainView.addSubview(likeButton)
        self.mainView.addSubview(numberOfLikes)
        
        self.mainView.addSubview(disLikeButton)
        self.mainView.addSubview(numberOfDisLikes)
       
        
        mainView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        profilePhoto.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profilePhoto.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(profilePhoto.snp.centerY)
        }
        starsHStackView.snp.makeConstraints { make in
            make.top.equalTo(profilePhoto.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.width.equalTo(100)
        }
        dateAgo.snp.makeConstraints { make in
            make.leading.equalTo(starsHStackView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(starsHStackView.snp.centerY)
        }
        feedbackLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dateAgo.snp.bottom).offset(12)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.width.equalTo(18)
            make.top.equalTo(feedbackLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
        numberOfLikes.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(4)
            make.centerY.equalTo(likeButton.snp.centerY)
        }
        
        disLikeButton.snp.makeConstraints { make in
            make.leading.equalTo(numberOfLikes.snp.trailing).offset(8)
            make.centerY.equalTo(likeButton.snp.centerY)
            make.height.width.equalTo(18)
        }
        
        numberOfDisLikes.snp.makeConstraints { make in
            make.leading.equalTo(disLikeButton.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(likeButton.snp.centerY)
        }
    }
    
}
