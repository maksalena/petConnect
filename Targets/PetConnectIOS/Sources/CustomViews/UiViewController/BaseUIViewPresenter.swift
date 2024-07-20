//
//  BaseUIViewPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.09.2023.
//

import Foundation

protocol BaseUIViewProtocol:AnyObject{
    
}

protocol BaseUIViewPresenterProtocol:AnyObject{
    init(view:BaseUIViewProtocol)
    
    func getUserPhoto()->Data?
}
class BaseUIViewPresenter:BaseUIViewPresenterProtocol{
    weak var view:BaseUIViewProtocol?
    
    var keychainService = KeyChainStorage()
    
    required init(view:BaseUIViewProtocol) {
        self.view = view
    }
    
    func getUserPhoto()->Data?{
        return keychainService.getUserPhoto()
    }
    
}
