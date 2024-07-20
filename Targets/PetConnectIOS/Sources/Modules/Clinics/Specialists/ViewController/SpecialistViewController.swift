//
//  SpecialistViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit

class SpecialistViewController: BaseUIViewController {
    
    var presenter:SpecialistPresenterProtocol!
    
    func view() -> SpecialistView {
       return self.view as! SpecialistView
    }
    
    override func loadView() {
       self.view = SpecialistView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().appointmentTypeTableView.delegate = self
        view().appointmentTypeTableView.dataSource = self
    }
}

// MARK: - Table view Datasource & Delegate
extension SpecialistViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.clinic.specializations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as? AppointmentServiceTableViewCell else {
            fatalError("Cell was not found!")
        }
    
        cell.configure(name: self.presenter.clinic.specializations[indexPath.row].value)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // provide filter of the chosen specialist
        let vc = ClinicsAssembly.createChooseDoctorViewController(choosenData: (clinic: self.presenter.clinic, specialistIndex: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
}

extension SpecialistViewController:SpecialistViewProtocol{
    
}
