//
//  CalendarCustomView.swift
//  PetConnect
//
//  Created by SHREDDING on 06.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SnapKit
import UIColorExtensions

protocol CalendarCustomViewDelegate{
    func didSelect(date:Date)
}
class CalendarCustomView: UIView {
    
    var delegate:CalendarCustomViewDelegate?
    
    var selectedDate:Date = Date.now{
        didSet{
            UIView.transition(with: self.selectedDayLabel, duration: 0.3, options: .transitionCrossDissolve) {
                self.selectedDayLabel.text = self.formatDateToString(self.selectedDate)
            }
        }
    }
    
    lazy var selectedDayStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var calendarImage:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "calendar")
        view.tintColor = UIColor(hexString: "6D7A75")
        return view
    }()
    
    lazy var selectedDayLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.text = "9 сентября, воскресенье"
        return label
    }()
    
    lazy var calendar:JTACMonthView = {
        let calendar = JTACMonthView()
        calendar.calendarDataSource = self
        calendar.calendarDelegate = self
        
        calendar.scrollDirection = .horizontal
        calendar.showsHorizontalScrollIndicator = false
        calendar.scrollingMode = .stopAtEachCalendarFrame
       
        calendar.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        
        return calendar
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
        
        self.addSubview(selectedDayStackView)
        self.addSubview(calendar)
        
        selectedDayStackView.addArrangedSubview(calendarImage)
        selectedDayStackView.addArrangedSubview(selectedDayLabel)
        
        selectedDayStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(16)
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(selectedDayStackView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(16)
        }
        

        
        calendarImage.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        
        self.calendar.scrollToDate(Date.now, animateScroll: false)
        self.calendar.selectDates([Date.now])
        
        self.selectedDate = Date.now
    }
    
    private func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU") // Установка русской локали для названия месяцев и дней недели

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    
}

extension CalendarCustomView:JTACMonthViewDataSource{
    func configureCalendar(_ calendar: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let startDate = Date.now /*Calendar.current.date(byAdding: .year, value: -1, to: )!*/
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: Date.now)!
        
        return JTAppleCalendar.ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: 1,
            calendar: Calendar.current
        )
        
    }
        
}

extension CalendarCustomView:JTACMonthViewDelegate{
    
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, willDisplay cell: JTAppleCalendar.JTACDayCell, forItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, cellForItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) -> JTAppleCalendar.JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.configureCell(cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        if cellState.isSelected {
            calendar.deselectAllDates()
            calendar.selectDates([Date.now])
            self.calendar.scrollToDate(Date.now,animateScroll: true)
            self.selectedDate = Date.now
            return false
        }
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if let cell = cell as? CalendarCell{
            cell.select(animated: true)
            self.selectedDate = date
            
            delegate?.didSelect(date: date)
        }
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if let cell = cell as? CalendarCell{
            cell.deselect(animated: true)
        }
    }
    
    
}

// MARK: - Data Source

import SwiftUI
#Preview(body: {
    CalendarCustomView().showPreview()
})
