//
//  DoctorProfileViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 06.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import SnapKit

class DoctorProfileViewController: BaseUIViewController {
    
    var presenter:DoctorProfilePresenterProtocol!
    
    private func view() -> DoctorProfileView{
        return view as! DoctorProfileView
    }
    
    override func loadView() {
        self.view  = DoctorProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        addTargets()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fillValues()
    }
    
    func addDelegates(){
        self.view().specializations.delegate = self
        self.view().specializations.dataSource = self
    }
    
    func addTargets(){
        let refresh = UIRefreshControl()
        refresh.addAction(UIAction(handler: { _ in
            self.presenter.loadDoctor()
        }), for: .valueChanged)
        
        self.view().scrollView.refreshControl = refresh
    }
}


// MARK: - UICollectionViewDataSource
extension DoctorProfileViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.presenter.doctor.specializations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecializationCollectionViewCell", for: indexPath) as! SpecializationCollectionViewCell
        
        cell.configure(title: self.presenter.doctor.specializations[indexPath.row].value)
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension DoctorProfileViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: self.presenter.doctor.specializations[indexPath.row].value.count * 7 + 48, height: 32)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

extension DoctorProfileViewController: DoctorProfileViewProtocol{
    func fillValues(){
        self.view().scrollView.refreshControl?.endRefreshing()
        
        self.view().fullName.text = "\(self.presenter.doctor.lastName) \(self.presenter.doctor.firstName)\n\(self.presenter.doctor.middleName)"
        
        let lastNum = self.presenter.doctor.experience % 10
        self.view().experienceLabel.text = "Стаж \(self.presenter.doctor.experience) \(lastNum == 0 ? "лет" : lastNum == 1 ? "год" : lastNum >= 2 && lastNum <= 4 ? "года" : "лет")"
        
        self.view().jobPlace.text = ""
        for clinic in self.presenter.doctor.clinics{
            self.view().jobPlace.text! += "Ветклиника '\(clinic.title)'. \(clinic.Address)\n"

        }
        self.view().jobPlace.text!.removeLast()
        
        self.view().educationDescription.text = self.presenter.doctor.education
        self.view().additionalInfoDescription.text = self.presenter.doctor.info
        
    }
}
