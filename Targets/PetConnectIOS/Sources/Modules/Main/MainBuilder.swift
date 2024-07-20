//
//  MainBuilder.swift
//  PetConnect
//
//  Created by SHREDDING on 12.08.2023.
//

import Foundation
import UIKit

// MARK: - MainBuilderProtocol
protocol MainBuilderProtocol{
    /// Create Main Builder
    /// - Returns: Main Tab Bar
    static func createMainBuilder() -> UIViewController
    
    static func setAuthWindow(window:UIWindow?)
    static func setMainWindow(window:UIWindow?)
    
    static func createAuth()->UIViewController
  
    /// Create home page
    /// - Returns: home page
    static func createHomePage()->UIViewController
    
    /// Create pet page
    /// - Returns: pet pager
    static func createPetPage()->UIViewController
    
    static func createClinicsPage()->UIViewController
    
    /// Create walk page
    /// - Returns: walk page
    static func createWalkPage()->UIViewController
    
    /// Create profile page
    /// - Returns: profile page
    static func createProfilePage()->UIViewController
    
}

// MARK: - MainBuilder
class MainBuilder:MainBuilderProtocol{
    
    static func setAuthWindow(window:UIWindow?){
        let options = UIWindow.TransitionOptions()
        
        options.direction = .fade
        options.duration = 0.3
        
        window?.set(rootViewController: MainBuilder.createAuth(), options: options)
    }
    
    static func setMainWindow(window:UIWindow?){
        let options = UIWindow.TransitionOptions()
        
        options.direction = .fade
        options.duration = 0.3
        
        window?.set(rootViewController: MainBuilder.createMainBuilder(), options: options)
    }
    
    static func createMainBuilder() -> UIViewController{
        let tabBar = MainTabBarViewController()
        return tabBar
    }
    
    // MARK: - Auth
    static func createAuth()->UIViewController{
        let view = GreetingViewController(navBar: .none)
        let presenter = GreetingPresenter(view: view)
        view.presenter = presenter
        return BaseNavigationController(rootViewController: view)
    }
    
    
    // MARK: - Main Pages
    static func createHomePage()->UIViewController{
        
        let view = HomePageViewController(navBar: .primary, title: "Главная")
        let petsRealmService = PetsRealmService()
        let petsNetworkService = PetsNetworkService()
        let imageRealmService = ImageRealmService()
        let filesNetworkService = FilesNetworkService()
        let keychainService = KeyChainStorage()
        
        let tabletsFoddersNetworkService = TabletsFoddersNetworkService()
        let tabletsFoddersRealmService = TabletsFoddersRealmService()
        
        
        
        let presenter = HomePagePresenter(view: view, tabletsFoddersNetworkService: tabletsFoddersNetworkService, tabletsFoddersRealmService: tabletsFoddersRealmService, petsNetworkService: petsNetworkService, petsRealmService: petsRealmService)
        
        let petsPresenter = PetsPresenter(view: view, petsNetworksService: petsNetworkService, petsRealmService: petsRealmService, imageRealmService: imageRealmService, filesNetworkService: filesNetworkService, keychainService: keychainService)
        
        view.presenter = presenter
        view.petsPresenter = petsPresenter
        presenter.view = view
                
        return BaseNavigationController(rootViewController: view)
    }
    
    static func createPetPage()->UIViewController{
        let petsVC = PetViewController(navBar: .primary, title: "Питомцы")
        let petsNetworkservice = PetsNetworkService()
        let petsRealmService = PetsRealmService()
        let imageRealmService = ImageRealmService()
        let filesNetworkService = FilesNetworkService()
        let keychainService = KeyChainStorage()
        
        let presenter = PetsPresenter(view: petsVC, petsNetworksService: petsNetworkservice,petsRealmService: petsRealmService, imageRealmService: imageRealmService, filesNetworkService: filesNetworkService, keychainService: keychainService)
        petsVC.presenter = presenter
        return BaseNavigationController(rootViewController: petsVC )
    }
    
    static func createClinicsPage()->UIViewController{
        let clinicsVC = ClinicsViewController(navBar: .primary, title: "Медицина")
        let clinicsNetworkService = AppointmentClinicsNetworkService()
        //let clinicsRealmService = ClinicsRealmService()
        //let imageRealmService = ImageRealmService()
        let filesNetworkService = FilesNetworkService()
        let keychainService = KeyChainStorage()
        
        let presenter = ClinicsPresenter(
            view: clinicsVC,
            clinicsNetworkService: clinicsNetworkService,
            filesNetworkService: filesNetworkService,
            keychainService: keychainService
        )
        clinicsVC.presenter = presenter
        return BaseNavigationController(rootViewController: clinicsVC )
    }
    
    static func createWalkPage()->UIViewController{
        let view = WalkViewController(navBar: .primary, title: "Прогулки")
        let walksNetworkService = WalkNetworkService()
        let walksRealmService = WalksRelmService()
        let imageRealmService = ImageRealmService()
        let filesNetworkService = FilesNetworkService()
        
        let presenter = WalkPresenter(view: view, walksNetworkService: walksNetworkService,walksRealmService: walksRealmService, imageRealmService: imageRealmService, filesNetworkService: filesNetworkService)
        view.presenter = presenter
        return BaseNavigationController(rootViewController: view)
    }
    
    static func createProfilePage()->UIViewController{
        let view = ProfileViewController(navBar: .primary, title: "Профиль")
        let authNetworkService = AuthNetworkService()
        let usersNetworkService = UsersNetworkService()
        let keyChainService = KeyChainStorage()
        let filesNetworkService = FilesNetworkService()
        let imageRealmService = ImageRealmService()
        
        let presenter = ProfilePresenter(view: view, authNetworkService: authNetworkService, usersNetworkService: usersNetworkService, keyChainService: keyChainService,filesNetworkService: filesNetworkService, imageRealmService: imageRealmService)
        view.presenter = presenter
        
        return BaseNavigationController(rootViewController: view)
    }
    
}
