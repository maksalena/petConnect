//
//  FavoriteViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 03.10.2023.
//

import UIKit

class FavoriteViewController: BaseUIViewController {
    
    var presenter: MapPresenterProtocol?
    var completionHandler: ((Place) -> Void)!
    var favorite: [Place] = []
    
    lazy var favoriteTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        table.backgroundColor = .clear
        
        return table
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тут пока пусто"
        label.textColor = UIColor(named: "outline")
        label.isHidden = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.overrideUserInterfaceStyle = .light
        
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        DispatchQueue.main.async {
            self.presenter?.getFavorite()
        }
        
        setUpViews()
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    private func setUpViews(){
        
        view.addSubview(favoriteTableView)
        view.addSubview(emptyLabel)
        view.bringSubviewToFront(emptyLabel)
        
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            
            favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
        return constraints
    }
}

// MARK: - Table view Datasource & Delegate
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            fatalError("Cell was not found!")
        }
        
        let type = favorite[indexPath.row].category.getTitle() == "WALKS" ? "Места для прогулок" : favorite[indexPath.row].category.getTitle() == "DOG_FRIENDLY" ? "Dog-friendly заведение" : "Опасные места"
        cell.configure(name: favorite[indexPath.row].name, type: type)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            presenter?.deleteFavorite(id: favorite[indexPath.row].id)
            favorite.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            
            if (favorite.count == 0) {
                emptyLabel.isHidden = false
            } else {
                emptyLabel.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300) ){
            self.completionHandler(self.favorite[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension FavoriteViewController: MapViewProtocol {
    func isFavorite(favorite: Bool) {
        
    }
    
    func setUpUser(userName: String, userImage: UIImage, likes: Int, dislikes: Int, myLike: String, id: String) {
        
    }
    
    func setUserId(id: String) {
        
    }
    
    func setFavorite(favorite: [Place]) {
        self.favorite = favorite
        favoriteTableView.reloadData()
        
        if (favorite.count == 0) {
            emptyLabel.isHidden = false
        }
    }
    
    
    func closeWithSuccess(point: Place) {
        
    }
    
    func setUpUser(userName: String, userImage: UIImage, likes: Int, dislikes: Int, myLike: String) {
        
    }
    
    
    func setWeakDescription(_ textField: UITextField) {
        
    }
    
    func setStrongDescription(_ textField: UITextField) {
        
    }
    
    func enableSaveButton() {
        
    }
    
    func disableSaveButton() {
        
    }
}
