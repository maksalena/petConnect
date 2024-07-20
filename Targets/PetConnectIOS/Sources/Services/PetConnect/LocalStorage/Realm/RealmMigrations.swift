//
//  RealmMigrations.swift
//  PetConnect
//
//  Created by SHREDDING on 17.09.2023.
//

import Foundation
import RealmSwift

class RealmMigrations{
    static func migrate() {
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Миграция модели OnePeriodRealmModel
                    migration.enumerateObjects(ofType: OnePeriodRealmModel.className()) { oldObject, newObject in
                        if let oldTime = oldObject?["time"] as? Date {
                            newObject?["time"] = oldTime.timeToString()
                        }
                    }
                    // Миграция модели FinishedWalksRealmModel
                    migration.enumerateObjects(ofType: FinishedWalksRealmModel.className()) { oldObject, newObject in
                        newObject?["isWc"] = false
                    }
                    
                }
                
                if oldSchemaVersion < 4 {
                    // Миграция модели PetRealmModel
                    migration.enumerateObjects(ofType: PetRealmModel.className()) { oldObject, newObject in
                        newObject?["type"] = ""
                    }
                }
            })
        
        Realm.Configuration.defaultConfiguration = config
        
    }
}
