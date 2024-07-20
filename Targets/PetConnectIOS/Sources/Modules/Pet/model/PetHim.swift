//
//  Pet.swift
//  PetConnect
//
//  Created by Алёна Максимова on 29.08.2023.
//

import Foundation
import UIKit

struct Chip {
    var id: String = ""
    var date: String = ""
    var place: String = ""
}

struct Mark {
    var id: String = ""
    var date: String = ""
}

enum Gender:String {
    case female = "FEMALE"
    case male = "MALE"
    case unknown
}

public struct PetHim {
    var id:UUID?
    var identificationId:UUID?
    
    var name: String = ""
    var type: String = ""
    var breed: String = ""
    var birthday: String = ""
    var gender: Gender = .female
    var avatar: String = ""
    var chip = Chip()
    
    var image:UIImage?
    var mark = Mark()
    
    init(){
        
    }
    init(id: UUID? = nil, identificationId:UUID? = nil, name: String, type: String, breed: String, birthday: String, gender: Gender, avatar: String, chip: Chip = Chip(), image: UIImage? = nil, mark: Mark = Mark()) {
        self.id = id
        self.identificationId = identificationId
        self.name = name
        self.type = type
        self.breed = breed
        self.birthday = birthday
        self.gender = gender
        self.avatar = avatar
        self.chip = chip
        self.image = image
        self.mark = mark
    }
    
    mutating func setName(name: String){
        self.name = name
    }
    mutating func setType(type: String){
        self.type = type
    }
    mutating func setBreed(breed: String){
        self.breed = breed
    }
    mutating func setBirthday(birthday: String){
        self.birthday = birthday
    }
    mutating func setGender(gender: Gender){
        self.gender = gender
    }
    mutating func setAvatar(avatar: String){
        self.avatar = avatar
    }
    mutating func setChipId(id: String){
        self.chip.id = id
    }
    mutating func setChipDate(date: String){
        self.chip.date = date
    }
    mutating func setChipPlace(place: String){
        self.chip.place = place
    }
    mutating func setChip(chip: Chip){
        self.chip = chip
    }
    mutating func setMarkID(id: String){
        self.mark.id = id
    }
    mutating func setMarkDate(date: String){
        self.mark.date = date
    }
    mutating func setMark(mark: Mark){
        self.mark = mark
    }
    mutating func setImage(image: UIImage){
        self.image = image
    }
    
    func getName()->String{
        return name
    }
    func getType()->String{
        return type
    }
    func getBreed()->String{
        return breed
    }
    func getBirthday()->String{
        return birthday
    }
    func getGender()->Gender{
        return gender
    }
    func getAvatar()->String{
        return avatar
    }
    func getChipID()->String?{
        return self.chip.id
    }
    func getChipDate()->String?{
        return self.chip.date
    }
    func getChipPlace()->String?{
        return self.chip.place
    }
    func getChip()->Chip?{
        return self.chip
    }
    func getMarkID()->String?{
        return self.mark.id
    }
    func getMarkDate()->String?{
        return self.mark.date
    }
    func getMark()->Mark?{
        return self.mark
    }
    
    func isEmptyData()->Bool{
        if name.isEmpty || breed.isEmpty || birthday.isEmpty ||  type.isEmpty {
            return true
        }
        return false
    }
}


