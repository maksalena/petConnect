//
//  AppointmentListViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit

class AppointmentListViewController: BaseUIViewController {
    
    var presenter: AppointmentListPresenter!
    
    func view() -> AppointmentListView {
       return self.view as! AppointmentListView
    }
    
    override func loadView() {
       self.view = AppointmentListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().appointmentListTableView.delegate = self
        view().appointmentListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadAppointments(reload: true)
    }
   
    
}

// MARK: - Table view Datasource & Delegate
extension AppointmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.presenter.isNextPage{
            return self.presenter.appointments.count + 1
        }
        
        return self.presenter.appointments.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell is LoadDoctorsTableViewCell{
            self.presenter.loadAppointments(reload: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as? AppointmentViewCell else {
            fatalError("Cell was not found!")
        }
        
        if self.presenter.isNextPage && indexPath.row == tableView.numberOfRows(inSection: 0) - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadDoctorsTableViewCell", for: indexPath) as! LoadDoctorsTableViewCell
            
            cell.acitivity.startAnimating()
            
            return cell
        }
        
        
        cell.petNameLabel.text = presenter?.appointments[indexPath.row].petName
        cell.specialist.text = presenter?.appointments[indexPath.row].specialization
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM, HH:mm"
        
        if let date = dateFormatterGet.date(from: ((presenter?.appointments[indexPath.row].day ?? "") + " " + (presenter?.appointments[indexPath.row].time ?? ""))) {
            
            cell.dateLabel.text = dateFormatterPrint.string(from: date)
        }
        
        cell.adressLabel.text = (presenter?.appointments[indexPath.row].clinicName ?? "") + ", " + (presenter?.appointments[indexPath.row].address ?? "")
        
        
        cell.layoutSubviews()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let appoitment: AppointmentModel! = presenter?.appointments[indexPath.row]
        
        let vc = ClinicsAssembly.createDeclineViewController(appointment: appoitment)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension AppointmentListViewController: AppointmentListViewProtocol {
    func reloadTablView() {
        self.view().appointmentListTableView.reloadData()
    }
    
    
}


