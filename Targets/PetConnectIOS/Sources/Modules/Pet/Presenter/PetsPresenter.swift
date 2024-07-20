//
//  PetsPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation
import UIKit
import RealmSwift

@objc protocol PetsViewProtocol:AnyObject{
    func updateAllPets()
     @objc optional func successAlert(message:String)
}

protocol PetsPresenterProtocol:AnyObject{
    init(view:PetsViewProtocol, petsNetworksService:PetsNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol, imageRealmService:ImageRealmServiceProtocol, filesNetworkService:FilesNetworkService, keychainService:KeyChainStorageProtocol)
        
    var pets:[PetHim] { get }
    
    func getAllPetsFromServer()
    func getAllPetsFromRealm()
    func deletePet(petId:UUID)
        
}
class PetsPresenter:PetsPresenterProtocol{
    
    weak var view:PetsViewProtocol?
    
    var pets: [PetHim] = []
    
    var petsNetworksService:PetsNetworkServiceProtocol?
    var petsRealmService:PetsRealmServiceProtocol?
    
    var imageRealmService:ImageRealmServiceProtocol?
    var filesNetworkService:FilesNetworkServiceProtocol?
    
    var keychainService:KeyChainStorageProtocol?
    
    required init(view:PetsViewProtocol, petsNetworksService:PetsNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol, imageRealmService:ImageRealmServiceProtocol, filesNetworkService:FilesNetworkService, keychainService:KeyChainStorageProtocol) {
        self.view = view
        self.petsNetworksService = petsNetworksService
        self.petsRealmService = petsRealmService
        self.imageRealmService = imageRealmService
        self.filesNetworkService = filesNetworkService
        self.keychainService = keychainService
    }
    

    
    func petsFromRealm(_ realmPets:Results<PetRealmModel>) -> [PetHim]{
        var pets:[PetHim] = []
        
        for pet in realmPets{
            var image:UIImage? = nil
            if let imageData = pet.imageData{
                image = UIImage(data: imageData)
            }
                        
            let newPet = PetHim(
                id: pet.petId,
                identificationId: pet.identification?.id,
                name: pet.name,
                type: "",
                breed: pet.breed,
                birthday: pet.dateOfBirth.toString(),
                gender: Gender(rawValue: pet.sex) ?? .male,
                avatar: "",
                chip: Chip(id: pet.identification?.number ?? "", date: pet.identification?.microChippedAt.toString() ?? "", place: pet.identification?.location ?? ""),
                image: image,
                
                mark: Mark(id: pet.identification?.tattooNumber ?? "", date: pet.identification?.tattooingAt.toString() ?? "")
            )
            
            pets.append(newPet)
        }
        return pets
    }
    
    func getAllPetsFromRealm(){
        print("getAllPetsFromRealm")
        if let realmPets = self.petsRealmService?.getAllPets(){
            print("realmPets")
            self.pets = petsFromRealm(realmPets)
            self.view?.updateAllPets()
        }
    }
    
    func getAllPetsFromServer(){
        let petsRealm = self.petsRealmService?.getAllPets()
        Task{
            do {
                if let allPets = try await petsNetworksService?.getAllPets().content{
                    
                    var petServerIdentifires = Set<UUID>()
                    var petsToUpdate:[PetRealmModel] = []
                                            
                        for pet in allPets{
                            petServerIdentifires.insert(pet.id)
                            var image:Data?
                            
                            if let id = pet.avatars.first?.fileID{
                                DispatchQueue.main.sync {
                                    image = self.imageRealmService?.getImage(by: id)
                                }
                                
                                if image == nil{
                                    if let path = pet.avatars.first?.filePath{
                                        image = try await self.filesNetworkService?.downloadPhoto(path)
                                        
                                        if image != nil{
                                            DispatchQueue.main.sync {
                                                self.imageRealmService?.setImage(id: id, imageData: image!, filePath: path)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            DispatchQueue.main.sync {
                                
                                // Поиск объекта в Realm по id
                                if let petRealm = petsRealm?.filter("petId == %@", pet.id).first {
                                    // Объект с таким id существует в Realm
                                    // Здесь вы можете выполнить необходимую логику сравнения или обновления
                                    let isPetRelevant = petRealm.isJsonPetEqual(jsonPet: pet)
                                    print("сравнение \(isPetRelevant)")
                                    print("Объект с таким id существует в Realm")
                                    
                                    if !isPetRelevant{
                                        var identification:PetIdentificationRealmModel?
                                    
                                        if let petIdentification = pet.identifications.first{
                                            identification = PetIdentificationRealmModel(
                                                id: petIdentification.id,
                                                number: petIdentification.number,
                                                microChippedAt: Date.dateFromISO8601(petIdentification.microChippedAt ?? "") ?? Date.now,
                                                location: petIdentification.location,
                                                tattooNumber: petIdentification.tattooNumber,
                                                tattooingAt: Date.dateFromISO8601(petIdentification.tattooingAt ?? "") ?? Date.now,
                                                distinctiveMark: petIdentification.distinctiveMark,
                                                reproductionData: petIdentification.reproductionData
                                            )
                                        }
                                        
                                        let petRealm = PetRealmModel(petId: pet.id, name: pet.name, breed: pet.breed, sex: pet.sex, type: pet.type, dateOfBirth: Date.dateFromISO8601(pet.dateOfBirth) ?? Date.now, avatarId: pet.avatars.first?.fileID, imageData: image, identifications: identification)
                                        
                                        petsToUpdate.append(petRealm)
                                    }
                                } else {
                                    // Объект с таким id отсутствует в Realm
                                    print("Объект с таким отсутствует в Realm")
                                                                            
                                        var identification:PetIdentificationRealmModel?
                                    
                                        if let petIdentification = pet.identifications.first{
                                            identification = PetIdentificationRealmModel(
                                                id: petIdentification.id,
                                                number: petIdentification.number,
                                                microChippedAt: Date.dateFromISO8601(petIdentification.microChippedAt ?? "") ?? Date.now,
                                                location: petIdentification.location,
                                                tattooNumber: petIdentification.tattooNumber,
                                                tattooingAt: Date.dateFromISO8601(petIdentification.tattooingAt ?? "") ?? Date.now,
                                                distinctiveMark: petIdentification.distinctiveMark,
                                                reproductionData: petIdentification.reproductionData
                                            )
                                        }
                                        
                                    let petRealm = PetRealmModel(petId: pet.id, name: pet.name, breed: pet.breed, sex: pet.sex, type: pet.type, dateOfBirth: Date.dateFromISO8601(pet.dateOfBirth) ?? Date.now, avatarId: pet.avatars.first?.fileID, imageData: image, identifications: identification)
                                    
                                    self.petsRealmService?.setPet(petRealm)
                                    
                                }
                            }

                        }

                    DispatchQueue.main.sync {
                        self.petsRealmService?.deleteNotContains(ids: petServerIdentifires)
                        self.petsRealmService?.updatePets(petsToUpdate)
                        self.getAllPetsFromRealm()
                    }
                }
                
            }catch PetsError.errorParseJson{
                print("errorParseJson")
            }catch PetsError.refreshTokenError{
                print("refreshTokenError")
            }catch PetsError.unknown{
                print("unknown")
            }catch AuthErrors.unknown{
                print("unknown2")
            }
            
        }
    }
    
    func deletePet(petId:UUID){
        Task{
            let isdeleted:Bool = try await self.petsNetworksService?.deletePet(petId:petId) ?? false
            
            if isdeleted{
                DispatchQueue.main.async {
                    self.petsRealmService?.deletePet(by: petId)
                    self.getAllPetsFromRealm()
                    self.view?.successAlert?(message: "Питомец удален")
                }
            }
        }
    }
}
