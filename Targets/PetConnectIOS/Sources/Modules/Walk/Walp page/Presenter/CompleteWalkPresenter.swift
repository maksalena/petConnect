//
//  CompleteWalkPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 12.09.2023.
//

import Foundation

protocol CompleteWalkViewProtocol:AnyObject{
    func endWalk()
}

protocol CompleteWalkPresenterProtocol:AnyObject{
    var dc:Bool { get set }
    var activeWalk:ActiveWalksRealmModel! { get set }
    
    init(view:CompleteWalkViewProtocol, activeWalk:ActiveWalksRealmModel, walksNetworkService:WalkNetworkServiceProtocol)
    
    func endWalkTapped()
}

class CompleteWalkPresenter:CompleteWalkPresenterProtocol{
    weak var view:CompleteWalkViewProtocol?
    
    var activeWalk:ActiveWalksRealmModel!
    var walksNetworkService:WalkNetworkServiceProtocol?
    
    var dc:Bool = true
    
    required init(view:CompleteWalkViewProtocol, activeWalk:ActiveWalksRealmModel, walksNetworkService:WalkNetworkServiceProtocol) {
        self.view = view
        self.activeWalk = activeWalk
        self.walksNetworkService = walksNetworkService
    }
    
    func endWalkTapped(){
        let petId = activeWalk.petId
        let walkId = activeWalk.walkId
        Task{
            if let isEnded = try await self.walksNetworkService?.endWalk(petId: petId, walkId: walkId, dc: self.dc){
                DispatchQueue.main.async {
                    self.view?.endWalk()
                }
                
            }
        }
    }
}
