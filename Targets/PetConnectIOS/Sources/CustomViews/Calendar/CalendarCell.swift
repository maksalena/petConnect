//
//  CalendarCell.swift
//  PetConnect
//
//  Created by SHREDDING on 06.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation
import JTAppleCalendar
import UIKit
import SnapKit
import UIColorExtensions

class CalendarCell:JTACDayCell{
    
    enum CellColor{
        static let unselectedBackgound = UIColor(hexString: "E4EEE9")
        static let selectedBackgound = UIColor(hexString: "006B59")
        
        static let unselectedSubtitle = UIColor(hexString: "6D7A75")
    }
    
    private lazy var dayNumber:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.textColor = .black
        label.text = "1"
        return label
    }()
    private lazy var mainView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = CellColor.unselectedBackgound
        return view
    }()
    
    private lazy var dayNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 12)
        label.textColor = CellColor.unselectedSubtitle
        label.text = "Bc"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(mainView)
        self.mainView.addSubview(dayNumber)
        self.mainView.addSubview(dayNameLabel)
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        dayNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        
        dayNameLabel.snp.makeConstraints { make in
            make.top.equalTo(dayNumber.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
    
    public func configureCell(cellState: CellState){
        
        dayNumber.text = "\(Calendar.current.component(.day, from: cellState.date))"
        dayNameLabel.text = cellState.date.getDayName()
        
        if Calendar.current.isDateInToday(cellState.date){
            self.mainView.layer.borderWidth = 2
            self.mainView.layer.borderColor = CellColor.selectedBackgound.cgColor
        }else{
            self.mainView.layer.borderWidth = 0
            self.mainView.layer.borderColor = UIColor.clear.cgColor
        }
        
        if cellState.isSelected{
            self.select(animated: false)
        }else{
            self.deselect(animated: false)
        }
        
    }
    
    public func select(animated:Bool){
        UIView.animate(withDuration: animated == true ? 0.3 : 0) {
            self.mainView.backgroundColor = CellColor.selectedBackgound
            self.dayNumber.textColor = .white
            self.dayNameLabel.textColor = .white
        }
        
    }
    
    public func deselect(animated:Bool){
        UIView.animate(withDuration: animated == true ? 0.3 : 0) {
            self.mainView.backgroundColor = CellColor.unselectedBackgound
            self.dayNumber.textColor = .black
            self.dayNameLabel.textColor = CellColor.unselectedSubtitle
        }
    }
    
}
