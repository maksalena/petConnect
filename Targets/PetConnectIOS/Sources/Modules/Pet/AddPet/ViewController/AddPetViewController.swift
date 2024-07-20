//
//  AddPetViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.08.2023.
//

import UIKit
import AlertKit

class AddPetViewController: BaseUIViewController {
        
    // MARK: - Variables
    
    var presenter: PetPresenterProtocol?
    var imagePicker = UIImagePickerController()
    var editMode = false
    
    // MARK: - Actions
    
    private func view() -> AddPetView{
        view as! AddPetView
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddPetView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
        
        addTargets()
        addDelegates()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view().typeAnimal.setItems(items: self.presenter?.presentedItems ?? [])
        
        if editMode {
            self.presenter?.fillValues()
            self.view().addDeleteButton()
        }
        
    }
    
    private func addTargets(){
        self.view().addMark.addTarget(self, action: #selector(createMark), for: .touchUpInside)
        self.view().addChip.addTarget(self, action: #selector(createChip), for: .touchUpInside)
        self.view().deleteButton.addTarget(self, action: #selector(deletePet), for: .touchUpInside)
        
        self.view().addPhotoButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        self.view().saveButton.addTarget(self, action: #selector(savePet), for: .touchUpInside)
        
        self.view().avatarImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        self.view().avatarImageView.addGestureRecognizer(tapGesture)
        
        self.view().gender.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        
        self.view().chipView.closeButton.addTarget(self, action: #selector(closeChip), for: .touchUpInside)
        self.view().tattooView.closeButton.addTarget(self, action: #selector(closeTattoo), for: .touchUpInside)
    }
    
    private func addDelegates(){
        self.view().name.delegate = self
        self.view().breed.delegate = self
        self.view().birthday.delegate = self
        self.view().typeAnimal.delegate = self
        
        self.view().chipView.chipNumber.delegate = self
        self.view().chipView.chipDate.delegate = self
        self.view().chipView.chipPlace.delegate = self
        
        self.view().tattooView.tattooNumber.delegate = self
        self.view().tattooView.tattooDate.delegate = self
        
        imagePicker.delegate = self
    }
    
    fileprivate func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification){
        
        if var keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboard = self.view.convert(keyboard, from: nil)
            
            var contentInset:UIEdgeInsets = self.view().scrollView.contentInset
            contentInset.bottom = keyboard.size.height - self.view().buttonsStack.frame.height
            self.view().scrollView.contentInset = contentInset
        }
        
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.view().scrollView.contentInset = contentInset
    }
        
    
    @objc func closeChip(){
        self.view().removeChipView()
    }
    
    @objc func closeTattoo(){
        self.view().removeTattooView()
    }
    
    @objc func cancelTapped(sender: UIGestureRecognizer) {
        
    }
    
    @objc func createChip() {
        self.view().addChipView()
    }
    
    @objc func createMark() {
        self.view().addTattooView()
    }
    
    @objc func savePet() {
        editMode == true ? presenter?.updateTapped() : presenter?.savedTapped()
        
    }
    
    @objc func deletePet() {
        presenter?.deleteTapped()
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if self.view().gender.selectedIndex == 0 {
            presenter?.setPetData(type: .gender, value: "FEMALE")
        } else {
            presenter?.setPetData(type: .gender, value: "MALE")
        }
    }
    
}

extension AddPetViewController: PetViewProtocol{
    func enableSaveButton() {
        self.view().saveButton.isEnabled = true
    }
    
    func disableSaveButton() {
        self.view().saveButton.isEnabled = false
    }
    
    func fillValues(_ pet:PetHim){
        self.view().avatarImageView.image = pet.image ?? UIImage(named: "avatar")
        
        self.view().name.text = pet.name
        self.view().breed.text = pet.breed
        self.view().typeAnimal.setText(text: self.presenter?.presentedItems[self.presenter?.originalItems.firstIndex(of: pet.type) ?? 0] ?? "Собака")
        self.view().birthday.text = pet.birthday
        self.view().gender.selectedIndex = pet.gender == .female ? 0 : 1
        
        if !pet.chip.id.isEmpty || !pet.chip.place.isEmpty{
            self.view().addChipView()
        }
        
        if !pet.mark.id.isEmpty{
            self.view().addTattooView()
        }
        
        self.view().chipView.chipNumber.text = pet.chip.id
        self.view().chipView.chipPlace.text = pet.chip.place
        self.view().chipView.chipDate.text = pet.chip.date
        
        self.view().tattooView.tattooNumber.text = pet.mark.id
        self.view().tattooView.tattooDate.text = pet.mark.date
        
    }
    
    func popView(with message:String){
        AlertKitAPI.present(title: message, icon: .done, style: .iOS17AppleMusic, haptic: .success)
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddPetViewController: CustomTextFieldDelegate {
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier {
        case "nameTextField":
            presenter?.setPetData(type: .name, value: textField.text ?? "")
        case "breedTextField":
            presenter?.setPetData(type: .breed, value: textField.text ?? "")
        case "birthdayTextField":
            presenter?.setPetData(type: .birthday, value: textField.text ?? "")
        case "chipId":
            presenter?.setPetData(type: .chipId, value: textField.text ?? "")
        case "chipDate":
            presenter?.setPetData(type: .chipDate, value: textField.text ?? "")
        case "chipPlace":
            presenter?.setPetData(type: .chipPlace, value: textField.text ?? "")
        case "markId":
            presenter?.setPetData(type: .markId, value: textField.text ?? "")
        case "markDate":
            presenter?.setPetData(type: .markDate, value: textField.text ?? "")
        default:
            break
        }
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
        case "markDate", "birthdayTextField" , "chipDate":
            textField.addDoneCancelToolbar(showCancelButton: false)
        default:
            break
        }
    }
}

extension AddPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func selectImage() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.editedImage] as! UIImage
        self.view().avatarImageView.image = selectedImage
        self.presenter?.setImage(image: selectedImage)
        dismiss(animated: true, completion: nil)
        
        if self.editMode{
            self.enableSaveButton()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddPetViewController:DropDownMenuDelegate{
    func didSelect(_ tableView: UITableView, indexPath: IndexPath) {
        self.presenter?.setPetData(type: .type, value: self.presenter?.originalItems[indexPath.row] ?? "")
    }
    
    func didDeselect(_ tableView: UITableView, indexPath: IndexPath) {
        self.presenter?.setPetData(type: .type, value: "")
    }
}
