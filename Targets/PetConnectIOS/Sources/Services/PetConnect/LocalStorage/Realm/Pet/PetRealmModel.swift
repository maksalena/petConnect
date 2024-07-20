//
//  PetRealmModel.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation
import RealmSwift

//enum PetGender: String, PersistableEnum {
//    case male
//    case female
//}

class PetRealmModel:Object{
    @Persisted(primaryKey: true) var petId:UUID
    @Persisted var name:String
    @Persisted var breed:String
    @Persisted var sex:String
    @Persisted var type:String
    @Persisted var dateOfBirth:Date
    @Persisted var avatarId:UUID?
    @Persisted var imageData:Data?
    
    @Persisted var identification:PetIdentificationRealmModel?
    
    convenience init(petId: UUID, name: String, breed: String, sex: String, type:String, dateOfBirth: Date, avatarId:UUID?,imageData:Data?, identifications:PetIdentificationRealmModel?) {
        self.init()
        self.petId = petId
        self.name = name
        self.breed = breed
        self.sex = sex
        self.type = type
        self.dateOfBirth = dateOfBirth
        self.avatarId = avatarId
        self.imageData = imageData
        self.identification = identifications
    }
    
    func isJsonPetEqual(jsonPet:OnePetJsonResponse) -> Bool {
        let first = self.petId == jsonPet.id &&
        self.name == jsonPet.name &&
        self.breed == jsonPet.breed &&
        self.sex == jsonPet.sex &&
        self.type == jsonPet.type &&
        self.dateOfBirth == Date.dateFromISO8601(jsonPet.dateOfBirth) &&
        self.avatarId == jsonPet.avatars.first?.fileID
        
        if self.identification == nil && jsonPet.identifications.first != nil{
            return false
        }
        let second = self.identification?.isEqualJson(identificationJson:jsonPet.identifications.first) ?? true

        return first && second
        
    }
}

class PetIdentificationRealmModel:EmbeddedObject{
    @Persisted() var id:UUID
    @Persisted var number:String
    @Persisted var microChippedAt:Date
    @Persisted var location:String
    @Persisted var tattooNumber:String
    @Persisted var tattooingAt:Date
    @Persisted var distinctiveMark:String
    @Persisted var reproductionData:String
    
    convenience init(id:UUID, number: String, microChippedAt: Date, location: String, tattooNumber: String, tattooingAt: Date, distinctiveMark: String, reproductionData: String) {
        self.init()
        self.id = id
        self.number = number
        self.microChippedAt = microChippedAt
        self.location = location
        self.tattooNumber = tattooNumber
        self.tattooingAt = tattooingAt
        self.distinctiveMark = distinctiveMark
        self.reproductionData = reproductionData
    }
    
    func isEqualJson(identificationJson:OneIdentificationResponse?)->Bool{
        return self.id == identificationJson?.id &&
        self.number == identificationJson?.number &&
        self.microChippedAt == Date.dateFromISO8601(identificationJson?.microChippedAt ?? "")  &&
        self.location == identificationJson?.location &&
        self.tattooNumber == identificationJson?.tattooNumber &&
        self.tattooingAt == Date.dateFromISO8601(identificationJson?.tattooingAt ?? "") &&
        self.distinctiveMark == identificationJson?.distinctiveMark &&
        self.reproductionData == identificationJson?.distinctiveMark
    }
}
