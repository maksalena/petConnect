//
//  PetDetailPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 30.08.2023.
//

import Foundation
import UIKit

protocol PetDetailPhotoViewProtocol:AnyObject{
    func setPhoto(image:UIImage?)
    func setMainInfo(name: String, breed: String, sex: String, age: Date)
    func setChip(chipNumber:String?, chipDate:String?, chipPlace:String?)
    func setSigma(sigmaNumber:String?, sigmaDate:String?)
}

protocol PetDetailPhotoPresenterProtocol:AnyObject{
    init(view:PetDetailPhotoViewProtocol, pet:PetHim)
    var pet:PetHim! { get }
    func viewDidLoad()
}

class PetDetailPhotoPresenter:PetDetailPhotoPresenterProtocol{
    weak var view:PetDetailPhotoViewProtocol?
    
    var pet:PetHim!
    var image:UIImage?
    
    required init(view:PetDetailPhotoViewProtocol, pet:PetHim) {
        self.view = view
        self.pet = pet
    }
    
    func viewDidLoad(){
        var sex:String = ""
        
        switch pet.gender{
        case .female: sex = "девочка"
        case .male: sex = "мальчик"
        default:
            break
        }
        
        view?.setPhoto(image: self.image)
        
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
    }
    
}
