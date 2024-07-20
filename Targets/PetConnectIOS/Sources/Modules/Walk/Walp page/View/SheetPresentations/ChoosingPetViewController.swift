//
//  ChoosingPetViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 07.09.2023.
//

import UIKit
import AlertKit

class ChoosingPetViewController: UIViewController {
    // MARK: - Variables
    var presenter:ChoosingPetPresenterProtocol?
    var doAfterStart:(()->Void)?
    
    private lazy var noPetsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Упс, а где питомцы?"
        label.textColor = UIColor(named: "Gray")
        label.isHidden = true
        return label
    }()
    
    lazy var availablePetsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(AvailablePetsTableViewCell.self, forCellReuseIdentifier: "AvailablePetCell")
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        return table
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(startWalks), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
        
        availablePetsTableView.delegate = self
        availablePetsTableView.dataSource = self
                
        setUpViews()
        NSLayoutConstraint.activate(staticConstraints())
        
    }
        
    private func setUpViews(){
        view.backgroundColor = UIColor(named: "select")

        view.addSubview(noPetsLabel)
        view.addSubview(availablePetsTableView)
        view.addSubview(startButton)
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            noPetsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noPetsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            availablePetsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            availablePetsTableView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: 20),
            availablePetsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            availablePetsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
        ])
        
        return constraints
    }
    
    @objc func startWalks(){
        presenter?.startWalksTapped()
    }
    
    
}

// MARK: - Extensions
extension ChoosingPetViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}


extension ChoosingPetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.nonActivePets.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvailablePetCell", for: indexPath) as? AvailablePetsTableViewCell else {
            fatalError("Cell was not found!")
        }
        
        let pet =  presenter?.nonActivePets[indexPath.row]
    
        cell.configure(name: pet?.name ?? "", image: UIImage(named: "avatar")!)
        
        var image:UIImage?
        if let data = pet?.imageData{
        DispatchQueue.global().async {
            
                image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    UIView.transition(with: cell.petImage, duration: 0.3,options: .transitionCrossDissolve) {
                        cell.petImage.image = image
                    }
                }
            }
        }
        
        return cell
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .checkmark{
            cell.accessoryType = .none
            if let id = presenter?.nonActivePets[indexPath.row].petId{
                presenter?.selectedIds.remove(id)
            }
            
        }else{
            cell.accessoryType = .checkmark
            if let id = presenter?.nonActivePets[indexPath.row].petId{
                presenter?.selectedIds.insert(id)
            }
        }
    }
}

extension ChoosingPetViewController:PetsViewProtocol{

    func updateAllPets() {
        self.availablePetsTableView.reloadData()
    }
    
}

extension ChoosingPetViewController:ChoosingPetViewProtocol{
    func startWalk() {
        AlertKitAPI.present(title: "Прогулка началась", icon: .done, style: .iOS17AppleMusic, haptic: .success)
        doAfterStart?()
        dismiss(animated: true, completion: nil)
    }
    
    
}
