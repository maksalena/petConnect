//
//  PlaceDescriptionViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 09.09.2023.
//

import UIKit

class PlaceDescriptionViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: MapPresenterProtocol?
    var completionHandler: ((Place) -> Void)!
    var completionDeselector: (() -> Void)!
    var placeId: UUID!
    var currentUserId: String!
    var userId: String!
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Gray")
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = UIColor(named: "Gray")
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private lazy var dislikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = UIColor(named: "Gray")
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "avatar")
        
        return image
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "more"), for: .normal)
        
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var dislikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "dislike"), for: .normal)
        button.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Actions
    
    override func viewDidLayoutSubviews() {
        userImage.makeRounded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        completionDeselector()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        view.backgroundColor = .white
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
        
        setUpViews()
        DispatchQueue.main.async {
            self.presenter?.getPersonalInfo()
            self.presenter?.getPlaceDescription(id: self.placeId)
        }
        
    }
        
    private func setUpViews(){
        
        if let place = presenter?.getPlaceInfo() {
            nameLabel.text = place.name
            typeLabel.text = place.category.getTitle()
            descriptionLabel.text = place.description
        }

        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(moreButton)
        view.addSubview(likeButton)
        view.addSubview(dislikeButton)
        view.addSubview(userImage)
        view.addSubview(userNameLabel)
        view.addSubview(likeLabel)
        view.addSubview(dislikeLabel)
        
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            descriptionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            userImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            userImage.widthAnchor.constraint(equalToConstant: 40),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            
            userNameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userNameLabel.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            moreButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            dislikeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dislikeButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            
            likeButton.trailingAnchor.constraint(equalTo: dislikeButton.leadingAnchor, constant: -20),
            likeButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 3),
            
            dislikeLabel.centerYAnchor.constraint(equalTo: dislikeButton.centerYAnchor),
            dislikeLabel.leadingAnchor.constraint(equalTo: dislikeButton.trailingAnchor, constant: 3),
            
        ])
        
        return constraints
    }
    
    @objc func likeButtonTapped() {
        let state = likeButton.currentBackgroundImage == UIImage(named: "like") ? true : false
        
        if state {
            likeButton.setBackgroundImage(UIImage(named: "likeFilled"), for: .normal)
            let likes: Int? = (Int(likeLabel.text ?? "0") ?? 1) + 1
            likeLabel.text = String(likes ?? 1)
            presenter?.likeTapped(id: self.placeId, state: "LIKE")
           
            let disLikeState = dislikeButton.currentBackgroundImage == UIImage(named: "dislike") ? false : true
            if disLikeState{
                dislikeButton.setBackgroundImage(UIImage(named: "dislike"), for: .normal)
                if (dislikeLabel.text != "0") {
                    let dislikes: Int? = (Int(dislikeLabel.text ?? "0") ?? 1) - 1
                    dislikeLabel.text = String(dislikes ?? 0)
                }
            }
            
        } else {
            likeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
            var likes: Int? = (Int(likeLabel.text ?? "0") ?? 1) - 1
            if likes ?? 0 < 0 {
                likes = 0
            }
            likeLabel.text = String(likes ?? 0)
            presenter?.deleteLike(id: placeId)
        }
    }
    
    @objc func dislikeButtonTapped() {
        let state = dislikeButton.currentBackgroundImage == UIImage(named: "dislike") ? true : false
        
        if state {
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeFilled"), for: .normal)
            let dislikes: Int? = (Int(dislikeLabel.text ?? "0") ?? 1) + 1
            dislikeLabel.text = String(dislikes ?? 1)
            presenter?.likeTapped(id: self.placeId, state: "DISLIKE")
            
            let likeState = likeButton.currentBackgroundImage == UIImage(named: "like") ? false : true
            if likeState{
                likeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
                if (likeLabel.text != "0") {
                    let likes: Int? = (Int(likeLabel.text ?? "0") ?? 1) - 1
                    likeLabel.text = String(likes ?? 0)
                }
            }

        } else {
            dislikeButton.setBackgroundImage(UIImage(named: "dislike"), for: .normal)
            var dislikes: Int? = (Int(dislikeLabel.text ?? "0") ?? 1) - 1
            if dislikes ?? 0 < 0 {
                dislikes = 0
            }
            dislikeLabel.text = String(dislikes ?? 0)
            presenter?.deleteLike(id: placeId)
            
        }
    }
    
}

// MARK: - Extensions
extension PlaceDescriptionViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}

extension PlaceDescriptionViewController: MapViewProtocol {
    func isFavorite(favorite: Bool) {
        if favorite {
            
    //        let share = UIAction(title: "Поделиться",
    //          image: UIImage(named: "share")) { _ in
    //            self.presenter?.moreTapped(id: self.placeId, action: 1)
    //        }
            let favorite = UIAction(title: "Удалить из избранного",
              image: UIImage(named: "delete")) { _ in
                self.presenter?.moreTapped(id: self.placeId, action: 4)
            }
            let delete = UIAction(title: "Удалить",
              image: UIImage(named: "deletePlace")) { _ in
                self.presenter?.moreTapped(id: self.placeId, action: 3)
            }

            if (currentUserId == userId) {
                moreButton.menu = UIMenu(title: "", children: [delete, favorite])
            } else {
                moreButton.menu = UIMenu(title: "", children: [favorite])
            }
            moreButton.showsMenuAsPrimaryAction = true
        } else {
            
    //        let share = UIAction(title: "Поделиться",
    //          image: UIImage(named: "share")) { _ in
    //            self.presenter?.moreTapped(id: self.placeId, action: 1)
    //        }
            let favorite = UIAction(title: "Добавить в избранное",
              image: UIImage(named: "fav")) { _ in
                self.presenter?.moreTapped(id: self.placeId, action: 2)
            }
            let delete = UIAction(title: "Удалить",
              image: UIImage(named: "deletePlace")) { _ in
                self.presenter?.moreTapped(id: self.placeId, action: 3)
            }

            if (currentUserId == userId) {
                moreButton.menu = UIMenu(title: "", children: [delete, favorite])
            } else {
                moreButton.menu = UIMenu(title: "", children: [favorite])
            }
            moreButton.showsMenuAsPrimaryAction = true
        }
    }
    
    func setUserId(id: String) {
        currentUserId = id
    }
    
    func setFavorite(favorite: [Place]) {
        
    }
    
    func closeWithSuccess(point: Place) {
        completionHandler(point)
    
        dismiss(animated: true, completion: nil)
    }
    
    func setUpUser(userName: String, userImage: UIImage, likes: Int, dislikes: Int, myLike: String, id: String) {
        userNameLabel.text = userName
        self.userImage.image = userImage
        likeLabel.text = String(likes)
        dislikeLabel.text = String(dislikes)
        userId = id
        
        if myLike == "LIKE" {
            likeButton.setBackgroundImage(UIImage(named: "likeFilled"), for: .normal)
        } else if myLike == "DISLIKE" {
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeFilled"), for: .normal)
        }
        
        DispatchQueue.main.async {
            self.presenter?.isFavorite(id: self.placeId)
        }
        
    }
    
    func enableSaveButton() {
        
    }
    
    func disableSaveButton() {
        
    }
    
    func setStrongDescription(_ textField: UITextField) {
        
    }
    
    func setWeakDescription(_ textField: UITextField) {
        
    }
    
    
}
