//
//  NSLayoutContraints Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 30.08.2023.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    public func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
