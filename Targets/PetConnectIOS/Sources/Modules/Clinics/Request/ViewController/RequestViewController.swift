//
//  RequestViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 28.10.2023.
//

import UIKit

class RequestViewController: BaseUIViewController {
    
    var presenter:RequestPresenterProtocol!
    
    func view() -> RequestView {
       return self.view as! RequestView
    }
    
    override func loadView() {
       self.view = RequestView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view().pet.delegate = self
        view().claim.delegate = self
        view().saveButton.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)
        
        view().claim.keyboardType = .default
        view().claim.textFieldType = .name
        
        view().pet.configure()
        
    }
    
    @objc func saveInfo() {
        let vc = ClinicsAssembly.createCheckDataViewController(
            dateTime: self.presenter.dateTime,
            doctor: self.presenter.doctor,
            clinic: self.presenter.clinic,
            pet: self.presenter.selected.pet!,
            compilance: self.presenter.selected.compliance!
        )
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RequestViewController: CustomTextFieldDelegate {
    
    func customTextFieldDidChange(_ textField: UITextField) {
        self.presenter.setCompliance(text: textField.text ?? "")
        
    }
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
    }
}

extension RequestViewController: DropDownMenuDelegate {
    
    func didSelect(_ tableView: UITableView, indexPath: IndexPath) {
        self.presenter.setPet(index: indexPath.row)
    }
    
    func didDeselect(_ tableView: UITableView, indexPath: IndexPath) {
        self.presenter.deselectPet()
    }
    
}

extension RequestViewController:RequestViewProtocol{
    func reloadPets(){
        self.view().pet.setItems(items: self.presenter.petsNames)
    }
    
    func enableButton(){
        self.view().saveButton.isEnabled = true
    }
    
    func disableButton(){
        self.view().saveButton.isEnabled = false
    }
}
