//
//  PetViewController.swift
//  PetConnect
//
//  Created by Leonid Romanov on 17.08.2023.
//

import UIKit
import AlertKit

class PetViewController: BaseUIViewController {
    var presenter: PetsPresenterProtocol?
    
    private var isViewDidLoaded:Bool = false
      
    private func view() -> AllPetsView{
        return view as! AllPetsView
    }
    override func loadView() {
        super.loadView()
        self.view = AllPetsView()
    }
  override func viewDidLoad() {
    super.viewDidLoad()
      
      addDelegates()
      addTargets()
      
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.presenter?.getAllPetsFromRealm()
        }
        
        if !isViewDidLoaded{
            DispatchQueue.main.async {
                self.presenter?.getAllPetsFromServer()
            }
            self.isViewDidLoaded = true
        }
    }
    
    private func addDelegates(){
        self.view().collectionView.delegate = self
        self.view().collectionView.dataSource = self
        self.view().collectionView.reloadData()
    }
    
    private func addTargets(){
        self.view().addPetButton.addTarget(self, action: #selector(addPet), for: .touchUpInside)
        self.view().refreshControl.addTarget(self, action: #selector(self.refreshPets), for: .valueChanged)
    }
    
    func goToEditPet(model:PetHim){
        let editVc = PetAssembly.createAddPetViewController(model: model, isEdit: true)
        navigationController?.pushViewController(editVc, animated: true)
    }
    
    func goToPetDetail(pet:PetHim){
        navigationController?.pushViewController(PetAssembly.createPetDetailPhotoViewController(pet: pet), animated: true)
    }
  
  @objc func addPet() {
      navigationController?.pushViewController(PetAssembly.createAddPetViewController(), animated: true)
  }
    
    @objc func refreshPets(){
        self.presenter?.getAllPetsFromServer()
        self.view().refreshControl.endRefreshing()
    }
}

extension PetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return presenter?.pets.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - 32, height: 115)
  }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionViewCell.cellID, for: indexPath) as! PetCollectionViewCell
        
        
        if let pet = presenter?.pets[indexPath.row]{
            cell.configure(pet)
        }
                
        return cell
    }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let pet = presenter?.pets[indexPath.row]
      
      navigationController?.pushViewController(PetAssembly.createPetDetailPhotoViewController(pet: pet ?? PetHim() ), animated: true)
  }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let conf = UIContextMenuConfiguration(identifier: nil, actionProvider:  { elements in
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"),attributes: .destructive) { _ in
                
                if let selectedIndex = indexPaths.first?.row, let petId = self.presenter?.pets[selectedIndex].id{
                    
                    self.presenter?.deletePet(petId: petId)
                }
            }
            
            let edit = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { _ in
                if let selectedIndex = indexPaths.first?.row, let pet = self.presenter?.pets[selectedIndex]{
                    self.goToEditPet(model: pet)
                }
            }
            
            let show = UIAction(title: "Подробнее", image: UIImage(systemName: "pawprint")) { _ in
                if let selectedIndex = indexPaths.first?.row, let pet = self.presenter?.pets[selectedIndex]{
                    self.goToPetDetail(pet: pet)
                }
            }
            
            return UIMenu(options: .displayInline, children: [show, edit, delete])
        })
        
        return indexPaths.count == 1 ?  conf : nil
        
    }
    
}

extension PetViewController:PetsViewProtocol{
    func updateAllPets() {
        self.view().collectionView.reloadData()
    }
    
    func successAlert(message:String){
        AlertKitAPI.present(title: message, icon: .done, style: .iOS17AppleMusic, haptic: .success)
    }
    
    func updateImage(indexPath:IndexPath, imageData:Data){
        let cell = self.view().collectionView.cellForItem(at: indexPath) as? PetCollectionViewCell
        cell?.imagePet.image = UIImage(data: imageData)!
        self.view().collectionView.reloadItems(at: [indexPath])
    }
    
}
