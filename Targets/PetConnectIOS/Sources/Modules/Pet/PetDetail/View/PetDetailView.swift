//
//  PetDetailView.swift
//  PetConnect
//
//  Created by SHREDDING on 19.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class PetDetailView: UIView {
    var ifFirstLoad = true
    
    lazy var petImage:UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - BottomSheetView
    lazy var bottomSheetView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 20
        
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(panGesture)
        return view
    }()
    var bottomSheetOffset:CGFloat = 20
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .semibold, ofSize: 22)
        label.textColor = .black
        
        label.text = "Name"
        return label
    }()
    
    lazy var breedLabel: UILabel = {
        let label = UILabel()
        label.font = .SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .systemGray
        
        label.text = "Порода"
        return label
    }()
    
    lazy var editButton:UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.buttonSize = .large
        conf.image = UIImage(systemName: "pencil")
        conf.baseForegroundColor = UIColor(resource: .text)
        
        let button = UIButton(configuration: conf)
        
        return button
    }()
    
    lazy var genderView:PetDetailSquare = {
        let view = PetDetailSquare()
        view.layer.cornerRadius = 20
        
        view.title.text = "Пол"
        
        view.subTitle.text = "мальчик"
        return view
    }()
    
    lazy var ageView:PetDetailSquare = {
        let view = PetDetailSquare()
        view.layer.cornerRadius = 20
        
        view.title.text = "Возраст"
        view.subTitle.text = "2,5 г"
        return view
    }()
    
    lazy var chipLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        
        label.text = "Чип"
        return label
    }()
    
    private lazy var chipStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var chipNumber:PetDetailInfoRow = {
        let row = PetDetailInfoRow()
        
        row.title.text = "Номер чипа:"
        return row
    }()
    
    lazy var chipDate:PetDetailInfoRow = {
        let row = PetDetailInfoRow()
        
        row.title.text = "Дата имплантации:"
        return row
    }()
    
    lazy var chipPlace:PetDetailInfoRow = {
        let row = PetDetailInfoRow()
        
        row.title.text = "Место имплантации:"
        return row
    }()
    
    
    lazy var tattooLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        
        label.text = "Клеймо"
        return label
    }()
    
    private lazy var tattooStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var tattooNumber:PetDetailInfoRow = {
        let row = PetDetailInfoRow()
        
        row.title.text = "Номер клейма:"
        return row
    }()
    
    lazy var tattooDate:PetDetailInfoRow = {
        let row = PetDetailInfoRow()
        
        row.title.text = "Дата клеймирования:"
        return row
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        petImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.6)
            
        }
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height)
            if ifFirstLoad{
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(self.safeAreaLayoutGuide.layoutFrame.height * (2/6) )
                self.bottomSheetOffset = self.safeAreaLayoutGuide.layoutFrame.height * (2/6)
            }
            
        }
        
        configureBottomSheetView()
        ifFirstLoad = false
    }
    
    func configureBottomSheetView(){
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(32)
        }
        
        breedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(20)
        }
        
        genderView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(breedLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
        }
        ageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.centerY.equalTo(genderView)
            make.leading.equalTo(genderView.snp.trailing).offset(16)
        }
        
        chipLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(ageView.snp.bottom).offset(24)
        }
        
        chipStackView.snp.makeConstraints { make in
            make.top.equalTo(chipLabel.snp.bottom).offset(12).labeled("chipStackView")
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tattooLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(chipStackView.snp.bottom).offset(24)
        }
        
        tattooStackView.snp.makeConstraints { make in
            make.top.equalTo(tattooLabel.snp.bottom).offset(12).labeled("tattooStackView")
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func commonInit(){
        self.backgroundColor = .white
        
        self.addSubview(petImage)
        self.addSubview(bottomSheetView)
        
        bottomSheetView.addSubview(nameLabel)
        bottomSheetView.addSubview(breedLabel)
        bottomSheetView.addSubview(editButton)
        
        bottomSheetView.addSubview(genderView)
        bottomSheetView.addSubview(ageView)
        
        bottomSheetView.addSubview(chipLabel)
        bottomSheetView.addSubview(chipStackView)
        
        chipStackView.addArrangedSubview(chipNumber)
        chipStackView.addArrangedSubview(chipDate)
        chipStackView.addArrangedSubview(chipPlace)
        
        bottomSheetView.addSubview(tattooLabel)
        bottomSheetView.addSubview(tattooStackView)
        
        tattooStackView.addArrangedSubview(tattooNumber)
        tattooStackView.addArrangedSubview(tattooDate)
        
        
    }
    
    @objc func handlePanGesture(_ gesture:UIPanGestureRecognizer){
        if gesture.state == .began {
        }else if gesture.state == .changed {
            let translation = gesture.translation(in: self)
            
            if !((bottomSheetOffset + translation.y <= 0 && translation.y < 0) || bottomSheetOffset + translation.y > self.safeAreaLayoutGuide.layoutFrame.height / 2 && translation.y > 0){
                bottomSheetOffset += translation.y
            }
            
            
            
            if bottomSheetOffset + translation.y <= 0 {
                bottomSheetOffset = 0

            }
            
            if bottomSheetOffset + translation.y > self.safeAreaLayoutGuide.layoutFrame.height / 2 {
                bottomSheetOffset =  self.safeAreaLayoutGuide.layoutFrame.height / 2
            }
            
            bottomSheetView.snp.updateConstraints { make in
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(bottomSheetOffset)
            }
                        
            gesture.setTranslation(CGPoint.zero, in: self)
            
        }else if gesture.state == .ended {
            
//            print("ended")

                        
            if bottomSheetOffset > self.safeAreaLayoutGuide.layoutFrame.height / 6{
                bottomSheetOffset = self.safeAreaLayoutGuide.layoutFrame.height * (2/6)
                
                
            }else{
                bottomSheetOffset = 5
            }
            
            UIView.animate(withDuration: 0.15) {
                self.bottomSheetView.snp.updateConstraints { make in
                    make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(self.bottomSheetOffset)
                    
                }
                
                self.bottomSheetView.superview?.layoutIfNeeded()
            }

        }
        
    }
}

import SwiftUI
#Preview(body: {
    PetDetailView().showPreview()
})
