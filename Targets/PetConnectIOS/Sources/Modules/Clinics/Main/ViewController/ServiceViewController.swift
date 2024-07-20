//
//  ServiceViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.10.2023.
//

import UIKit

class ServiceViewController: BaseUIViewController {
    
    func view() -> ServiceView {
       return self.view as! ServiceView
    }
    
    override func loadView() {
       self.view = ServiceView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().appointmentTypeTableView.delegate = self
        view().appointmentTypeTableView.dataSource = self
    }
    
}

// MARK: - Table view Datasource & Delegate
extension ServiceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view().title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as? AppointmentServiceTableViewCell else {
            fatalError("Cell was not found!")
        }
    
        cell.configure(name: view().title[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // provide filter of the chosen service
//        let vc = ClinicsAssembly.createChooseDoctorViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
