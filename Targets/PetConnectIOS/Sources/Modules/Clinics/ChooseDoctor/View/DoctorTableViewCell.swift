//
//  DoctorTableViewCell.swift
//  PetConnect
//
//  Created by Алёна Максимова on 11.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class DoctorTableViewCell: UITableViewCell {
    
    var tableViewWidth:CGFloat = 0
    
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(resource: .shadow).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 8
        
        return view
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        return stack
    }()
    
    lazy var doctorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(resource: .medicalWorker)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var fullName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 16)
        label.text = "Петров Анатолий\nВалерьевич"
        
        return label
    }()
    
    lazy var diclosure:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .gray
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let markView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 4
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var mark: UILabel = {
        let label = UILabel()
        label.text = "5.0 (18 отзывов)"
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        label.textColor = .black
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1800 ₽"
        label.font = .SFProDisplay(weight: .bold, ofSize: 15)
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var specialization: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 13)
        label.textColor = .darkGray
        label.text = "Терапевт, Стаж 10 лет"
        
        return label
    }()
    
    lazy var appointmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Время приёма"
        label.font = .SFProDisplay(weight: .regualar, ofSize: 13)
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var calendar:DynamicHeightCollectionView = {
        let layout = LeftAligmentCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 4
        
        let collection = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AppointmentTimeCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentTimeCollectionViewCell")
        
        collection.restorationIdentifier = "calendar"
        collection.isScrollEnabled = false
        
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(mainView)
        
        self.mainView.addSubview(doctorImage)
        
        self.mainView.addSubview(fullName)
        self.mainView.addSubview(diclosure)
        
        self.mainView.addSubview(verticalStackView)

        self.markView.addArrangedSubview(starImage)
        self.markView.addArrangedSubview(mark)
        self.markView.addArrangedSubview(priceLabel)
        
        self.verticalStackView.addArrangedSubview(markView)
        self.verticalStackView.addArrangedSubview(specialization)
        
        self.mainView.addSubview(appointmentLabel)
        self.mainView.addSubview(calendar)
        
        self.layoutSubviews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(6)
        }
        
        doctorImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.width.height.equalTo(100)
        }
                
        fullName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(doctorImage.snp.trailing).offset(12)
        }
        
        diclosure.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(fullName)
            make.leading.equalTo(fullName.snp.trailing).offset(4)
        }
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(fullName.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(doctorImage.snp.trailing).offset(12)
            make.bottom.equalTo(doctorImage)
        }
        
        appointmentLabel.snp.makeConstraints { make in
            make.top.equalTo(doctorImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview()
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(appointmentLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-16)
            
            if tableViewWidth > 0{
                let collectionViewCellWidth = 60
                let numInRow = Int(tableViewWidth) / collectionViewCellWidth
                
                let numOfCells = calendar.numberOfItems(inSection: 0)
                let cellHeight = 32 + 4
                
                let numRowsFloat:Float = Float(numOfCells) / Float(numInRow)
                let numRows:Int = Int(numRowsFloat.rounded(.up))
                
                make.height.equalTo(cellHeight * numRows)
//                make.height.equalTo(0)
            }else{
                make.height.equalTo(0)
            }
            
        }
        
    }
    
    public func configure(
        firstName:String,
        lastName:String,
        middleName:String,
        specialization:String,
        price:Int,
        experience:Int,

        mark: (markAverage:Float,
        numMarks:Int)?,
        tableViewWidth:CGFloat
    ){
        let lastNum = experience % 10
        let markLastNum = (mark?.numMarks ?? 0) % 10
        self.fullName.text = "\(lastName) \(firstName)\n\(middleName)"
        self.specialization.text = "\(specialization), Стаж \(experience) \(lastNum == 0 ? "лет" : lastNum == 1 ? "год" : lastNum >= 2 && lastNum <= 4 ? "года" : "лет")"
        self.priceLabel.text = "\(price) ₽"
        
        if let markValues = mark{
            self.mark.text = "\(markValues.markAverage) (\(markValues.numMarks) \(markLastNum == 0 ? "отзывов" : markLastNum == 1 ? "отзыв" : markLastNum >= 2 && markLastNum <= 4 ? "отзыва" : "отзывов"))"
        }
        
        
        self.tableViewWidth = tableViewWidth
        
        calendar.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(appointmentLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-16)
            
            if tableViewWidth > 0{
                let collectionViewCellWidth = 60
                let numInRow = Int(tableViewWidth) / collectionViewCellWidth
                
                let numOfCells = calendar.numberOfItems(inSection: 0)
                let cellHeight = 32 + 4
                
                let numRowsFloat:Float = Float(numOfCells) / Float(numInRow)
                let numRows:Int = Int(numRowsFloat.rounded(.up))
                
                make.height.equalTo(cellHeight * numRows)
//                make.height.equalTo(0)
            }else{
                make.height.equalTo(0)
            }
            
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

#if DEBUG
import SwiftUI
#Preview(body: {
    DoctorTableViewCell().showPreview()
})
#endif
