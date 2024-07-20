//
//  PetDetailPhotoViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 28.08.2023.
//

import UIKit

class PetDetailPhotoViewController: BaseUIViewController {
    
    var presenter:PetDetailPhotoPresenterProtocol?
    
    private func view()-> PetDetailView{
        return view as! PetDetailView
    }
    
    override func loadView() {
        super.loadView()
        self.view = PetDetailView()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewDidLoad()
    }
    
    func addTargets(){
        self.view().editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped(){
        let vc = PetAssembly.createAddPetViewController(model: self.presenter?.pet, isEdit: true)
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.viewControllers.remove(at: (self.navigationController?.viewControllers.count)! - 2)
    }
    
}

extension PetDetailPhotoViewController:PetDetailPhotoViewProtocol{
    func setPhoto(image: UIImage?) {
        // MARK: - To Do сделать дефолтное фото
        self.view().petImage.image = self.presenter?.pet.image ?? UIImage(named: "avatar")
    }
    
    func setMainInfo(name: String, breed: String, sex: String, age: Date) {
        let components = age.timeIntervalSince()
        self.view().nameLabel.text = name
        self.view().breedLabel.text = breed
        self.view().genderView.subTitle.text = sex
        self.view().ageView.subTitle.text = "\(components.year ?? 0), \(components.month ?? 0) г"
    }
    
    func setChip(chipNumber:String?, chipDate:String?, chipPlace:String?) {
        self.view().chipNumber.value.text = chipNumber != "" ?  chipNumber : "Отсутствует"
        
        if !(chipNumber ?? "").isEmpty{
            self.view().chipDate.value.text = chipDate != "" ?  chipDate : "Отсутствует"
            self.view().chipPlace.value.text = chipPlace != "" ?  chipPlace : "Отсутствует"
        }else{
            self.view().chipDate.value.text = "Отсутствует"
            self.view().chipPlace.value.text = "Отсутствует"
        }
        
    }
    
    func setSigma(sigmaNumber:String?, sigmaDate:String?) {
        self.view().tattooNumber.value.text = sigmaNumber != "" ?  sigmaNumber : "Отсутствует"
        if !(sigmaNumber ?? "").isEmpty{
            self.view().tattooDate.value.text =  sigmaDate != "" ? sigmaDate : "Отсутствует"
        }else{
            self.view().tattooDate.value.text = "Отсутствует"
        }
    }
    
    
}

