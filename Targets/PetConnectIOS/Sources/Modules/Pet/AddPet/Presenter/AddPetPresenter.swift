//
//  AddPetPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.08.2023.
//

import Foundation
import UIKit

public enum petFields{
    case name
    case gender
    case breed
    case type
    case birthday
    case chipId
    case chipDate
    case chipPlace
    case markId
    case markDate
}

protocol PetViewProtocol: AnyObject {

    func enableSaveButton()
    func disableSaveButton()
    func popView(with message:String)
    func fillValues(_ pet:PetHim)
    
}

protocol PetPresenterProtocol: AnyObject {
    var originalItems:[String] { get }
    var presentedItems:[String] { get }
    
    
    init(
        view: PetViewProtocol,
        model: PetHim, petsNetworkService:PetsNetworkServiceProtocol,
        petsRealmService:PetsRealmServiceProtocol, filesNetworksService:FilesNetworkServiceProtocol,
        imageRealmService:ImageRealmServiceProtocol
    )
    
    func setPetData(type: petFields, value: String)
    func fillValues()
    func savedTapped()
    func updateTapped()
    func setImage(image:UIImage)
    func deleteTapped()
}

class PetPresenter: PetPresenterProtocol {
    weak var view: PetViewProtocol?
    var model: PetHim?
    
    var petsNetworkService:PetsNetworkServiceProtocol?
    var filesNetworksService:FilesNetworkServiceProtocol?
    var petsRealmService:PetsRealmServiceProtocol?
    
    var imageRealmService:ImageRealmServiceProtocol?
    
    
    var originalItems:[String] = ["DOG", "CAT"]
    var presentedItems:[String] = ["Собака", "Кошка"]
    
    
    required init(
        view: PetViewProtocol, model: PetHim, petsNetworkService:PetsNetworkServiceProtocol, petsRealmService:PetsRealmServiceProtocol,filesNetworksService:FilesNetworkServiceProtocol,imageRealmService:ImageRealmServiceProtocol) {
            self.view = view
            self.model = model
            self.view?.disableSaveButton()
            self.petsNetworkService = petsNetworkService
            self.petsRealmService = petsRealmService
            self.filesNetworksService = filesNetworksService
            self.imageRealmService = imageRealmService
    }
    func fillValues(){
        view?.fillValues(model ?? PetHim())
    }
    func setPetData(type: petFields, value: String) {
        switch type {
        case .name:
            model?.setName(name: value)
        case .gender:
            model?.setGender(gender: Gender(rawValue: value) ?? .female)
        case .breed:
            model?.setBreed(breed: value)
        case .birthday:
            model?.setBirthday(birthday: value)
        case .chipId:
            model?.setChipId(id: value)
        case .chipDate:
            model?.setChipDate(date: value)
        case .chipPlace:
            model?.setChipPlace(place: value)
        case .markId:
            model?.setMarkID(id: value)
        case .markDate:
            model?.setMarkDate(date: value)
            
        case .type:
            model?.setType(type: value)
        }
        
        if (model?.isEmptyData() ?? true){
            view?.disableSaveButton()
        } else {
            view?.enableSaveButton()
        }
    }
    
    func setImage(image:UIImage){
        self.model?.setImage(image: image)
    }
    
    func savedTapped() {
        
        let newDate = Date.dateToString(self.model?.birthday ?? "")
        guard let newIsoDatestring = newDate?.toISO8601() else { return }
        
        let petJson = createPetRequestJson(name: self.model?.name ?? "", breed: self.model?.breed ?? "", sex: self.model?.gender.rawValue ?? "", dateOfBirth: newIsoDatestring, type: self.model?.type ?? "")
        
        let identification = CreateIdentificationRequestJson(
            number: model?.chip.id ?? "",
            microChippedAt: Date.dateToString(model?.chip.date ?? "")?.toISO8601() ?? Date.now.toISO8601(),
            location: model?.chip.place ?? "",
            tattooNumber: model?.mark.id ?? "",
            tattooingAt: Date.dateToString(model?.mark.date ?? "")?.toISO8601() ?? Date.now.toISO8601(),
            distinctiveMark: "",
            reproductionData: ""
        )
        
        Task{
            do{
                if let result = try await self.petsNetworkService?.createPet(petJson: petJson){
                                    
                    let petRealm = PetRealmModel(petId: result.id, name: result.name, breed: result.breed, sex: result.sex, type: result.type, dateOfBirth: Date.dateFromISO8601(result.dateOfBirth) ?? Date.now, avatarId: result.avatars.first?.fileID, imageData: nil, identifications: nil)
                    
                    DispatchQueue.main.async {
                        self.petsRealmService?.setPet(petRealm)
                    }
                    
                    if let newIdentification = try await self.petsNetworkService?.setIdentification(petId: result.id, identification: identification){
                        
                        let identification = PetIdentificationRealmModel(id: newIdentification.id, number: newIdentification.number, microChippedAt: Date.dateToString(newIdentification.microChippedAt ?? "") ?? Date.now, location: newIdentification.location, tattooNumber: newIdentification.tattooNumber, tattooingAt: Date.dateToString(newIdentification.tattooingAt ?? "") ?? Date.now, distinctiveMark: newIdentification.distinctiveMark, reproductionData: newIdentification.reproductionData)
                        
                        DispatchQueue.main.async {
                            self.petsRealmService?.addIdentification(result.id, identification: identification)
                        }
                    }
                    
                    if let newImage = model?.image, let uploadResult = try await self.filesNetworksService?.uploadPhoto(image: newImage, .petAvatar){
                        
                        DispatchQueue.main.async {

                            self.imageRealmService?.setImage(id: uploadResult.id, imageData: newImage.jpegData(compressionQuality: 1)!, filePath: uploadResult.path)
                            
                            self.petsRealmService?.updatePetImage(result.id, imageData: newImage.jpegData(compressionQuality: 1)!)
                        }
                        
                        let addedPhotoResult = try await self.petsNetworkService?.updateAvatar(petId: result.id, imageId: uploadResult.id)
                        
                    }
                    
                }
                
                
                
            }catch PetsError.unknown{
                print("Error Create pet unknown")
            }catch PetsError.refreshTokenError{
                print("Error Create pet refreshTokenError")
            }catch PetsError.errorParseJson{
                print("Error Create pet errorParseJson")
            }catch FilesErrors.unknown{
                print("Error add image pet unknown")
            }
            
            DispatchQueue.main.async {
                self.view?.popView(with: "Питомец добавлен")
            }
        }
    }
    
    func updateTapped(){
        let newDate = Date.dateToString(self.model?.birthday ?? "")
        guard let newIsoDatestring = newDate?.toISO8601() else { return }
        
        let petJson = createPetRequestJson(name: self.model?.name ?? "", breed: self.model?.breed ?? "", sex: self.model?.gender.rawValue ?? "", dateOfBirth: newIsoDatestring, type: self.model?.type ?? "")
                
        let identification = CreateIdentificationRequestJson(
            number: model?.chip.id ?? "",
            microChippedAt: Date.dateToString(model?.chip.date ?? "")?.toISO8601() ?? Date.now.toISO8601(),
            location: model?.chip.place ?? "",
            tattooNumber: model?.mark.id ?? "",
            tattooingAt: Date.dateToString(model?.mark.date ?? "")?.toISO8601() ?? Date.now.toISO8601(),
            distinctiveMark: "",
            reproductionData: ""
        )
        guard let petId = model?.id else{ return }
        Task{
            print("updateTapped")
            do{
                if let result = try await self.petsNetworkService?.updatePet(petId: petId, petJson: petJson){
                    
                    var imageId:UUID?
                    var imageData:Data?
                    var updatedIdentificationRealm:PetIdentificationRealmModel? = nil
                    
                    if let identificationId = model?.identificationId, let updatedIdentification = try await self.petsNetworkService?.updateIdentification(petId: petId, identificationId: identificationId, identification: identification){
                        
                        updatedIdentificationRealm = PetIdentificationRealmModel(
                            id: updatedIdentification.id,
                            number: updatedIdentification.number,
                            microChippedAt: Date.dateToString(updatedIdentification.microChippedAt ?? "") ?? Date.now,
                            location: updatedIdentification.location,
                            tattooNumber: updatedIdentification.tattooNumber,
                            tattooingAt: Date.dateToString(updatedIdentification.tattooingAt ?? "") ?? Date.now,
                            distinctiveMark: updatedIdentification.distinctiveMark,
                            reproductionData: updatedIdentification.reproductionData
                        )
                        
                    }
                    
                    
                    if let newImage = model?.image, let uploadResult = try await self.filesNetworksService?.uploadPhoto(image: newImage, .petAvatar){
                        
                        imageId = result.id
                        imageData = newImage.jpegData(compressionQuality: 1)
                        
                        DispatchQueue.main.async {
                            self.imageRealmService?.setImage(id: uploadResult.id, imageData: newImage.jpegData(compressionQuality: 1)!, filePath: uploadResult.path)
                        }
                        
                        let addedPhotoResult = try await self.petsNetworkService?.updateAvatar(petId: result.id, imageId: uploadResult.id)
                        
                    }
                    
                    let petRealm = PetRealmModel(petId: result.id, name: result.name, breed: result.breed, sex: result.sex, type: result.type, dateOfBirth: Date.dateFromISO8601(result.dateOfBirth) ?? Date.now, avatarId: imageId, imageData: imageData, identifications: updatedIdentificationRealm)
                    
                    DispatchQueue.main.async {
                        self.petsRealmService?.updatePet(petRealm)
                    }
                                                            
                }
                
            }catch PetsError.unknown{
                print("Error Create pet unknown")
            }catch PetsError.refreshTokenError{
                print("Error Create pet refreshTokenError")
            }catch PetsError.errorParseJson{
                print("Error Create pet errorParseJson")
            }catch FilesErrors.unknown{
                print("Error add image pet unknown")
            }
            
            DispatchQueue.main.async {
                self.view?.popView(with: "Питомец обновлен")
            }
        }
        
        
    }
    
    func deleteTapped() {
        
        Task{
            if let id = model?.id{
                let isdeleted:Bool = try await self.petsNetworkService?.deletePet(petId:id) ?? false
                
                if isdeleted{
                    DispatchQueue.main.async {
                        self.petsRealmService?.deletePet(by: id)
                        self.view?.popView(with: "Питомец удален")
                    }
                }
            }
            
        }
    }
    
}
