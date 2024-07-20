//
//  WalksRelmService.swift
//  PetConnect
//
//  Created by SHREDDING on 11.09.2023.
//

import Foundation
import RealmSwift

protocol WalksRelmServiceProtocol{
    func getAllActiveWalks() -> Results<ActiveWalksRealmModel>
    func getAllFinishedWalks() ->  Results<FinishedWalksRealmModel>
    
    func setActiveWalk(_ walk:ActiveWalksRealmModel)
    func setFinishedWalk(_ walk:FinishedWalksRealmModel)
    
    func updateActiveWalks(_ walks:[ActiveWalksRealmModel])
    func updateFinishedWalks(_ walks:[FinishedWalksRealmModel])
    
    func deleteActiveWalksNotContains(ids:Set<UUID>)
    
    
}

class WalksRelmService:WalksRelmServiceProtocol{
    
    var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch {
                print("Error")
            }
            return self.realm
        }
    }
    
    
    func getAllActiveWalks() -> Results<ActiveWalksRealmModel> {
        return realm.objects(ActiveWalksRealmModel.self)
    }
    
    func getAllFinishedWalks() -> Results<FinishedWalksRealmModel> {
        return realm.objects(FinishedWalksRealmModel.self)
    }
    
    func setActiveWalk(_ walk: ActiveWalksRealmModel) {
        try! realm.write {
            realm.add(walk)
        }
    }
    
    func setFinishedWalk(_ walk: FinishedWalksRealmModel) {
        
        try! realm.write {
            realm.add(walk)
        }
        
    }
    
    func updateActiveWalks(_ walks: [ActiveWalksRealmModel]) {
        try! realm.write {
            for walk in walks {
                realm.add(walk,update: .modified)
            }
        }
    }
    
    func updateFinishedWalks(_ walks: [FinishedWalksRealmModel]) {
        try! realm.write {
            for walk in walks {
                realm.add(walk,update: .modified)
            }
        }
    }
    
    func deleteActiveWalksNotContains(ids:Set<UUID>){
        let itemsToDelete = realm.objects(ActiveWalksRealmModel.self).filter("NOT walkId IN %@", ids)
        
        do {
            try realm.write {
                realm.delete(itemsToDelete)
            }
        } catch{
            print("Error delete")
        }
    }
    
}
