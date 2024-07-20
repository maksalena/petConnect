//
//  WalksRealmModel.swift
//  PetConnect
//
//  Created by SHREDDING on 11.09.2023.
//

import Foundation
import RealmSwift

class ActiveWalksRealmModel:Object{
    @Persisted(primaryKey: true) var walkId:UUID
    
    @Persisted var petId:UUID
    @Persisted var name:String
    
    @Persisted var fileId:UUID?
    @Persisted var imageData:Data?
    
    convenience init(walkId: UUID, petId: UUID, name: String, fileId: UUID? = nil, imageData: Data? = nil) {
        self.init()
        self.walkId = walkId
        self.petId = petId
        self.name = name
        self.fileId = fileId
        self.imageData = imageData
    }
}

class FinishedWalksRealmModel:Object{
    @Persisted(primaryKey: true) var walkId:UUID
    
    @Persisted var petId:UUID
    @Persisted var name:String
    
    @Persisted var fileId:UUID?
    @Persisted var imageData:Data?
    
    @Persisted var endDate:Date
    @Persisted var isWc:Bool
    
    static let schemaVersion: UInt64 = 2
    
    convenience init(walkId: UUID, petId: UUID, name: String, fileId: UUID? = nil, imageData: Data? = nil, endDate:Date, isWc:Bool) {
        self.init()
        self.walkId = walkId
        self.petId = petId
        self.name = name
        self.fileId = fileId
        self.imageData = imageData
        self.endDate = endDate
        self.isWc = isWc
    }
}
