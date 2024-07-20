//
//  WalkPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 06.09.2023.
//

import UIKit
import RealmSwift

protocol WalkViewProtocol: AnyObject {
    func updateWalks(isActive:Bool)
    
}

protocol WalkPresenterProtocol: AnyObject {
    init(
        view: WalkViewProtocol,
        walksNetworkService:WalkNetworkServiceProtocol,
        walksRealmService:WalksRelmServiceProtocol,
        imageRealmService:ImageRealmServiceProtocol,
        filesNetworkService:FilesNetworkServiceProtocol
    )
    
    var activeWalks:[ActiveWalksRealmModel] { get }
    var finishedWalks:[FinishedWalksRealmModel] { get }
    
    func loadWalksFromServer()
    func getActiveWalksFromRealm()
    func getFinishedWalksFromRealm()
    
}

class WalkPresenter: WalkPresenterProtocol {
    weak var view: WalkViewProtocol?
    var walksNetworkService:WalkNetworkServiceProtocol?
    var walksRealmService:WalksRelmServiceProtocol?
    var imageRealmService:ImageRealmServiceProtocol?
    var filesNetworkService:FilesNetworkServiceProtocol?
    
    var activeWalks:[ActiveWalksRealmModel] = []
    var finishedWalks:[FinishedWalksRealmModel] = []
    
    
    required init(
        view: WalkViewProtocol, walksNetworkService:WalkNetworkServiceProtocol,walksRealmService:WalksRelmServiceProtocol, imageRealmService:ImageRealmServiceProtocol, filesNetworkService:FilesNetworkServiceProtocol) {
            self.view = view
            self.walksNetworkService = walksNetworkService
            self.walksRealmService = walksRealmService
            self.imageRealmService = imageRealmService
            self.filesNetworkService = filesNetworkService
    }
        
    func getActiveWalksFromRealm(){
        if let activeWalks = self.walksRealmService?.getAllActiveWalks(){
            self.activeWalks =  activeWalks.toArray()
            self.view?.updateWalks(isActive: true)
        }
    }
    
    func getFinishedWalksFromRealm(){
        if let finishedWalks = self.walksRealmService?.getAllFinishedWalks(){
            
            self.finishedWalks = finishedWalks.toArray().sorted(by: { first, second in
                first.endDate > second.endDate
            })
            
            self.view?.updateWalks(isActive: false)
        }
    }
    
    func loadWalksFromServer(){
        Task{
            do {
                if let walks = try await self.walksNetworkService?.findWalks(isActive: true){
                    var activeWalkServerIdentifires = Set<UUID>()
                    
                    for walk in walks.content{
                        var image:Data?
                        
                        activeWalkServerIdentifires.insert(walk.id)
                        
                        if let id = walk.pet.avatars.first?.fileID{
                            DispatchQueue.main.sync {
                                image = self.imageRealmService?.getImage(by: id)
                            }
                            
                            if image == nil{
                                if let path = walk.pet.avatars.first?.filePath{
                                    image = try await self.filesNetworkService?.downloadPhoto(path)
                                    
                                    if image != nil{
                                        DispatchQueue.main.sync {
                                            self.imageRealmService?.setImage(id: id, imageData: image!, filePath: path)
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                        let activeWalk = ActiveWalksRealmModel(walkId: walk.id, petId: walk.pet.id, name: walk.pet.name, fileId: walk.pet.avatars.first?.fileID, imageData: image)
                        
                        DispatchQueue.main.sync {
                            self.walksRealmService?.updateActiveWalks([activeWalk])
                        }
                        
                    }
                    
                    DispatchQueue.main.sync {
                        self.walksRealmService?.deleteActiveWalksNotContains(ids: activeWalkServerIdentifires)
                        self.getActiveWalksFromRealm()
                    }
                    
                }
                
                if let walks = try await self.walksNetworkService?.findWalks(isActive: false){
                    
                    for walk in walks.content{
                        var image:Data?
                        
                        if let id = walk.pet.avatars.first?.fileID{
                            DispatchQueue.main.sync {
                                image = self.imageRealmService?.getImage(by: id)
                            }
                            
                            if image == nil{
                                print(2)
                                if let path = walk.pet.avatars.first?.filePath{
                                    image = try await self.filesNetworkService?.downloadPhoto(path)
                                    
                                    if image != nil{
                                        DispatchQueue.main.sync {
                                            self.imageRealmService?.setImage(id: id, imageData: image!, filePath: path)
                                        }
                                    }
                                }
                            }
                        }
                        
                        let finishedWalk = FinishedWalksRealmModel(walkId: walk.id, petId: walk.pet.id, name: walk.pet.name, fileId: walk.pet.avatars.first?.fileID, imageData: image,endDate: Date.dateFromISO8601(walk.updateAt) ?? Date.now, isWc: walk.dc)
                        
                        DispatchQueue.main.async {
                            self.walksRealmService?.updateFinishedWalks([finishedWalk])
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.getFinishedWalksFromRealm()
                    }
                }
                
                
                
            } catch{
                
            }
            
        }
    }
}
