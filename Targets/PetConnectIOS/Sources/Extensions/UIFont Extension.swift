//
//  UIFont Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 24.10.2023.
//

import Foundation
import UIKit

public enum SFProDisplayWeight:String{
    case light =  "Light"
    case regualar = "Regular"
    case bold = "Bold"
    case medium = "Medium"
    case heavy = "Heavy"
    case semibold = "Semibold"
}

extension UIFont{
    static func SFProDisplay(weight:SFProDisplayWeight, ofSize:CGFloat) -> UIFont?{
        UIFont(name: "SFProDisplay-\(weight.rawValue)", size: ofSize)
    }
}
