//
//  CompleteWalkViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 07.09.2023.
//

import UIKit
import AlertKit

class CompleteWalkViewController: UIViewController {
    // MARK: - Variables
    
    var presenter:CompleteWalkPresenterProtocol?
    var doAfterEnd:(()->Void)?
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Завершая прогулку укажите, сходил ли ваш\nпитомец в туалет"
        label.textColor = UIColor(named: "Gray")
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private lazy var wcLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WC"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Gray")
        return label
    }()
    
    private lazy var petName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(named: "TextBlue")
        
        return label
    }()
    
    private lazy var petImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "avatar")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var petSwitch: UISwitch = {
        let element = UISwitch()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isOn = true
        element.onTintColor = UIColor(named: "primary")
        
        element.addAction(UIAction(handler: { _ in
            self.presenter?.dc = element.isOn
        }), for: .valueChanged)
        
        return element
    }()
    
    private lazy var finishedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Завершить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 16
        
        button.addAction(UIAction(handler: { _ in
            self.presenter?.endWalkTapped()
        }), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Actions
    
    override func viewDidLayoutSubviews() {
        petImage.makeRounded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        self.petName.text = presenter?.activeWalk.name ?? ""
        if let imageData = presenter?.activeWalk.imageData{
            self.petImage.image = UIImage(data: imageData) ?? UIImage(named: "avatar")!
        }
        
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
        
        setUpViews()
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    private func setUpViews(){
        view.backgroundColor = UIColor(named: "select")

        view.addSubview(infoLabel)
        view.addSubview(wcLabel)
        view.addSubview(petName)
        view.addSubview(petImage)
        view.addSubview(petSwitch)
        view.addSubview(finishedButton)
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            
            wcLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            wcLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            
            petImage.topAnchor.constraint(equalTo: wcLabel.bottomAnchor, constant: 10),
            petImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            petImage.heightAnchor.constraint(equalToConstant: 40),
            petImage.widthAnchor.constraint(equalToConstant: 40),
            
            petName.centerYAnchor.constraint(equalTo: petImage.centerYAnchor),
            petName.leadingAnchor.constraint(equalTo: petImage.trailingAnchor, constant: 15),
            
            petSwitch.centerYAnchor.constraint(equalTo: petImage.centerYAnchor),
            petSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            finishedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            finishedButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            finishedButton.heightAnchor.constraint(equalToConstant: 35),
            
        ])
        
        return constraints
    }
}

// MARK: - Extensions
extension CompleteWalkViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}

extension CompleteWalkViewController:CompleteWalkViewProtocol{
    func endWalk() {
        doAfterEnd?()
        dismiss(animated: true, completion: nil)
        AlertKitAPI.present(title: "Прогулка завершена", subtitle: self.petName.text ?? "", icon: .done, style: .iOS17AppleMusic, haptic: .success)
        
    }
}



