//
//  AppointmentTypeViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit

class AppointmentTypeViewController: BaseUIViewController {
    
    var presenter:AppointmentTypePresenterProtocol!
    
    func view() -> AppointmentTypeView {
       return self.view as! AppointmentTypeView
    }
    
    override func loadView() {
       self.view = AppointmentTypeView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().appointmentTypeTableView.delegate = self
        view().appointmentTypeTableView.dataSource = self
    }
}

// MARK: - Table view Datasource & Delegate
extension AppointmentTypeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view().title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTypeCell", for: indexPath) as? AppointmentTableViewCell else {
            fatalError("Cell was not found!")
        }
    
        cell.configure(name: view().title[indexPath.row], type: view().type[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row{
//        case 0:
//            let vc = ClinicsAssembly.createServiceViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        case 0:
            // provide here a filter for chosen clinic
            let vc = ClinicsAssembly.createChooseDoctorViewController(choosenData: (clinic: self.presenter.clinic, specialistIndex: nil))
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ClinicsAssembly.createSpecialistViewController(clinic: self.presenter.clinic)
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
}

extension AppointmentTypeViewController:AppointmentTypeViewProtocol{
    
}
