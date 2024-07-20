//
//  ChoosingPetPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 12.09.2023.
//

import Foundation

protocol ChoosingPetViewProtocol:AnyObject{
    func startWalk()
}

protocol ChoosingPetPresenterProtocol:AnyObject{
    init(view:ChoosingPetViewProtocol,walksNetworkService: WalkNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol, walksRealmService:WalksRelmServiceProtocol)
    
    var selectedIds:Set<UUID> { get set }
    var nonActivePets:[PetRealmModel] { get }
    
    func startWalksTapped()
}

class ChoosingPetPresenter:ChoosingPetPresenterProtocol{
    weak var view:ChoosingPetViewProtocol?
    
    var walksNetworkService: WalkNetworkServiceProtocol?
    var petsRealmService:PetsRealmServiceProtocol?
    var walksRealmService:WalksRelmServiceProtocol?
    
    var selectedIds:Set<UUID> = Set<UUID>()
    
    var allPets: [PetRealmModel] = []
    var activeWalksPetIds:[UUID] = []
    var nonActivePets:[PetRealmModel] = []
    
    required init(view:ChoosingPetViewProtocol, walksNetworkService: WalkNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol, walksRealmService:WalksRelmServiceProtocol) {
        self.view = view
        self.walksNetworkService = walksNetworkService
        self.petsRealmService = petsRealmService
        self.walksRealmService = walksRealmService
        
        
        self.getAllPetsFromRealm()
        self.getActivePetsFromRealm()
        
        for pet in allPets {
            if !activeWalksPetIds.contains(pet.petId){
                nonActivePets.append(pet)
            }
        }
    }
    
    func getAllPetsFromRealm(){
        if let realmPets = self.petsRealmService?.getAllPets().toArray(){
            self.allPets = realmPets
        }
    }
    
    func getActivePetsFromRealm(){
        if let activeWalks = walksRealmService?.getAllActiveWalks(){
            for walk in activeWalks{
                activeWalksPetIds.append(walk.petId)
            }
        }
    }
    
    func startWalksTapped(){
        Task{
            for id in selectedIds{
                do {
                    if let _ = try await self.walksNetworkService?.startWalk(petId: id){
                        DispatchQueue.main.async {
                            self.view?.startWalk()
                        }
                        
                    }
                } catch{
                    print("Error start walk")
                }
                
            }
        }
    }
    
}
