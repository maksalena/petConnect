//
//  PetDetilInfoPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 30.08.2023.
//

import Foundation

protocol PetDetilInfoViewProtocol:AnyObject{
    
    func setMainInfo(name:String, breed:String, sex:String, age:Date)
    func setChip(chipNumber:String?, chipDate:String?, chipPlace:String?)
    func setSigma(sigmaNumber:String?, sigmaDate:String?)
}

protocol PetDetilInfoPresenterProtocol:AnyObject{
    init(view:PetDetilInfoViewProtocol, pet:PetHim, petNetWorksService:PetsNetworkServiceProtocol)
    
    var pet:PetHim! { get }
    
    func viewDidLoad()
    
    func loadIdentifications()
}

class PetDetilInfoPresenter:PetDetilInfoPresenterProtocol{
    weak var view:PetDetilInfoViewProtocol?
    
    var pet:PetHim!
    
    var petId:UUID!
    var petNetWorksService:PetsNetworkServiceProtocol?
    
    required init(view:PetDetilInfoViewProtocol, pet:PetHim, petNetWorksService:PetsNetworkServiceProtocol) {
        self.view = view
        self.pet = pet
        self.petNetWorksService = petNetWorksService
    }
    
    func viewDidLoad(){
        var sex:String = ""
        
        switch pet.gender{
        case .female: sex = "девочка"
        case .male: sex = "мальчик"
        default:
            break
        }
        
        view?.setMainInfo(
            name: pet.name,
            breed: pet.breed,
            sex: sex,
            age: Date.dateToString(pet.birthday) ?? Date.now
        )
        
        view?.setChip(
            chipNumber: pet.chip.id,
            chipDate: pet.chip.date,
            chipPlace: pet.chip.place
        )
        
        view?.setSigma(
            sigmaNumber: pet.mark.id,
            sigmaDate: pet.mark.date
        )
        self.petId = pet.id
        loadIdentifications()
    }
        
    func loadIdentifications(){
        Task{
            if let identifications = try await self.petNetWorksService?.getIdentification(petId: petId){
                //print(identifications.content)
            }
        }
    }
    
}
