//
//  ClinicServicesTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 26.10.2023.
//

import UIKit
import SnapKit

class ClinicServicesTableViewCell: UITableViewCell {
    
    lazy var mainView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .primary30)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.text = "Услуги Специалистов"
        return label
    }()
    
    lazy var countImage:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "2.circle.fill")
        view.tintColor = .lightGray
        return view
    }()
    
    lazy var servicesStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalCentering
        view.spacing = 12
        return view
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
        self.mainView.addSubview(title)
        self.mainView.addSubview(countImage)
        self.mainView.addSubview(servicesStackView)
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(6)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        countImage.snp.makeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.leading.equalTo(title.snp.trailing).offset(8)
            make.width.height.equalTo(20)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        
        servicesStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(title.snp.bottom).offset(24)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func createHorisontalStackView(title:String, price:String)->UIStackView{
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        let titleLabel = UILabel()
        let priceLabel = UILabel()
        
        titleLabel.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        titleLabel.numberOfLines = 0
        priceLabel.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        priceLabel.textAlignment = .right
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        titleLabel.text = title
        priceLabel.text = price + " ₽"
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        
        return stackView
        
    }
    
    func configureCell(title:String, services:[ClinicServiceModel]){
        self.title.text = title
        self.countImage.image = UIImage(systemName: "\(services.count).circle.fill")
        configureVerticalStackView(services: services)
    }
    
    func configureVerticalStackView(services:[ClinicServiceModel]){
        for subView in servicesStackView.arrangedSubviews{
            subView.removeFromSuperview()
            self.servicesStackView.removeArrangedSubview(subView)
        }
        
        for service in services {
            let newSubView = createHorisontalStackView(title: service.title, price: service.price)
            self.servicesStackView.addArrangedSubview(newSubView)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
