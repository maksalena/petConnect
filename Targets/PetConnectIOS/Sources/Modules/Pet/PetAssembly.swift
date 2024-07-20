//
//  PetAssembly.swift
//  PetConnect
//
//  Created by SHREDDING on 28.08.2023.
//

import UIKit

protocol PetAssemblyProtocol{
    static func createPetDetailPhotoViewController(pet: PetHim) -> UIViewController
    
    static func createAddPetViewController(model: PetHim?, isEdit:Bool) -> UIViewController
}

class PetAssembly:PetAssemblyProtocol{
    
    static func createPetDetailPhotoViewController(pet: PetHim) -> UIViewController{
        let detailController = PetDetailPhotoViewController(navBar: .withBackButton, backgroundColor: .white, tintColor: .clear)
        let presenter = PetDetailPhotoPresenter(view: detailController, pet: pet)
        detailController.presenter = presenter
        
        detailController.hidesBottomBarWhenPushed = true
        
        return detailController
    }
    
    
    static func createAddPetViewController(model: PetHim? = nil, isEdit:Bool = false) -> UIViewController {
        let view = AddPetViewController(navBar: .withBackButton, title: isEdit == true ? "Редактирование": "Новый питомец")
        
        let petsNetworkService = PetsNetworkService()
        let filesNetworksService = FilesNetworkService()
        let petsRealmService = PetsRealmService()
        let imageRealmService = ImageRealmService()
                 
        let presenter = PetPresenter(view: view, model: model ?? PetHim() ,petsNetworkService: petsNetworkService,petsRealmService: petsRealmService, filesNetworksService: filesNetworksService, imageRealmService: imageRealmService)
        
        view.presenter = presenter
        view.editMode = isEdit
        view.hidesBottomBarWhenPushed = true
        
        return view
    }

}
