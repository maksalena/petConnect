//
//  ClinicProfileView.swift
//  PetConnect
//
//  Created by SHREDDING on 24.10.2023.
//

import UIKit
import SnapKit

class ClinicProfileView: UIView {
    
    var selectedCollectionViewPage = 0
    
    var ifFirstLoad = true
    
    // MARK: - Main Image
    lazy var clinicImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CllinicProfileTest")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - BottomSheetView
    lazy var bottomSheetView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    var bottomSheetOffset:CGFloat = 20
        
    // MARK: - MainInfo
    lazy var title:UILabel = {
        let label = UILabel()
        label.text = "PetLife"
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    
    lazy var descriptionClinic:UILabel = {
        let label = UILabel()
        label.text = "Ветеринарная клиника"
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .gray
        return label
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
        
    lazy var avatar:UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .avatar))
        return imageView
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
        conf.baseBackgroundColor = UIColor(resource: .primary)
        conf.baseForegroundColor = .white
        conf.attributedTitle = AttributedString(
            NSAttributedString(
                string: "Записаться на прием",
                attributes: [.font : UIFont.SFProDisplay(weight: .bold, ofSize: 15)!]
            )
        )
        let button = UIButton(configuration: conf, primaryAction: nil)
         
        return button
    }()
    
    // MARK: - Segment Controll
    
    lazy var horisontalStack:UIStackView  = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var infoButton:UIButton = {
        let button = UIButton()
        button.setTitle("Инфо", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var servicesButton:UIButton = {
        let button = UIButton()
        button.setTitle("Услуги", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var doctorsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Врачи", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var feedbackButton:UIButton = {
        let button = UIButton()
                
        button.setTitle("Отзывы", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var pointerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .primary)
        return view
    }()
    
    lazy var segmentCollectionView:UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionvView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionvView.isPagingEnabled = true
        collectionvView.showsHorizontalScrollIndicator = false
        collectionvView.backgroundColor = .clear
        
        collectionvView.register(ProfileClinicCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileClinicCollectionViewCell")
        
        return collectionvView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        self.backgroundColor = .white
        self.addSubview(clinicImage)
        self.addSubview(bottomSheetView)
        
        self.bottomSheetView.addSubview(title)
        self.bottomSheetView.addSubview(descriptionClinic)
        self.bottomSheetView.addSubview(starImage)
        self.bottomSheetView.addSubview(mark)
        self.bottomSheetView.addSubview(avatar)
        self.bottomSheetView.addSubview(separator)
        
        self.bottomSheetView.addSubview(tags)
        self.bottomSheetView.addSubview(bookVisit)
        
        // MARK: - segment controll
        self.bottomSheetView.addSubview(horisontalStack)
        self.horisontalStack.addArrangedSubview(infoButton)
        self.horisontalStack.addArrangedSubview(servicesButton)
        self.horisontalStack.addArrangedSubview(doctorsButton)
        self.horisontalStack.addArrangedSubview(feedbackButton)
        
        self.bottomSheetView.addSubview(pointerView)
        
        // MARK: - Collection View
        self.bottomSheetView.addSubview(segmentCollectionView)
        
    }
    
    override func layoutSubviews() {
        clinicImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(bottomSheetView.snp.top).inset(20)

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
    
    private func configureBottomSheetView(){
        // MARK: - Main info
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(32)
            make.trailing.equalTo(avatar.snp.leading).offset(5)
        }
        
        descriptionClinic.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(title.snp.bottom).offset(4)
            make.trailing.equalTo(avatar.snp.leading).offset(5)
        }
        
        starImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(descriptionClinic.snp.bottom).offset(4)
        }
        
        mark.snp.makeConstraints { make in
            make.leading.equalTo(starImage.snp.trailing).offset(6)
            make.centerY.equalTo(starImage.snp.centerY)
        }
        
        avatar.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(title.snp.top)
            make.height.width.equalTo(40)
        }
        
        separator.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalTo(starImage.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
        
        tags.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(12)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        
        bookVisit.snp.makeConstraints { make in
            make.top.equalTo(tags.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        // MARK: - segmentControll
        horisontalStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(bookVisit.snp.bottom).offset(12)
        }
        
        if ifFirstLoad{
            pointerView.snp.makeConstraints { make in
                make.top.equalTo(horisontalStack.snp.bottom)
                make.width.equalTo(infoButton.snp.width)
                make.height.equalTo(1)
                make.leading.equalTo(infoButton.snp.leading)
            }
        }

        // MARK: - Collection View
        segmentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(horisontalStack.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
        
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
    
    public func selectSegment(index:Int){
        self.selectedCollectionViewPage = index
        pointerView.snp.remakeConstraints{ make in
            make.leading.equalTo(horisontalStack.arrangedSubviews[index].snp.leading)
            
            make.top.equalTo(horisontalStack.snp.bottom)
            make.width.equalTo(infoButton.snp.width)
            make.height.equalTo(1)
        }
        
        UIView.animate(withDuration: 0.15) {
            self.layoutIfNeeded()
        }
    }
}
