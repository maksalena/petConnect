//
//  SpecialistPresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 16.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

protocol SpecialistViewProtocol:AnyObject{
    
}

protocol SpecialistPresenterProtocol:AnyObject{
    init(view:SpecialistViewProtocol, clinic:PetClinicModel)
    
    var clinic:PetClinicModel{ get }
}

class SpecialistPresenter:SpecialistPresenterProtocol{
    weak var view:SpecialistViewProtocol?
    var clinic:PetClinicModel
    
    required init(view:SpecialistViewProtocol, clinic:PetClinicModel) {
        self.view = view
        self.clinic = clinic
    }
}
