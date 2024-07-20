//
//  HomePageViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 15.09.2023.
//

import UIKit
import RealmSwift
import AlertKit

class HomePageViewController: BaseUIViewController {
    
//    @IBOutlet weak var tableViewHeightConstaint: NSLayoutConstraint!
    
    var presenter: HomePagePresenterProtocol!
    var petsPresenter: PetsPresenterProtocol?
    
    var isViewDidload:Bool = false

    
    private func view() -> HomePageView{
        view as! HomePageView
    }
    
    override func loadView() {
        super.loadView()
        self.view = HomePageView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDelegates()
        addTargets()
        
        
        isViewDidload = false
        self.navigationItem.largeTitleDisplayMode = .never
        
    }
    
    private func addDelegates(){
        self.view().scrollView.delegate = self
        
        self.view().petsCollectionView.delegate = self
        self.view().petsCollectionView.dataSource = self
        
        self.view().notificationTableView.delegate = self
        self.view().notificationTableView.dataSource = self
    }
    
    private func addTargets(){
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(self.refreshPage), for: .valueChanged)
        self.view().scrollView.refreshControl = refreshControll
        
        self.view().newNotification.addTarget(self, action: #selector(addNotificationButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.petsPresenter?.getAllPetsFromRealm()
            
            if let selectedIndex = self.presenter.selectedIndex{
                if self.petsPresenter?.pets.count ?? 0 > selectedIndex.row, let petId = self.petsPresenter?.pets[selectedIndex.row].id{
                    self.presenter.loadTabletsFoddersFromRealm(petId: petId)
                }
            }
            
            if !self.isViewDidload{
                let tabBar = self.tabBarController as! MainTabBarViewController
                tabBar.customDelegate = self
                self.petsPresenter?.getAllPetsFromServer()
                self.isViewDidload = true
            }
        }
    }
    
    
    // MARK: - Buttons Actions
    
    @objc func addNotificationButtonClicked() {
        if presenter.selectedIndex == nil{
            let alert = UIAlertController(title: "Питомец не выбран", message: "Выберите питомца", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ок", style: .default)
            alert.addAction(actionOk)
            
            self.present(alert, animated: true)
        }else{
            if let pet = petsPresenter?.pets[presenter.selectedIndex!.row]{
                let notificationController = HomePageBuilder.createNotificationPage(pet: pet)
                self.navigationController?.pushViewController(notificationController, animated: true)
            }
        }
    }


    
    @objc func refreshPage(){
        DispatchQueue.main.async {
            self.petsPresenter?.getAllPetsFromServer()
            
            if let selectedIndex = self.presenter.selectedIndex{
                if let petId = self.petsPresenter?.pets[selectedIndex.row].id{
                    self.presenter.loadTabletsFoddersFromRealm(petId: petId)
                    self.presenter.loadTabletsFoddersFromServer(petId: petId)
                }
            }
        }
        
        self.view().scrollView.refreshControl?.endRefreshing()
    }
    
}

// MARK: - Navigation
extension HomePageViewController{
    func goToNotification(pet: PetHim,isEdit: Bool, notification: OneTabletsFoddersRealmModel){
        let editVc = HomePageBuilder.createNotificationPage(pet: pet, isEdit: isEdit, notification: notification)
            self.navigationController?.pushViewController(editVc, animated: true)
    }
    
    func goToPetDetail(pet: PetHim){
        let petDetailVC = PetAssembly.createPetDetailPhotoViewController(pet: pet)
        self.navigationController?.pushViewController(petDetailVC, animated: true)
    }
    
    func goToEditPet(model:PetHim){
        let editPet = PetAssembly.createAddPetViewController(model: model, isEdit: true)
        self.navigationController?.pushViewController(editPet, animated: true)
    }
    
}

// MARK: - Pets Collection View Data source & Delegate
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsPresenter?.pets.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PetsCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let pet = petsPresenter?.pets[indexPath.row]

        cell.nameLabel.text = pet?.name ?? ""

        var image:UIImage?

        DispatchQueue.global().async {
            image = pet?.image ??  UIImage(named: "avatar")

            DispatchQueue.main.async {
                UIView.transition(with: cell.photoImageView, duration: 0.3,options: .transitionCrossDissolve) {
                    cell.photoImageView.image = image
                }

            }
        }


        if presenter.selectedIndex == indexPath{
            cell.nameLabel.textColor = .systemGreen
            cell.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }else{
            cell.nameLabel.textColor = .black
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        let cell = collectionView.cellForItem(at: indexPath) as! PetsCollectionViewCell

        if presenter.selectedIndex == indexPath{
            presenter.selectedIndex = nil
            self.view().notificationTableView.reloadData()


            UIView.animate(withDuration: 0.3) {
                cell.nameLabel.textColor = .black
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }else{
            if let preSelected = presenter.selectedIndex{
                let preSelectedCell = collectionView.cellForItem(at: preSelected) as? PetsCollectionViewCell
                UIView.animate(withDuration: 0.3) {
                    preSelectedCell?.nameLabel.textColor = .black
                    preSelectedCell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }

            presenter.selectedIndex = indexPath


            UIView.animate(withDuration: 0.3) {
                cell.nameLabel.textColor = .systemGreen
                cell.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }

            if let selectedIndex = presenter.selectedIndex{
                if let petId = petsPresenter?.pets[selectedIndex.row].id{
                    presenter.loadTabletsFoddersFromRealm(petId: petId)
                    presenter.loadTabletsFoddersFromServer(petId: petId)
                }
            }

        }

    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let conf = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { elements in
            
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"),attributes: .destructive) { _ in
                
                if let selectedIndex = indexPaths.first?.row, let petId = self.petsPresenter?.pets[selectedIndex].id{
                    
                    self.presenter.deletePet(petId: petId)
                }
            }
            
            let edit = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { _ in
                if let selectedIndex = indexPaths.first?.row, let pet = self.petsPresenter?.pets[selectedIndex]{
                    self.goToEditPet(model: pet)
                }
            }
            
            let show = UIAction(title: "Подробнее", image: UIImage(systemName: "pawprint")) { _ in
                if let selectedIndex = indexPaths.first?.row, let pet = self.petsPresenter?.pets[selectedIndex]{
                    self.goToPetDetail(pet: pet)
                }
            }
            
            return UIMenu(options: .displayInline, children: [show, edit, delete])
        }
        
        return indexPaths.count == 1 ?  conf : nil
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 100, height: 124)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }


}

// MARK: - Table view Datasource & Delegate
extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let selectedIndex = presenter.selectedIndex{
            if let petId = petsPresenter?.pets[selectedIndex.row].id{
                if let tabletsFodders = presenter.tabletsFodders[petId]{
                    count = tabletsFodders?.tabletsFodders.count ?? 0
                }
            }
        }
        
        self.view().tableViewPlacholder.isHidden = count == 0 ? false : true
        
        self.view().setTableViewHeight(height: 300)
        print("tableView \(300)")
        
        self.view().scrollView.layoutIfNeeded()
        
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        return configureCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { elements in
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive){_ in 
                
                if let selectedIndex = self.presenter.selectedIndex, let pet = self.petsPresenter?.pets[selectedIndex.row], let petId = pet.id, let notifications = self.presenter.tabletsFodders[petId], let notification = notifications?.tabletsFodders[indexPath.row]{
                    
                    self.presenter.deleteNotification(petId: petId, type: notification.type == .fodder ? .fodder : .tablet, id: notification.id)
                }
                
            }
            
            
            let edit = UIAction (title: "Редактировать" ,image: UIImage(systemName: "pencil")) { _ in
                if let selectedIndex = self.presenter.selectedIndex, let pet = self.petsPresenter?.pets[selectedIndex.row], let petId = pet.id, let notifications = self.presenter.tabletsFodders[petId], let notification = notifications?.tabletsFodders[indexPath.row]{
                    self.goToNotification(pet: pet, isEdit: true, notification: notification)
                }
            }
            
            return UIMenu(options: .displayInline, children: [edit,delete])
        }
        
        return configuration
    }
    
    func configureCell(indexPath:IndexPath) -> UITableViewCell{
        guard let cell = self.view().notificationTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NotificationsTableViewCell else {
            fatalError("Cell was not found!")
        }

        if let selectedIndex = presenter.selectedIndex{
            if let petId = petsPresenter?.pets[selectedIndex.row].id{
                if let tabletsFodders = presenter.tabletsFodders[petId]{
                    var prescriptions:[String] = []

                    var periodIndex = 1
                    for period in tabletsFodders?.tabletsFodders[indexPath.row].periods ?? List<OnePeriodRealmModel>() {
                        
                        let utcDateFormatter = DateFormatter()
                        utcDateFormatter.dateFormat = "HH:mm"
                        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set to UTC time zone

                        // Parse the UTC date string into a Date object
                        let utcDate = utcDateFormatter.date(from: period.time) ?? Date.now
                        
                        // Create a DateFormatter for the current local time zone
                        let localDateFormatter = DateFormatter()
                        localDateFormatter.dateFormat = "HH:mm"
                        localDateFormatter.timeZone = TimeZone.current // Set to the current local time zone
                        
                        // Convert the UTC date to the current local time zone
                        let localDateString = localDateFormatter.string(from: utcDate)
                        
                        prescriptions.append("\(periodIndex) прием в \(localDateString), \(period.count) г")

                        periodIndex += 1
                    }

                    cell.configure(name: tabletsFodders?.tabletsFodders[indexPath.row].name ?? "", category: tabletsFodders?.tabletsFodders[indexPath.row].type == .fodder ? .food : .medicine, prescriptions: prescriptions)
                }
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let selectedIndex = presenter.selectedIndex, let pet = petsPresenter?.pets[selectedIndex.row], let petId = pet.id, let notifications = presenter.tabletsFodders[petId], let notification = notifications?.tabletsFodders[indexPath.row]{
            self.goToNotification(pet: pet, isEdit: true, notification: notification)
        }
    }
    
    func calculateTotalCellHeight(numberOfRows:Int) -> CGFloat {
        var totalHeight: CGFloat = 0.0
        
        for row in 0..<numberOfRows {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = configureCell(indexPath: indexPath)
            
            totalHeight += cell.frame.height
        }
        
        return totalHeight + 50
    }
    
}

extension HomePageViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension HomePageViewController:MainTabBarDelegate{
    func tapSelectedItem() {
        let topOffset = CGPoint(x: 0, y: -self.view().scrollView.contentInset.top)
        self.view().scrollView.setContentOffset(topOffset, animated: true)
    }
}

extension HomePageViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !scrollView.bounds.contains(CGPoint(x: 0, y: self.view().petsCollectionView.frame.maxY)){
            if let selectedIndex = self.presenter.selectedIndex, let name = self.petsPresenter?.pets[selectedIndex.row].name {
                self.setNewTitle(newTitle: name)
            }
        }else{
            self.setNewTitle(newTitle: self.baseTitle)
        }
    }
}

extension HomePageViewController: HomePageViewControllerProtocol {
    
    func successAlert(message: String) {
        AlertKitAPI.present(title: message, icon: .done, style: .iOS17AppleMusic, haptic: .success)
    }
    
    func reloadPetsCollectionView() {
        self.petsPresenter?.getAllPetsFromRealm()
        self.updateAllPets()
    }
    
    func reloadTableView() {
        self.view().notificationTableView.reloadData()
        let heihgt = calculateTotalCellHeight(numberOfRows: self.view().notificationTableView.numberOfRows(inSection: 0))
        
        self.view().setTableViewHeight(height: heihgt <= 300 ? 300 : heihgt)
        print("reloadTableView \(heihgt)")
        self.view().layoutIfNeeded()
        print("reloadTableView \(self.view().notificationTableView.frame.height)")
    }
}

extension HomePageViewController:PetsViewProtocol{

    func updateAllPets(){

        if !(petsPresenter?.pets.isEmpty ?? true) {
            self.view().showPetsCollectionView()
        } else {
            self.view().hidePetsCollectionView()
        }
        
        self.view().petsCollectionView.reloadData()
    }

}
