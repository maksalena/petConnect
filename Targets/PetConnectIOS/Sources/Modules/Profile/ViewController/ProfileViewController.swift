//
//  ProfileViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import UIKit

class ProfileViewController: BaseUIViewController {
    
    // MARK: - Variables
    var presenter: ProfilePresenterProtocol?
    
    private func view() -> ProfileView{
        return self.view as! ProfileView
    }
    
    var imagePicker = UIImagePickerController()
                
    private var loadingUIView:LoadingUIView!
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.loadingUIView = LoadingUIView(baseView: self.view)
        
        addTargets()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getPersonalInfo()
        self.hideUserProfileButton()
                
    }
    
    // MARK: - add Handling actions
    
    func addTargets(){
        // change photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        self.view().avatarImageView.addGestureRecognizer(tapGesture)
        
        // scrollView
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(self.refreshPage), for: .valueChanged)
        self.view().scrollView.refreshControl = refreshControll
        
        // delete account
        let delete = UITapGestureRecognizer(target: self, action: #selector(deleteTapped))
        self.view().deleteAccount.addGestureRecognizer(delete)
        
        // logOut
        let logout = UITapGestureRecognizer(target: self, action: #selector(logOutTapped))
        self.view().logOut.addGestureRecognizer(logout)
    }
    
    // MARK: - @IBActions
    @IBAction func changePhotoButtonTap(_ sender: Any) {
        self.selectImage()
    }
    
    @objc func logOutTapped(){
        let alertLogout = UIAlertController(title: "Подтвердите действие", message: "Вы уверены, что действительно хотите выйти из учетной записи PetConnect?", preferredStyle: .alert)
         
        alertLogout.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertLogout.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            
            self.loadingUIView.activate()
            self.presenter?.logOutTapped()
        }))
    
        self.present(alertLogout, animated: true)
    }
    
    @objc func deleteTapped(){
        let alertDelete = UIAlertController(title: "Подтвердите действие", message: "Вы уверены, что действительно хотите удалить аккаунт?", preferredStyle: .alert)
        
        alertDelete.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
                
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            
            let confirmAlert = UIAlertController(title: "Подтвердите действие", message: "Для удаления аккаунта напишите свой email", preferredStyle: .alert)
            
            confirmAlert.addTextField()
            
            confirmAlert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
            
            let confirmAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
                
                self.loadingUIView.activate()
                self.presenter?.deleteTapped()
                
            })
            
            confirmAction.isEnabled = false
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: confirmAlert.textFields?.first, queue: .main) { _ in
                
                confirmAction.isEnabled = (self.presenter?.isValidEmail(email: confirmAlert.textFields?.first?.text ?? "") ?? false)
            }
            
            confirmAlert.addAction(confirmAction)
            
            alertDelete.dismiss(animated: true)
            self.present(confirmAlert, animated: true)
            
        })
        
        
        alertDelete.addAction(deleteAction)
        self.present(alertDelete, animated: true)
    }
    
    @objc func refreshPage(){
        self.presenter?.loadPersonalInfo()
    }
}

extension ProfileViewController: ProfileViewProtocol{
    
    func logOutSuccessfull() {
        loadingUIView.deactivate()
        MainBuilder.setAuthWindow(window: self.view.window)
    }
    
    func logOutError() {
        loadingUIView.deactivate()
        let alert = UIAlertController(title: "Ошибка", message: "Повторите попытку", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func deleted(){
        self.loadingUIView.deactivate()
        MainBuilder.setAuthWindow(window: self.view.window)
    }
    
    func deleteError() {
        let alert = UIAlertController(title: "Ошибка", message: "Повторите попытку", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func setFullname(name: String) {
        self.view().fullNameLabel.text = name
        loadingUIView.deactivate()
    }
    
    func setEmail(email: String) {
        self.view().email.label.text = email
        loadingUIView.deactivate()
    }
    
    func setUsername(username: String) {
        self.view().logIn.label.text = username
        loadingUIView.deactivate()
    }
    
    func setPhone(phone:String){
        self.view().phone.label.text = phone
        loadingUIView.deactivate()
    }
    
    func setLodingView() {
        self.loadingUIView.activate()
    }
    
    func endRefreshing(){
        self.view().scrollView.refreshControl?.endRefreshing()
    }
    
    func setUserPhoto(image: Data?) {
        if let imageData = image{
            self.view().avatarImageView.image = UIImage(data: imageData)
        }else{
            self.view().avatarImageView.image = UIImage(named: "avatar")
        }
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        self.presenter?.uploadPhoto(image: selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

