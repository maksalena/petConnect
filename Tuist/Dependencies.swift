import ProjectDescription
//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by SHREDDING on 28.10.2023.
//

import Foundation
let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/sparrowcode/AlertKit", requirement: .upToNextMajor(from: "5.1.1")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0")),
        .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.8.1")),
        .remote(url: "https://github.com/evgenyneu/keychain-swift.git", requirement: .upToNextMajor(from: "20.0.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url: "https://github.com/SHREDDING8/UIColorExtensions", requirement: .branch("main")),
        .remote(url: "https://github.com/patchthecode/JTAppleCalendar", requirement: .branch("master"))
    ],
    platforms: [.iOS]
)
