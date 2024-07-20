//
//  RequestPresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 23.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation

protocol RequestViewProtocol:AnyObject{
    
    func reloadPets()
    
    func enableButton()
    func disableButton()
}

protocol RequestPresenterProtocol:AnyObject{
    init(
        view:RequestViewProtocol,
        dateTime:(
            date:Date,
            timeId:UUID,
            timeString:String
        ),
        doctor:DoctorModel,
        clinic:PetClinicModel,
        petsNetworkService:PetsNetworkServiceProtocol
    )
    
    var dateTime:(date:Date, timeId:UUID, timeString:String) { get }
    var doctor:DoctorModel { get }
    var clinic:PetClinicModel { get }
    
    var petsNames:[String] { get }
    
    var selected:RequestSelectedModel { get }
    
    func setPet(index:Int)
    func deselectPet()
    func setCompliance(text:String)
}
class RequestPresenter:RequestPresenterProtocol{
    weak var view:RequestViewProtocol?
    
    var dateTime:(date:Date, timeId:UUID, timeString:String)
    var doctor:DoctorModel
    var clinic:PetClinicModel
    
    var selected:RequestSelectedModel = RequestSelectedModel()
    var petsModel:[PetRequest] = []
    var petsNames:[String] = []
    
    var petsNetworkService:PetsNetworkServiceProtocol
    
    required init(
        view:RequestViewProtocol,
        dateTime:(date:Date, timeId:UUID, timeString:String),
        doctor:DoctorModel,
        clinic:PetClinicModel,
        petsNetworkService:PetsNetworkServiceProtocol
    ) {
        self.view = view
        self.dateTime = dateTime
        self.petsNetworkService = petsNetworkService
        self.doctor = doctor
        self.clinic = clinic
        
        loadPets()
    }
    
    func loadPets(){
        Task{
            do{
                let petsJson = try await petsNetworkService.getAllPets()
                
                for pet in petsJson.content{
                    let newPet = PetRequest(
                        id: pet.id,
                        name: pet.name,
                        hasClinicAccount: pet.hasClinicAccount
                    )
                    petsModel.append(newPet)
                    petsNames.append(pet.name)
                    
                }
                
                DispatchQueue.main.async {
                    self.view?.reloadPets()
                }
            } catch{
                
            }
        }
    }
    
    
    func setCompliance(text:String){
        self.selected.compliance = text
        
        if self.selected.compliance?.count ?? 0 > 0 && self.selected.pet != nil{
            self.view?.enableButton()
        }else{
            self.view?.disableButton()
        }
    }
    
    func setPet(index:Int){
        self.selected.pet = self.petsModel[index]
        
        if self.selected.compliance?.count ?? 0 > 0 && self.selected.pet != nil{
            self.view?.enableButton()
        }else{
            self.view?.disableButton()
        }
    }
    
    func deselectPet(){
        self.selected.pet = nil
        self.view?.disableButton()
    }
}
