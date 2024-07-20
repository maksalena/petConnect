//
//  AddPlace.swift
//  PetConnect
//
//  Created by Алёна Максимова on 09.09.2023.
//

import UIKit

class AddPlaceViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: MapPresenterProtocol?
    var saveButtonWasEnabledByDescription = false
    var completionHandler: ((Place) -> Void)!
    
    var category: DropDownMenu!
    let name:CustomTextField = {
        let textField = CustomTextField()
        textField.upperText = "Название*"
        textField.placeholder = "Название*"
        
        textField.backgroundColor = .clear
        return textField
    }()
    
    let descriptionText:CustomTextField = {
        let textField = CustomTextField()
        textField.upperText = "Описание*"
        textField.placeholder = "Описание*"
        textField.supportingText = "Максимум 100 символов"
        
        textField.backgroundColor = .clear
        return textField
    }()
    var selectionType: [String] = ["Место для прогулок", "Dog friendly заведения", "Опасные места"]
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Точка поставится на ваше текущее\nместоположение"
        label.numberOfLines = 2
        label.textColor = UIColor(named: "Gray")
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(savePlace), for: .touchUpInside)
        
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
        
        setUpViews()
        
    }
        
    private func setUpViews(){
        view.backgroundColor = UIColor(named: "select")
        category = DropDownMenu(items: selectionType, placeholder: "Выберите категорию")
        category.isUserInteractionEnabled = true
        category.upperTextBackgroundColor = UIColor(named: "select")!
        
        category.cornerRadius = 30
        category.delegate = self
        
        category.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(category)
        view.addSubview(infoLabel)
        view.addSubview(name)
        view.addSubview(descriptionText)
        view.addSubview(saveButton)
        
        configureTextFields()
        NSLayoutConstraint.activate(staticConstraints())
        
        category.configure()
    }
    
    fileprivate func configureTextFields(){
        name.delegate = self
        descriptionText.delegate = self
        
        name.keyboardType = .default
        name.textFieldType = .name
        
        descriptionText.keyboardType = .default
        
        name.restorationIdentifier =  "nameTextField"
        descriptionText.restorationIdentifier =  "descriptionTextField"
        
        name.upperTextBackgroundColor = UIColor(named: "select")!
        descriptionText.upperTextBackgroundColor = UIColor(named: "select")!
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
                
        constraints.append(contentsOf: [
            category.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            category.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            category.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            category.heightAnchor.constraint(equalToConstant: 58),
            
            infoLabel.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 0),
            infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            name.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            name.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.heightAnchor.constraint(equalToConstant: 80),
            
            descriptionText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: -10),
            descriptionText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionText.heightAnchor.constraint(equalToConstant: 85),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
        ])
        
        return constraints
    }
    
    @objc func savePlace() {
        presenter?.savedTapped()

    }
    
}

// MARK: - Extensions
extension AddPlaceViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}

extension AddPlaceViewController: CustomTextFieldDelegate {
    
    func customTextFieldDidChange(_ textField: UITextField) {
        if textField.restorationIdentifier == "descriptionTextField" {
            presenter?.descriptionDidChange(value: textField.text ?? "", textField)
        }
    }
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier {
        case "nameTextField":
            presenter?.setPlaceData(type: .name, value: textField.text ?? "")
        case "descriptionTextField":
            presenter?.setPlaceData(type: .descriptions, value: textField.text ?? "")
        default:
            break
        }
        
    }
}

extension AddPlaceViewController: DropDownMenuDelegate {
    
    func didSelect(_ tableView: UITableView, indexPath: IndexPath) {
        switch selectionType[indexPath.row] {
        case "Место для прогулок":
            presenter?.setPlaceData(type: .category, value: "WALKS")
        case "Dog friendly заведения":
            presenter?.setPlaceData(type: .category, value: "DOG_FRIENDLY")
        case "Опасные места":
            presenter?.setPlaceData(type: .category, value: "DANGEROUS")
        default:
            presenter?.setPlaceData(type: .category, value: "WALKS")
        }
        
    }
}

extension AddPlaceViewController: MapViewProtocol {
    func isFavorite(favorite: Bool) {
        
    }
    
    func setUpUser(userName: String, userImage: UIImage, likes: Int, dislikes: Int, myLike: String, id: String) {
        
    }
    
    func setUserId(id: String) {
        
    }
    
    func setFavorite(favorite: [Place]) {
        
    }
    
    
    func closeWithSuccess(point: Place) {
        completionHandler(point)
    
        dismiss(animated: true, completion: nil)
    }
    
    func setUpUser(userName: String, userImage: UIImage, likes: Int, dislikes: Int, myLike: String) {
        
    }
    
    
    func setWeakDescription(_ textField: UITextField) {
        (textField.superview?.superview?.superview as! CustomTextField).setWrongValue()
        if (saveButton.isEnabled) {
            saveButtonWasEnabledByDescription = true
            disableSaveButton()
        }
    }
    
    func setStrongDescription(_ textField: UITextField) {
        (textField.superview?.superview as! CustomTextField).setCorrectValue()
        if (!saveButton.isEnabled && saveButtonWasEnabledByDescription) {
            saveButtonWasEnabledByDescription = false
            enableSaveButton()
        }
    }
    
    func enableSaveButton() {
        saveButton.isEnabled = true
        saveButton.backgroundColor = UIColor(named: "primary")
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.setTitleColor( .white, for: .normal)
    }
    
    func disableSaveButton() {
        saveButton.isEnabled = false
        saveButton.backgroundColor = UIColor(named: "on-surface")?.withAlphaComponent(0.16)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.setTitleColor(UIColor(named: "on-surface")?.withAlphaComponent(0.38), for: .normal)
    }
}
