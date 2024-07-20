//
//  ClinicsListViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 23.10.2023.
//

import UIKit

final class ClinicsListViewController: BaseUIViewController {
    
    var presenter:ClinicsListPresenterProtocol!
    
    func view() -> ClinicsListView {
       return self.view as! ClinicsListView
    }
    
    override func loadView() {
        super.loadView()
        self.view = ClinicsListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
        configureViewController()
        self.presenter.searchClinics(reload: true)
        
    }
    
    func configureViewController(){
//        self.navigationItem.searchController = self.view().searchController
    }
    
    func setTargets(){
        self.view().collectionView.dataSource = self
        self.view().collectionView.delegate = self
        
        let refresh = UIRefreshControl()
        refresh.addAction(UIAction(handler: { _ in
            self.presenter.searchClinics(reload: true)
        }), for: .valueChanged)
        self.view().collectionView.addSubview(refresh)
        self.view().collectionView.refreshControl = refresh
    }
}

// MARK: - UICollectionViewDelegate
extension ClinicsListViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.cellForItem(at: indexPath) is OneClinicCollectionViewCell{
            let destination = ClinicsAssembly.createAppointmentTypeViewController(clinic: self.presenter.clinics[indexPath.row])
            
            self.navigationController?.pushViewController(destination, animated: true)
        }
        
    }
}
// MARK: - UICollectionViewDataSource
extension ClinicsListViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.presenter.isNextPage{
            return self.presenter.clinics.count + 1
        }
        return self.presenter.clinics.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell is LoadClinicsCollectionViewCell{

            self.presenter.searchClinics(reload: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.presenter.isNextPage && indexPath.row == collectionView.numberOfItems(inSection: 0) - 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadClinicsCollectionViewCell", for: indexPath) as! LoadClinicsCollectionViewCell
            
            cell.acitivity.startAnimating()
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clinicCell", for: indexPath) as! OneClinicCollectionViewCell
        
        let clinic = self.presenter.clinics[indexPath.row]
        
        cell.configureCell(
            title: clinic.title,
            address: clinic.address,
            phone: clinic.phone,
            isOpen: true, // TODO сделать нормально
            schedule: clinic.schedule,
            tags: clinic.description
        )
        
        return cell
    }
    
}

extension ClinicsListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.presenter.isNextPage && indexPath.row == collectionView.numberOfItems(inSection: 0) - 1{
            return CGSize(width: self.view().frame.width - 40 , height: 50)
        }
        return CGSize(width: self.view().frame.width - 40 , height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         
        UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
}

extension ClinicsListViewController:ClinicsListViewControllerProtocol{
    func reloadClinicsList() {
        self.view().collectionView.refreshControl?.endRefreshing()
        self.view().collectionView.reloadData()
    }
}
