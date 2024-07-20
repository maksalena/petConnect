//
//  AppointmentTypePresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 16.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

protocol AppointmentTypeViewProtocol:AnyObject{
    
}

protocol AppointmentTypePresenterProtocol:AnyObject{
    init(view:AppointmentTypeViewProtocol, clinic:PetClinicModel)
    
    var clinic:PetClinicModel{ get }
}

class AppointmentTypePresenter:AppointmentTypePresenterProtocol{
    weak var view:AppointmentTypeViewProtocol?
    
    var clinic:PetClinicModel
    
    required init(view:AppointmentTypeViewProtocol, clinic:PetClinicModel) {
        self.view = view
        self.clinic = clinic
    }
}
