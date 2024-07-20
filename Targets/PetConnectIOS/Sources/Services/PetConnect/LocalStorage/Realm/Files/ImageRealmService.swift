//
//  ImageRealmService.swift
//  PetConnect
//
//  Created by SHREDDING on 04.09.2023.
//

import Foundation
import RealmSwift
import UIKit

protocol ImageRealmServiceProtocol{
    func setImage(id:UUID, imageData:Data, filePath:String)
    func getImage(by id:UUID?)->Data?
    
    func getAllImages() -> [ImageRealmModel]
}

class ImageRealmService:ImageRealmServiceProtocol{
    let realm = try! Realm()
    
    func setImage(id:UUID, imageData:Data, filePath:String){
        let newImage = ImageRealmModel(id: id, imageData: imageData, filePath: filePath)
        do {
            try realm.write {
                realm.add(newImage, update: .modified)
            }
        }catch{
            print("Error")
        }
    }
    
    func getImage(by id:UUID?)->Data?{
        
        if id == nil {return nil}
        
        let image = realm.object(ofType: ImageRealmModel.self, forPrimaryKey: id)
        return image?.imageData
    }
    
    func getAllImages() -> [ImageRealmModel]{
        let images = realm.objects(ImageRealmModel.self).toArray()
        return images
    }
}
