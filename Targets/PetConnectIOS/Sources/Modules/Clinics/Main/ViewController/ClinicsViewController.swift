//
//  ClinicsViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.10.2023.
//

import UIKit

class ClinicsViewController: BaseUIViewController {
    
    var presenter: ClinicsPresenter?
    
    func view() -> ClinicsView {
       return self.view as! ClinicsView
    }
    
    override func loadView() {
       self.view = ClinicsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.loadNewAppointment()
        self.presenter?.loadOldAppointment()
    }
    
    func addTargets(){
        //self.presenter?.loadNewAppointment()
        let clinicsGesture = UITapGestureRecognizer(target: self, action: #selector(clinicsTap))
        self.view().clinicButton.addGestureRecognizer(clinicsGesture)
        
        
        let noAppointmentGesture = UITapGestureRecognizer(target: self, action: #selector(clinicsTap))
        self.view().noAppointment.addGestureRecognizer(noAppointmentGesture)
        
        
        let firstNearestAppointmentView = CustomTapGestureRecognizer(target: self, action: #selector(appointmentsTap(index:)))
        firstNearestAppointmentView.index = "00"
        self.view().firstNearestAppointmentView.addGestureRecognizer(firstNearestAppointmentView)
        
        
        let secondNearestAppointmentView = CustomTapGestureRecognizer(target: self, action: #selector(appointmentsTap(index:)))
        secondNearestAppointmentView.index = "01"
        self.view().secondNearestAppointmentView.addGestureRecognizer(secondNearestAppointmentView)
        
        let firstRecentAppointmentView = CustomTapGestureRecognizer(target: self, action: #selector(appointmentsTap(index:)))
        firstRecentAppointmentView.index = "10"
        self.view().firstRecentAppointmentView.addGestureRecognizer(firstRecentAppointmentView)
        
        let secondRecentAppointmentView = CustomTapGestureRecognizer(target: self, action: #selector(appointmentsTap(index:)))
        secondRecentAppointmentView.index = "11"
        self.view().secondRecentAppointmentView.addGestureRecognizer(secondRecentAppointmentView)
        
        view().allButtonForNearestAppointments.addTarget(self, action: #selector(showAllNearestAppointments), for: .touchUpInside)
        view().allButtonForRecentAppointments.addTarget(self, action: #selector(showAllRecentAppointments), for: .touchUpInside)
        
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refreshAppointments), for: .valueChanged)
        view().scrollView.refreshControl = refreshControll
    }
    
    
    // MARK: - Objc func
    @objc func showAllNearestAppointments() {
        
        var appoitments: [AppointmentModel]!
       
        appoitments = presenter?.newAppointments
            
        let vc = ClinicsAssembly.createAppointmentListViewController(isNew: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showAllRecentAppointments() {
        var appoitments: [AppointmentModel]!
       
        appoitments = presenter?.oldAppointments
            
        let vc = ClinicsAssembly.createAppointmentListViewController(isNew: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshAppointments(){
        self.presenter?.loadNewAppointment()
        self.presenter?.loadOldAppointment()
        self.view().scrollView.refreshControl?.endRefreshing()
    }
    
    
    @objc func clinicsTap(){
        let vc = ClinicsAssembly.createClinicsListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func appointmentsTap(index: CustomTapGestureRecognizer) {
        presenter?.index = index.index ?? "00"
        
        var appoitment:AppointmentModel!
        
        
        if let index = presenter?.index {
            switch index.first {
            case "0":
                appoitment = presenter?.newAppointments[Int((index.dropFirst() as NSString).intValue)]
            case "1":
                appoitment = presenter?.oldAppointments[Int((index.dropFirst() as NSString).intValue)]
            default:
                fatalError("Unknown appoitment")
            }
        }
        
        let vc = ClinicsAssembly.createDeclineViewController(appointment: appoitment)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ClinicsViewController: ClinicsViewProtocol {
    
    func fillNewAppointments() {
        
        if let listOfNewAppointments = presenter?.newAppointments {
            
            if listOfNewAppointments.count == 0{
                view().addNoAppointment()
            }
            
            
            if listOfNewAppointments.count > 0 {
                
                view().firstNearestAppointmentView.petNameLabel.text = listOfNewAppointments[0].petName
                view().firstNearestAppointmentView.adressLabel.text = listOfNewAppointments[0].address
                view().firstNearestAppointmentView.specialist.text = listOfNewAppointments[0].specialization
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMMM, HH:mm"

                if let date = dateFormatterGet.date(from: listOfNewAppointments[0].day + " " + listOfNewAppointments[0].time) {
                    view().firstNearestAppointmentView.dateLabel.text = dateFormatterPrint.string(from: date)
                }
                
                view().addFirstNearestAppointment()
            }
            
            if listOfNewAppointments.count > 1 {
                
                view().secondNearestAppointmentView.petNameLabel.text = listOfNewAppointments[1].petName
                view().secondNearestAppointmentView.adressLabel.text = listOfNewAppointments[1].address
                view().secondNearestAppointmentView.specialist.text = listOfNewAppointments[1].specialization
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMMM, HH:mm"

                if let date = dateFormatterGet.date(from: listOfNewAppointments[1].day + " " + listOfNewAppointments[1].time) {
                    view().secondNearestAppointmentView.dateLabel.text = dateFormatterPrint.string(from: date)
                }
                
                view().addSecondNearestAppointment()
            }
            
        }
        
    }
    
    func fillOldAppointments() {
        
        if let listOfNewAppointments = presenter?.oldAppointments {
            
            
            if listOfNewAppointments.count > 0 {
                
                view().firstRecentAppointmentView.petNameLabel.text = listOfNewAppointments[0].petName
                view().firstRecentAppointmentView.adressLabel.text = listOfNewAppointments[0].address
                view().firstRecentAppointmentView.specialist.text = listOfNewAppointments[0].specialization
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
                
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMMM, HH:mm"
                
                if let date = dateFormatterGet.date(from: listOfNewAppointments[0].day + " " + listOfNewAppointments[0].time) {
                    view().firstRecentAppointmentView.dateLabel.text = dateFormatterPrint.string(from: date)
                }
                
                view().addFirstRecentAppointment()
            }
            
            if listOfNewAppointments.count > 1 {
                
                view().secondRecentAppointmentView.petNameLabel.text = listOfNewAppointments[1].petName
                view().secondRecentAppointmentView.adressLabel.text = listOfNewAppointments[1].address
                view().secondRecentAppointmentView.specialist.text = listOfNewAppointments[1].specialization
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMMM, HH:mm"

                if let date = dateFormatterGet.date(from: listOfNewAppointments[1].day + " " + listOfNewAppointments[1].time) {
                    view().secondRecentAppointmentView.dateLabel.text = dateFormatterPrint.string(from: date)
                }
                
                view().addSecondRecentAppointment()
            }
            
        }
    }
}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var index: String?
}
