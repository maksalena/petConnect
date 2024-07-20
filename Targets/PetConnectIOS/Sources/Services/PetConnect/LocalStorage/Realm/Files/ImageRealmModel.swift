//
//  ImageRealmModel.swift
//  PetConnect
//
//  Created by SHREDDING on 04.09.2023.
//

import Foundation
import RealmSwift

class ImageRealmModel:Object{
    @Persisted(primaryKey: true) var id:UUID
    @Persisted var filePath:String
    @Persisted var imageData:Data
    
    convenience init(id: UUID, imageData: Data, filePath:String) {
        self.init()
        self.id = id
        self.filePath = filePath
        self.imageData = imageData
    }
}
