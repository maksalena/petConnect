//
//  MapAssembly.swift
//  PetConnect
//
//  Created by Алёна Максимова on 09.09.2023.
//

import UIKit
import CoreLocation

protocol MapAssemblyProtocol {
    static func createMapViewController() -> UIViewController
    static func createFavoriteViewController() -> UIViewController
}

class MapAssembly:MapAssemblyProtocol{
    
    static func createMapViewController()->UIViewController{
        let view = MapViewController(navBar: .withBackButton, backgroundColor: .white, tintColor: .white)
        
        let pointsNetworksService = MapNetworkService()
        view.presenter = MainMapPresenter(view: view, pointsNetworksService: pointsNetworksService)
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    static func createFavoriteViewController()->UIViewController{
        let view = FavoriteViewController(navBar: .withBackButton, title: "Избранные", backgroundColor: .clear, tintColor: .white)
        let pointsNetworksService = MapNetworkService()
        view.presenter = MapPresenter(view: view, model: Place(id: UUID()), pointsNetworksService: pointsNetworksService , filesNetworkService: FilesNetworkService(), keyChainService: KeyChainStorage(), usersNetworkService: UsersNetworkService(), point: CLLocation())
        view.hidesBottomBarWhenPushed = true
        return view
    }
}

