//
//  GreetingPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import RealmSwift

protocol GreetingViewProtocol:AnyObject{
    
}

protocol GreetingPresenterProtocol:AnyObject{
    init(view:GreetingViewProtocol)
    
    func willAppear()
}

class GreetingPresenter:GreetingPresenterProtocol{
    weak var view:GreetingViewProtocol?
    
    required init(view:GreetingViewProtocol) {
        self.view = view
    }
    
    func willAppear(){
        let realm =  try! Realm()
        let keychain = KeyChainStorage()
       try! realm.write {
            realm.deleteAll()
        }
        
        keychain.deleteAll()
    }
}
