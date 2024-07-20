//
//  IdentificationsRealmModel.swift
//  PetConnect
//
//  Created by SHREDDING on 10.09.2023.
//

import Foundation
import RealmSwift

enum TabletsFoddersRealmType:String,PersistableEnum{
    case tablet
    case fodder
}

class TabletsFoddersRealmModel:Object{
    @Persisted(primaryKey: true) var petId:UUID
    @Persisted var tabletsFodders:List<OneTabletsFoddersRealmModel>
    
    
    convenience init(petId: UUID, tabletsFodders: List<OneTabletsFoddersRealmModel>) {
        self.init()
        self.petId = petId
        self.tabletsFodders = tabletsFodders
        
    }
}

class OneTabletsFoddersRealmModel:EmbeddedObject{
    @Persisted var id:UUID
    @Persisted var name:String
    @Persisted var type:TabletsFoddersRealmType
    @Persisted var untilAt:Date
    @Persisted var periods = List<OnePeriodRealmModel>()
    
    convenience init(id: UUID, name: String, type:TabletsFoddersRealmType,untilAt:Date, periods: List<OnePeriodRealmModel> = List<OnePeriodRealmModel>()) {
        self.init()
        self.id = id
        self.name = name
        self.type = type
        self.untilAt = untilAt
        self.periods = periods
    }
}

class OnePeriodRealmModel:EmbeddedObject{
    @Persisted var count:Int
    @Persisted var time:String
    
    static let schemaVersion: UInt64 = 2
    
    convenience init(count: Int, time: String) {
        self.init()
        self.count = count
        self.time = time
    }
}
