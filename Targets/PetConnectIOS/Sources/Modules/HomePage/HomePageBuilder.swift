//
//  HomePageBuilder.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import UIKit
protocol HomePageBuilderProtocol{
    
    /// creates Notification Page
    /// - Returns: notification UIViewController
    static func createNotificationPage(pet:PetHim, isEdit:Bool, notification:OneTabletsFoddersRealmModel?)->UIViewController
}

class HomePageBuilder: HomePageBuilderProtocol{
    
    static func createNotificationPage(pet:PetHim, isEdit:Bool = false, notification:OneTabletsFoddersRealmModel? = nil) -> UIViewController {
        let view = NotificationViewController(navBar: .withBackButton, title: "Новое напоминание")
        view.hidesBottomBarWhenPushed = true
        let model = Notification()
        
        let tabletsFodderNetworkServices = TabletsFoddersNetworkService()
        let tabletsFoddersRealmService = TabletsFoddersRealmService()
        
        let presenter = NotificationPresenter(view: view, model: model, pet: pet, tabletsFodderNetworkServices: tabletsFodderNetworkServices, tabletsFoddersRealmService: tabletsFoddersRealmService, isEdit: isEdit, notification: notification)
        
        view.presenter = presenter
        return view
    }
}

