//
//  ClinicInfoTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 26.10.2023.
//

import UIKit
import SnapKit

class ClinicInfoTableViewCell: UITableViewCell {
    enum Style{
        case location
        case phone
        case clock
        
        func getImage()->UIImage{
            switch self {
            case .location:
                return UIImage(systemName: "mappin.and.ellipse")!
            case .phone:
                return UIImage(systemName: "phone.fill")!
            case .clock:
                return UIImage(systemName: "clock")!
            }
        }
        
    }
    
    lazy var mainView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .primary30)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    
    lazy var icon:UIImageView = {
        let view = UIImageView()
        view.image =  Style.clock.getImage()
        view.tintColor = .primary
        
        return view
    }()
    
    lazy var cellTitle:UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 15)
        return label
    }()
    
    lazy var informationTextView:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.showsVerticalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        
        textView.dataDetectorTypes = .phoneNumber
        textView.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 15)
        textView.tintColor = .black
        
        textView.text = "89047813590\n+79047813590"

        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(mainView)
        self.mainView.addSubview(icon)
        self.mainView.addSubview(cellTitle)
        self.mainView.addSubview(informationTextView)
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(6)
        }
        
        icon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.height.width.equalTo(18)
        }
        
        cellTitle.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.centerY.equalTo(icon.snp.centerY)
        }
        
        informationTextView.snp.makeConstraints { make in
            make.top.equalTo(cellTitle.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureCell(style:Style,title:String, textViewTexts:[String]){
        self.cellTitle.text = title
        self.icon.image = style.getImage()
        
        if textViewTexts.count > 0{
            var informationTextViewText = ""
            for textIndex in 0..<textViewTexts.count - 1 {
                informationTextViewText += textViewTexts[textIndex] + "\n"
            }
            informationTextViewText += textViewTexts[textViewTexts.count - 1]
            self.informationTextView.text = informationTextViewText
            
            if informationTextView.superview == nil{
                self.mainView.addSubview(informationTextView)
            }
            
            cellTitle.snp.remakeConstraints { make in
                make.leading.equalTo(icon.snp.trailing).offset(8)
                make.centerY.equalTo(icon.snp.centerY)
            }
            
            informationTextView.snp.remakeConstraints { make in
                make.top.equalTo(cellTitle.snp.bottom).offset(8)
                make.trailing.equalToSuperview()
                make.leading.equalTo(icon.snp.trailing).offset(8)
                make.bottom.equalToSuperview().inset(12)
            }
            
        }else{
            self.informationTextView.removeFromSuperview()
            
            self.cellTitle.snp.remakeConstraints { make in
                make.leading.equalTo(icon.snp.trailing).offset(8)
                make.centerY.equalTo(icon.snp.centerY)
                make.bottom.equalToSuperview().inset(12)
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
