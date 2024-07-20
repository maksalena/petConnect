// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/sparrowcode/AlertKit", from: "5.1.1"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.15.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "20.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.1"),
        .package(url: "https://github.com/SHREDDING8/UIColorExtensions", branch: "main"),
        .package(url: "https://github.com/patchthecode/JTAppleCalendar", branch: "master"),
    ]
)