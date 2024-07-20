//
//  WalkAssemby.swift
//  PetConnect
//
//  Created by SHREDDING on 08.09.2023.
//

import Foundation
import UIKit

protocol WalkAssembyProtocol{
    static func createChoosingPetViewController(doAfterStart: @escaping (()->Void))->UIViewController
    static func createCompleteWalkController(activeWalk: ActiveWalksRealmModel, doAfterEnd: @escaping (()->Void))->UIViewController
}

class WalkAssemby:WalkAssembyProtocol{
    static func createChoosingPetViewController(doAfterStart: @escaping (()->Void))->UIViewController{
        let view = ChoosingPetViewController()
        
        let petsNetworksService = PetsNetworkService()
        let petsRealmService = PetsRealmService()
        let imageRealmService = ImageRealmService()
        let filesNetworkService = FilesNetworkService()
        let keychainService = KeyChainStorage()
        let walksRealmService = WalksRelmService()
        
        
        let walksNetworkService = WalkNetworkService()
        let presenter = ChoosingPetPresenter(view: view, walksNetworkService: walksNetworkService,petsRealmService: petsRealmService, walksRealmService: walksRealmService)
        
        view.presenter = presenter
        view.doAfterStart = doAfterStart
        
        return view
    }
    
    static func createCompleteWalkController(activeWalk: ActiveWalksRealmModel, doAfterEnd: @escaping (()->Void))->UIViewController{
        let view = CompleteWalkViewController()
        
        let walkNetworkSevice = WalkNetworkService()
        
        let presenter = CompleteWalkPresenter(view: view, activeWalk: activeWalk, walksNetworkService: walkNetworkSevice)
        
        view.presenter = presenter
        view.doAfterEnd = doAfterEnd
        
        return view
    }
    
}
