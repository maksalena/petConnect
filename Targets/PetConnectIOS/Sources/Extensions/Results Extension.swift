//
//  Results Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
