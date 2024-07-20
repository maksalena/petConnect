//
//  ClinicsView.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.10.2023.
//

import UIKit
import SnapKit

class ClinicsView: UIView {
    
    // MARK: - Clinic
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var scrollContent:UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var noAppointment: NoAppointmentView = {
        let view = NoAppointmentView()
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.makeAppointmentButton.isUserInteractionEnabled = false
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor(red: 0.43, green: 0.48, blue: 0.46, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        return view
    }()
    
    lazy var clinicButton: UIView = {
        let view = MainButtonView()
        view.image = UIImage(named: "clinic")
        view.title = "Выбрать ветклинику"
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Nearest Appointment
    
    lazy var nearestAppointmentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ближайшие записи"
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var allButtonForNearestAppointments: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.setTitleColor(UIColor(named: "outline"), for: .normal)
        
        return button
    }()
    
    lazy var nearestAppointmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        return stackView
    }()
    
    lazy var firstNearestAppointmentView: AppointmentView = {
        let view = AppointmentView()
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor(red: 0.43, green: 0.48, blue: 0.46, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        return view
    }()
    
    lazy var secondNearestAppointmentView: AppointmentView = {
        let view = AppointmentView()
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor(red: 0.43, green: 0.48, blue: 0.46, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        return view
    }()
    
    
    // MARK: - Recent Appointment
    
    lazy var recentAppointmentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Прошедшие записи"
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var allButtonForRecentAppointments: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.setTitleColor(UIColor(named: "outline"), for: .normal)
        
        return button
    }()
    
    lazy var recentAppointmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var firstRecentAppointmentView: AppointmentView = {
        let view = AppointmentView()
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor(red: 0.43, green: 0.48, blue: 0.46, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        return view
    }()
    
    lazy var secondRecentAppointmentView: AppointmentView = {
        let view = AppointmentView()
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor(red: 0.43, green: 0.48, blue: 0.46, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        return view
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        
        scrollContent.addSubview(clinicButton)
        
        scrollContent.addSubview(nearestAppointmentsLabel)
        scrollContent.addSubview(allButtonForNearestAppointments)
        
        scrollContent.addSubview(recentAppointmentsLabel)
        scrollContent.addSubview(allButtonForRecentAppointments)
        
        scrollContent.addSubview(nearestAppointmentStackView)
        scrollContent.addSubview(recentAppointmentStackView)
        
        
        nearestAppointmentStackView.addArrangedSubview(noAppointment)
        
//        nearestAppointmentStackView.addArrangedSubview(firstNearestAppointmentView)
//        nearestAppointmentStackView.addArrangedSubview(secondNearestAppointmentView)
//        
//        
//        recentAppointmentStackView.addArrangedSubview(firstRecentAppointmentView)
//        recentAppointmentStackView.addArrangedSubview(secondRecentAppointmentView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
        
        // MARK: - Clinic constraints
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        scrollContent.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
        
        clinicButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(88)
        }
        
        
        // MARK: - Nearest Appointment
        
        nearestAppointmentsLabel.snp.makeConstraints { make in
            make.top.equalTo(clinicButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
        }
        
        allButtonForNearestAppointments.snp.makeConstraints { make in
            make.centerY.equalTo(nearestAppointmentsLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(nearestAppointmentsLabel.snp.trailing)
        }

        nearestAppointmentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(nearestAppointmentsLabel.snp.bottom).offset(12)
        }
        
        recentAppointmentsLabel.snp.makeConstraints { make in
            make.top.equalTo(nearestAppointmentStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        allButtonForRecentAppointments.snp.makeConstraints { make in
            make.centerY.equalTo(recentAppointmentsLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(recentAppointmentsLabel.snp.trailing)
        }
        
        recentAppointmentStackView.snp.makeConstraints { make in
            make.top.equalTo(recentAppointmentsLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
        // MARK: - Recent Appointment
    
    }
    
    
    
    func removeAllFromNearest(){
        for subview in self.nearestAppointmentStackView.subviews{
            subview.removeFromSuperview()
        }
    }
    
    func removeAllFromRecent(){
        for subview in self.recentAppointmentStackView.subviews{
            subview.removeFromSuperview()
        }
    }
    
    
    func addNoAppointment(){
        removeAllFromNearest()
        self.nearestAppointmentStackView.addArrangedSubview(self.noAppointment)
        UIView.transition(with: nearestAppointmentStackView, duration: 0.3, options: .transitionCrossDissolve) {
            self.layoutSubviews()
        }
        
    }
    
    func addFirstNearestAppointment(){
        removeAllFromNearest()
        self.nearestAppointmentStackView.addArrangedSubview(self.firstNearestAppointmentView)
        UIView.transition(with: nearestAppointmentStackView, duration: 0.3, options: .transitionCrossDissolve) {
            self.layoutSubviews()
        }
    }
    
    func addSecondNearestAppointment(){
        self.nearestAppointmentStackView.addArrangedSubview(self.secondNearestAppointmentView)
        UIView.transition(with: nearestAppointmentStackView, duration: 0.3, options: .transitionCrossDissolve) {
            self.layoutSubviews()
        }
    }
    
    func addFirstRecentAppointment(){
        removeAllFromRecent()
        self.recentAppointmentStackView.addArrangedSubview(self.firstRecentAppointmentView)
        UIView.transition(with: recentAppointmentStackView, duration: 0.3, options: .transitionCrossDissolve) {
            self.layoutSubviews()
        }
    }
    
    func addSecondRecentAppointment(){
        self.recentAppointmentStackView.addArrangedSubview(self.secondRecentAppointmentView)
        UIView.transition(with: recentAppointmentStackView, duration: 0.3, options: .transitionCrossDissolve) {
            self.layoutSubviews()
        }
    }
}

#if DEBUG
import SwiftUI
#Preview(body: {
    ClinicsView().showPreview()
})
#endif
