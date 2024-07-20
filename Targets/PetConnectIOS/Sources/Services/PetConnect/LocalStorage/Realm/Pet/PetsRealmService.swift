//
//  PetsRealmService.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation

import RealmSwift

protocol PetsRealmServiceProtocol{
    func getAllPets() -> Results<PetRealmModel>
    func getPet(by id:UUID) -> PetRealmModel?
    func setPet(_ pet:PetRealmModel)
    func updatePet(_ pet:PetRealmModel)
    func updatePets(_ pets:[PetRealmModel])
    func updatePetImage(_ by:UUID, imageData:Data)
    func addIdentification(_ by:UUID, identification:PetIdentificationRealmModel)
    func deleteAll()
    func deleteNotContains(ids:Set<UUID>)
    func deletePet(by id:UUID)
}

class PetsRealmService:PetsRealmServiceProtocol{
    let realm = try! Realm()
    
    func getAllPets() -> Results<PetRealmModel> {
        return realm.objects(PetRealmModel.self)
    }
    
    func getPet(by id:UUID) -> PetRealmModel?{
        return realm.object(ofType: PetRealmModel.self, forPrimaryKey: id)
    }
    
    func setPet(_ pet:PetRealmModel){
        try! realm.write {
            realm.add(pet)
        }
    }
    func updatePet(_ pet:PetRealmModel){
        try! realm.write({
            realm.add(pet,update: .modified)
        })
    }
    
    func updatePets(_ pets:[PetRealmModel]){
        try! realm.write({
            for pet in pets{
                realm.add(pet, update: .modified)
            }
            
        })
    }
    
    func updatePetImage(_ by:UUID, imageData:Data){
        let pet = realm.object(ofType: PetRealmModel.self, forPrimaryKey: by)
        
        try! realm.write {
            pet?.imageData = imageData
        }
    }
    
    func addIdentification(_ by:UUID, identification:PetIdentificationRealmModel){
        let pet = realm.object(ofType: PetRealmModel.self, forPrimaryKey: by)
        
        try! realm.write({
            pet?.identification = identification
        })
    }
    
    func deleteAll(){
        let petObjects = realm.objects(PetRealmModel.self)
        try! realm.write({
            realm.delete(petObjects)
        })
    }
    
    func deleteNotContains(ids:Set<UUID>){
        let itemsToDelete = realm.objects(PetRealmModel.self).filter("NOT petId IN %@", ids)

        try! realm.write {
            realm.delete(itemsToDelete)
        }
    }
    
    func deletePet(by id:UUID){
        if let pet = self.getPet(by: id){
            try! realm.write({
                realm.delete(pet)
            })
        }
    }
}
