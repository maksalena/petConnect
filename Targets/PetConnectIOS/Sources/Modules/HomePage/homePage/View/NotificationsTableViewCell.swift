//
//  NotificationsTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 15.09.2023.
//

import UIKit
import SnapKit

class NotificationsTableViewCell: UITableViewCell {
    
    lazy var mainView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        
        view.backgroundColor = .yellow
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 18)
        label.numberOfLines = 0
        
        label.text = "Name"
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 13)
        label.numberOfLines = 0
        
        label.text = "Type"
        return label
    }()
    
    lazy var periodsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        label.numberOfLines = 0
        
        label.text = "period 1\nPeriod 2"
        return label
    }()
    
    lazy var typeImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        
        view.image = UIImage(resource: .dogBowl)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        longTapGesture.minimumPressDuration = 0
        longTapGesture.delegate = self // Установите делегат
        longTapGesture.cancelsTouchesInView = false
        
        self.addGestureRecognizer(longTapGesture)
        
        
        self.contentView.addSubview(mainView)
        
        mainView.addSubview(nameLabel)
        mainView.addSubview(typeLabel)
        mainView.addSubview(periodsLabel)
        mainView.addSubview(typeImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalTo(typeImageView.snp.leading)
            
        }
        
        typeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(typeImageView.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(20)
        }
        
        periodsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(typeImageView.snp.leading)
            make.top.equalTo(typeLabel).offset(6)
            make.leading.bottom.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }
    }
    
    
    
        
    public func configure(name: String, category: Category, prescriptions prescriptionLabel: [String]) {
        self.mainView.backgroundColor = category.getBackgroundColor()
        nameLabel.text = name
        typeLabel.text = category.getTitle()
        typeImageView.image = category.getImage()
        periodsLabel.numberOfLines = prescriptionLabel.count
        periodsLabel.text = prescriptionLabel.joined(separator: "\n")
        
        self.layoutSubviews()
        
    }
    
    @objc func longPressGesture(_ gesture:UILongPressGestureRecognizer){
        if gesture.state == .began{
            self.setOpacity(opacity: 0.7, animated: true)
        }else if gesture.state == .changed{
            if let tableView = self.superview as? UITableView ,let scrollView = tableView.superview?.superview as? UIScrollView {
                if scrollView.isDragging || scrollView.isDecelerating { // Проверяем, что скроллинг не активирован
                    self.setOpacity(opacity: 1, animated: true)
                    gesture.isEnabled = false
                    gesture.isEnabled = true
                }
            }
        }
        else if gesture.state == .ended{
            self.setOpacity(opacity: 1, animated: true)
            
            
            if let tableView = self.superview as? UITableView, let indexPath = tableView.indexPath(for: self), let scrollView = tableView.superview?.superview as? UIScrollView {
                if !scrollView.isDragging && !scrollView.isDecelerating { // Проверяем, что скроллинг не активирован
                    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
                }
            }
        }
        
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    NotificationsTableViewCell().showPreview()
})
#endif
