//
//  TabletsFoddersRealmService.swift
//  PetConnect
//
//  Created by SHREDDING on 10.09.2023.
//

import Foundation
import RealmSwift

protocol TabletsFoddersRealmServiceProtocol{
    func getAllTabletsFodders() -> Results<TabletsFoddersRealmModel>
    func getTabletFodder(by id: UUID) -> TabletsFoddersRealmModel?
    func setTabletFodder(_ tabletFodder:TabletsFoddersRealmModel)
    func appendTabletFodder(petId:UUID, tabletFodder: OneTabletsFoddersRealmModel)
    func modifyTabletFodder(petId:UUID, id: UUID, tabletFodder: OneTabletsFoddersRealmModel)
    func updateTabletFodder(_ tabletFodder:TabletsFoddersRealmModel)
    func updateTabletsFodders(_ tabletsFodders:[TabletsFoddersRealmModel])
    func deleteNotContains(ids: Set<UUID>)
    func deleteTabletFodder(petId:UUID,by id: UUID)
}

class TabletsFoddersRealmService:TabletsFoddersRealmServiceProtocol{
    let realm = try! Realm()
    
    func getAllTabletsFodders() -> Results<TabletsFoddersRealmModel>{
        return realm.objects(TabletsFoddersRealmModel.self)
    }
    
    func getTabletFodder(by id: UUID) -> TabletsFoddersRealmModel?{
        return realm.object(ofType: TabletsFoddersRealmModel.self, forPrimaryKey: id)
    }
    
    func setTabletFodder(_ tabletFodder:TabletsFoddersRealmModel){
        try! realm.write({
            realm.add(tabletFodder, update: .modified)
        })
    }
    
    func appendTabletFodder(petId:UUID, tabletFodder: OneTabletsFoddersRealmModel){
        if let realmObject = self.getTabletFodder(by: petId){
           try!  realm.write {
               realmObject.tabletsFodders.append(tabletFodder)
            }
        }
    }
    
    func modifyTabletFodder(petId:UUID, id: UUID, tabletFodder: OneTabletsFoddersRealmModel){
        if let tabletFodderRelm = self.getTabletFodder(by: petId){
            try! realm.write({
                if let index = tabletFodderRelm.tabletsFodders.firstIndex(where: { $0.id == id }) {
                    tabletFodderRelm.tabletsFodders.replace(index: index, object: tabletFodder)
                }
            })
        }
    }
    
    func updateTabletFodder(_ tabletFodder:TabletsFoddersRealmModel){
        try! realm.write({
            realm.add(tabletFodder,update: .modified)
        })
    }
    
    func updateTabletsFodders(_ tabletsFodders:[TabletsFoddersRealmModel]){
        try! realm.write({
            for object in tabletsFodders{
                realm.add(object,update: .modified)
            }
            
        })
    }
    
    func deleteNotContains(ids: Set<UUID>){
        let itemsToDelete = realm.objects(TabletsFoddersRealmModel.self).filter("NOT petId IN %@", ids)

        try! realm.write {
            realm.delete(itemsToDelete)
        }
    }
    
    func deleteTabletFodder(petId:UUID,by id: UUID){
        if let tabletFodder = self.getTabletFodder(by: petId){
            try! realm.write({
                if let index = tabletFodder.tabletsFodders.firstIndex(where: { $0.id == id }) {
                    tabletFodder.tabletsFodders.remove(at: index)
                }
            })
        }
    }
}
