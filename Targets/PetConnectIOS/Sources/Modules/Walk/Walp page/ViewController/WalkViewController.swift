//
//  WalkViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 06.09.2023.
//

import UIKit
import MapKit

class WalkViewController: BaseUIViewController {
    
    // MARK: - Variables
    var presenter: WalkPresenterProtocol?
    
    private func view()->WalkView{
        return self.view as! WalkView
    }
        
        
    // MARK: - Life cycles
    
    override func loadView() {
        super.loadView()
        self.view = WalkView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getActiveWalksFromRealm()
        presenter?.getFinishedWalksFromRealm()
        presenter?.loadWalksFromServer()
    }
    
    // MARK: - configuration
    private func setDelegates(){
        self.view().walksCollectionView.dataSource = self
        self.view().walksCollectionView.delegate = self
        
        self.view().walksCollectionView.reloadData()
    }
    
    private func setTargets(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMap))
        self.view().mapButton.addGestureRecognizer(tapGesture)
        
        self.view().addPetButton.addTarget(self, action: #selector(addPet), for: .touchUpInside)
        
        self.view().walkType.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
    }
    
    // MARK: - Actions
             
    @objc func addPet() {
        let sheetViewController = WalkAssemby.createChoosingPetViewController(doAfterStart: {
            self.presenter?.loadWalksFromServer()
        })
        present(sheetViewController, animated: true, completion: nil)
    }
    
    @objc func segmentValueChanged() {
        self.view().walksCollectionView.reloadData()
        
        self.view().walksCollectionView.scrollToItem(at: IndexPath(row: self.view().walkType.selectedIndex, section: 0), at: .top, animated: true)

    }
    
    @objc func openMap() {
        navigationController?.pushViewController(MapAssembly.createMapViewController(), animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension WalkViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalksCollectionViewCell", for: indexPath) as! WalksCollectionViewCell
        
        cell.tableView.delegate = self
        cell.tableView.dataSource = self
        
        switch indexPath.row{
        case 0:
            cell.tableView.restorationIdentifier = "CurrentWalksTableView"
            cell.placeholder.text = "Здесь будут отображаться действующие прогулки ваших питомцев"
        case 1:
            cell.tableView.restorationIdentifier = "FinishedWalksTableView"
            cell.placeholder.text = "Здесь будут отображаться завершенные прогулки ваших питомцев"
        default:
            fatalError("Too much items in collectionView")
        }
        
        let refreshControll = UIRefreshControl(frame: .zero, primaryAction: UIAction(handler: { _ in
            self.presenter?.loadWalksFromServer()
            cell.tableView.refreshControl?.endRefreshing()
        }))
        
        cell.tableView.refreshControl = refreshControll
        
        cell.tableView.reloadData()
        
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WalkViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.view().walksCollectionView {
            let page = Int(self.view().walksCollectionView.contentOffset.x / self.view().walksCollectionView.frame.size.width)
            self.view().walkType.selectedIndex = page
        }
    }
}

// MARK: - UITableViewDataSource
extension WalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView.restorationIdentifier{
        
        case "CurrentWalksTableView":
            let count = presenter?.activeWalks.count ?? 0
            let collectionViewCell = tableView.superview as? WalksCollectionViewCell
            
            if count == 0{
                collectionViewCell?.placeholder.isHidden = false
            }else{
                collectionViewCell?.placeholder.isHidden = true
            }
            
            return count
        case "FinishedWalksTableView":
            let count = presenter?.finishedWalks.count ?? 0
            let collectionViewCell = tableView.superview as? WalksCollectionViewCell
            
            if count == 0{
                collectionViewCell?.placeholder.isHidden = false
            }else{
                collectionViewCell?.placeholder.isHidden = true
            }
            return count
        default:
            fatalError("Unknown Table View")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PetWalkTableViewCell", for: indexPath) as? PetWalkTableViewCell else {
            fatalError("Cell was not found!")
        }
        
        switch tableView.restorationIdentifier{
        
        case "CurrentWalksTableView":
            cell.configure(type: .current, name: presenter?.activeWalks[indexPath.row].name ?? "", image: UIImage(named: "avatar")!)
            
            DispatchQueue.main.async {
                var image:UIImage? = nil
                if let imageData = self.presenter?.activeWalks[indexPath.row].imageData{
                    image = UIImage(data: imageData) ?? UIImage(named: "avatar")
                    UIView.transition(with: cell.petImage, duration: 0.3,options: .transitionCrossDissolve) {
                        cell.petImage.image = image
                    }
                }
            }
            
        case "FinishedWalksTableView":
            cell.configure(type: .finished, name: presenter?.finishedWalks[indexPath.row].name ?? "", image: UIImage(named: "avatar")!,date: presenter?.finishedWalks[indexPath.row].endDate.toString() ?? "", dc: presenter?.finishedWalks[indexPath.row].isWc ?? false)
            
            DispatchQueue.main.async {
                var image:UIImage? = nil
                if let imageData = self.presenter?.finishedWalks[indexPath.row].imageData{
                    image = UIImage(data: imageData) ?? UIImage(named: "avatar")
                    UIView.transition(with: cell.petImage, duration: 0.3,options: .transitionCrossDissolve) {
                        cell.petImage.image = image
                    }
                }
            }
            
        default:
            fatalError("Unknown Table View")
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension WalkViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard tableView.restorationIdentifier == "CurrentWalksTableView" else { return }
        
        if let walk = presenter?.activeWalks[indexPath.row]{
            let sheetViewController = WalkAssemby.createCompleteWalkController(activeWalk: walk, doAfterEnd: {
                self.presenter?.loadWalksFromServer()
            } )
            present(sheetViewController, animated: true, completion: nil)
        }
        
    }
}

// MARK: - WalkViewProtocol
extension WalkViewController: WalkViewProtocol {
    
    func updateWalks(isActive:Bool) {
        self.view().walksCollectionView.reloadData()
    }
}
