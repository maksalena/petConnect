//
//  MainTabBarViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 12.08.2023.
//

import UIKit

// MARK: - Main Tab Bar Configurator
@objc protocol MainTabBarDelegate{
    @objc optional func tapSelectedItem()
}

class MainTabBarViewController: UITabBarController {
    
    var customDelegate:MainTabBarDelegate?
    
    let usersNetworkService:UsersNetworkServiceProtocol = UsersNetworkService()
    let keyChainService:KeyChainStorageProtocol = KeyChainStorage()
    let imageRealmService:ImageRealmServiceProtocol = ImageRealmService()
    let filesNetworksService:FilesNetworkServiceProtocol = FilesNetworkService()
    
    private enum PageConstants{
        
        case home
        case pet
        case clinics
        case walk
        case profile
        
        /// Get a title for item in the Main Tab Bar
        /// - Returns: name of the page
        func getTitle()->String{
            switch self {
            
            case .home:
                return "Главная"
            case .pet:
                return "Питомцы"
            case .clinics:
                return "Медицина"
            case .walk:
                return "Прогулки"
            case .profile:
                return "Профиль"
            }
            
        }
        
        /// Select inactive image for unelected items in the Main Tab Bar
        /// - Returns: imge for Tab Bar
        func getImage()->UIImage?{
            switch self {
            
            case .home:
                return UIImage(named: "HomeIsNotActive")
            case .pet:
                return UIImage(named: "PetIsNotActive")
            case .clinics:
                return UIImage(named: "ClinicsIsNotActive")
            case .walk:
                return UIImage(named: "WalkIsNotActive")
            case .profile:
                return UIImage(systemName: "person")
            }
        }
        
        /// Select active image for pressed item in the Main Tab Bar
        /// - Returns: imge for Tab Bar
        func getSelectedImage()->UIImage?{
            switch self {
            case .home:
                return UIImage(named: "HomeIsActive")
            case .pet:
                return UIImage(named: "PetIsActive")
            case .clinics:
                return UIImage(named: "ClinicsIsActive")
            case .walk:
                return UIImage(named: "WalkIsActive")
            case .profile:
                return UIImage(named: "personIsActive")
            }
        }
    }

    /// Configure viewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        let homePage =  self.configureViewController(MainBuilder.createHomePage(), .home)
        
        let petPage = self.configureViewController(MainBuilder.createPetPage(), .pet)
       
        let clinicsPage = self.configureViewController(MainBuilder.createClinicsPage(), .clinics)
        
        let walkPage = self.configureViewController(MainBuilder.createWalkPage(), .walk)
        
        let profilePage = self.configureViewController(MainBuilder.createProfilePage(), .profile)
        
        self.viewControllers = [homePage, petPage, clinicsPage, walkPage, profilePage]
        self.selectedIndex = 0
        
        self.delegate = self
        loadPersonalInfo()
    }
    
    /// Set up Tab Bar item
    /// - Parameters:
    ///   - viewController: viewController for the particular page
    ///   - page: type of the page
    /// - Returns: set up viewController
    private func configureViewController(_ viewController:UIViewController, _ page:PageConstants)->UIViewController{
        viewController.tabBarItem.title = page.getTitle()
        viewController.tabBarItem.image =  page.getImage()
        viewController.tabBarItem.selectedImage = page.getSelectedImage()
        self.tabBar.tintColor = UIColor(named: "TabBarSelectedColor")
        self.tabBar.backgroundColor = UIColor(named: "TabBarBgColor")
        return viewController
    }
    
    
    func loadPersonalInfo(){
        Task{
            if let personalInfo = try await usersNetworkService.getMe(){
                var image:Data?
                
                keyChainService.setId(id: personalInfo.id)
                keyChainService.setEmail(email: personalInfo.email)
                keyChainService.setUsername(username: personalInfo.username)
                
                keyChainService.setFirstName(firstName: personalInfo.firstName ?? "")
                keyChainService.setSecondName(secondName: personalInfo.lastName ?? "")
                keyChainService.setMiddleName(middleName: personalInfo.middleName ?? "")
                keyChainService.setIsClinicAccount(personalInfo.hasClinicAccount)
                keyChainService.setCreatedAt(createdAt: personalInfo.createdAt)
                keyChainService.setUpdatedAt(updatedAt: personalInfo.updateAt)
                
                
                if !personalInfo.hasClinicAccount{
                    do{
                        try await usersNetworkService.integrateUser()
                        keyChainService.setIsClinicAccount(true)
                        let _ = try await AuthNetworkService.refreshToken()
                    } catch{
                        
                    }
                }
                                
                if let photoId = personalInfo.avatars.first?.fileID{
                    DispatchQueue.main.async {
                        image = self.imageRealmService.getImage(by: photoId)
                    }
                    
                    if image == nil{
                        if let photoPath = personalInfo.avatars.first?.filePath{
                            image = try await self.filesNetworksService.downloadPhoto(photoPath)
                            
                            if image != nil{
                                DispatchQueue.main.async {
                                    
                                    self.imageRealmService.setImage(id: photoId, imageData: image!, filePath: photoPath)
                                    self.keyChainService.setUserPhoto(image: image!)
                                }
                            }
                        }
                    }
                    
                }else{
                    keyChainService.deleteUserPhoto()
                }
                                
            }
        }
    }
}

extension MainTabBarViewController:UITabBarControllerDelegate{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.selectedItem{
            self.customDelegate?.tapSelectedItem?()
        }
    }
}
