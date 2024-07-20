//
//  OneClinicCollectionViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 24.10.2023.
//

import UIKit
import SnapKit

final class OneClinicCollectionViewCell: UICollectionViewCell {
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.text = "PetLife"
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    lazy var location:UILabel = {
        let label = UILabel()
        label.text = "Чистопольская 34/1, Казань"
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var clinicPhone:UILabel = {
        let label = UILabel()
        label.text = "89047813590"
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .gray
        
        label.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(call))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    lazy var isOpenLabel:UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .bold, ofSize: 15)
        label.textColor = .primary
        label.text = "открыто"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    lazy var schedule:UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .regualar, ofSize: 13)
        label.textColor = .black
        label.text = "круглосуточно"
        
        return label
    }()
    
    lazy var separator:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var tags:UILabel = {
        let label = UILabel()
        label.text = {
            var text = ""
            for _ in 1...Int.random(in: 1...7){
                text += "Стационар. Хирургия. "
            }
            
            return text
        }()
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var bookVisit:UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.cornerStyle = .capsule
        conf.baseBackgroundColor = UIColor(resource: .primary30)
        conf.baseForegroundColor = UIColor(resource: .darkGreen)
        conf.attributedTitle = AttributedString(
            NSAttributedString(
                string: "Записаться на прием",
                attributes: [.font : UIFont.SFProDisplay(weight: .regualar, ofSize: 13)!]
            )
        )
        let button = UIButton(configuration: conf, primaryAction: nil)
         
        return button
    }()
    
    
    init(){
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit(){
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(resource: .shadow).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 8
        
        
        self.backgroundColor = .white
        
        self.addSubview(title)
        self.addSubview(clinicPhone)
        
        self.addSubview(location)
        
        self.addSubview(isOpenLabel)
        self.addSubview(schedule)
        
        self.addSubview(separator)
        self.addSubview(tags)
        self.addSubview(bookVisit)
        
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        location.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(4)
        }
        
        clinicPhone.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(location.snp.bottom).offset(4)
        }
        
        isOpenLabel.snp.makeConstraints { make in
            make.top.equalTo(clinicPhone.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        schedule.snp.makeConstraints { make in
            make.centerY.equalTo(isOpenLabel)
            make.leading.equalTo(isOpenLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        separator.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalTo(isOpenLabel.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
        
        tags.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(12)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        bookVisit.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(tags.snp.bottom).offset(12)
            make.leading.bottom.equalToSuperview().inset(16)
            make.width.equalTo(184)
            make.height.equalTo(44)
        }
        
        
    }
    
    func configureCell(
        title:String,
        address:String,
        phone:String,
        isOpen:Bool,
//        schedule:(startTime:String, endTime:String)?,
        schedule:String?,
        tags:String
    ){
        self.title.text = title
        self.location.text = address
        self.clinicPhone.text = phone
        
//        self.isOpenLabel.text = isOpen == true ? "Открыто" : "Закрыто"
//        self.isOpenLabel.textColor = isOpen == true ? UIColor(resource: .primary) : .systemRed
        self.isOpenLabel.text = nil
        self.tags.text = tags
        
        self.schedule.text = nil
        isOpenLabel.textColor = .black
        if let time = schedule{
            self.isOpenLabel.text = time
//            self.schedule.text = time //"\(time.startTime)-\(time.endTime)"
        }else{
            self.isOpenLabel.text = "Круглосуточно"
//            self.schedule.text =
        }
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return layoutAttributes
    }
    
    @objc private func call(){
        String.callNumber(phoneNumber: clinicPhone.text ?? "")
    }
    
}

#if DEBUG
import SwiftUI
#Preview(body: {
    OneClinicCollectionViewCell().showPreview()
})
#endif
