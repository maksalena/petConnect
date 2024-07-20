import ProjectDescription

/*
                +-------------+
                |             |
                |     App     | Contains PetConnect App target and PetConnect unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

let infoPlistIOS: [String: Plist.Value] = [:]

let targetIOS = Target(
    name: "PetConnect",
    platform: .iOS,
    product: .app,
    productName: "PetConnect",
    bundleId: "ranis.PetConnect",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone], supportsMacDesignedForIOS: true),
    infoPlist: .file(path: "Targets/PetConnectIOS/Info.plist"),
    sources: ["Targets/PetConnectIOS/Sources/**"],
    resources: [ "Targets/PetConnectIOS/Resources/**",
                "Targets/PetConnectIOS/GoogleService-Info.plist"],
    entitlements: .file(path: "Targets/PetConnectIOS/PetConnect.entitlements"),
    dependencies: [
        .external(name: "AlertKit"),
        .external(name: "Alamofire"),
        .external(name: "SnapKit"),
        .external(name: "KeychainSwift"),
        .external(name: "FirebaseMessaging"),
        .external(name: "UIColorExtensions"),
        .external(name: "JTAppleCalendar"),
        
        .xcframework(path: "LocalDependincies/Realm.xcframework"),
        .xcframework(path: "LocalDependincies/RealmSwift.xcframework")
    ],
    settings: .settings(
        base: [
            "OTHER_LDFLAGS": "$(OTHER_LDFLAGS)-ObjC" // for firebase

        ],
        configurations: [
            .debug(name: .debug, xcconfig: Path("Configs/PetConnectIOS.xcconfig")),
            .release(name: .release, xcconfig: Path("Configs/PetConnectIOS.xcconfig"))
        ]
    )
)

let project = Project(
    name: "PetConnect",
    organizationName: "PetConnect",
    targets: [
        targetIOS
    ]
)
