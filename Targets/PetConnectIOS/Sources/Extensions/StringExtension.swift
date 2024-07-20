//
//  StringExtension.swift
//  PetConnect
//
//  Created by Егор Завражнов on 14.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import Foundation
import UIKit
extension String{
    public static func callNumber(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}
