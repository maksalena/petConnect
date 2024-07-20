import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "Blue" asset catalog color resource.
    static let blue = ColorResource(name: "Blue", bundle: resourceBundle)

    /// The "DropDownTableViewBg" asset catalog color resource.
    static let dropDownTableViewBg = ColorResource(name: "DropDownTableViewBg", bundle: resourceBundle)

    /// The "Gray" asset catalog color resource.
    static let gray = ColorResource(name: "Gray", bundle: resourceBundle)

    /// The "GreetingGreen" asset catalog color resource.
    static let greetingGreen = ColorResource(name: "GreetingGreen", bundle: resourceBundle)

    /// The "GreetingLightGreen" asset catalog color resource.
    static let greetingLightGreen = ColorResource(name: "GreetingLightGreen", bundle: resourceBundle)

    /// The "LightBlue" asset catalog color resource.
    static let lightBlue = ColorResource(name: "LightBlue", bundle: resourceBundle)

    /// The "NavBarBgColor" asset catalog color resource.
    static let navBarBg = ColorResource(name: "NavBarBgColor", bundle: resourceBundle)

    /// The "ShadowColor" asset catalog color resource.
    static let shadow = ColorResource(name: "ShadowColor", bundle: resourceBundle)

    /// The "TabBarBgColor" asset catalog color resource.
    static let tabBarBg = ColorResource(name: "TabBarBgColor", bundle: resourceBundle)

    /// The "TabBarSelectedColor" asset catalog color resource.
    static let tabBarSelected = ColorResource(name: "TabBarSelectedColor", bundle: resourceBundle)

    /// The "WrongValue" asset catalog color resource.
    static let wrongValue = ColorResource(name: "WrongValue", bundle: resourceBundle)

    /// The "cover" asset catalog color resource.
    static let cover = ColorResource(name: "cover", bundle: resourceBundle)

    /// The "darkGreen" asset catalog color resource.
    static let darkGreen = ColorResource(name: "darkGreen", bundle: resourceBundle)

    /// The "error" asset catalog color resource.
    static let error = ColorResource(name: "error", bundle: resourceBundle)

    /// The "foodNotifCell" asset catalog color resource.
    static let foodNotifCell = ColorResource(name: "foodNotifCell", bundle: resourceBundle)

    /// The "greenColor" asset catalog color resource.
    static let green = ColorResource(name: "greenColor", bundle: resourceBundle)

    /// The "medicineNotifCell" asset catalog color resource.
    static let medicineNotifCell = ColorResource(name: "medicineNotifCell", bundle: resourceBundle)

    /// The "on-surface" asset catalog color resource.
    static let onSurface = ColorResource(name: "on-surface", bundle: resourceBundle)

    /// The "outline" asset catalog color resource.
    static let outline = ColorResource(name: "outline", bundle: resourceBundle)

    /// The "primary" asset catalog color resource.
    static let primary = ColorResource(name: "primary", bundle: resourceBundle)

    /// The "primary-30%" asset catalog color resource.
    static let primary30 = ColorResource(name: "primary-30%", bundle: resourceBundle)

    /// The "select" asset catalog color resource.
    static let select = ColorResource(name: "select", bundle: resourceBundle)

    /// The "surface" asset catalog color resource.
    static let surface = ColorResource(name: "surface", bundle: resourceBundle)

    /// The "textBlue" asset catalog color resource.
    static let textBlue = ColorResource(name: "textBlue", bundle: resourceBundle)

    /// The "textColor" asset catalog color resource.
    static let text = ColorResource(name: "textColor", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "ClinicsIsActive" asset catalog image resource.
    static let clinicsIsActive = ImageResource(name: "ClinicsIsActive", bundle: resourceBundle)

    /// The "ClinicsIsNotActive" asset catalog image resource.
    static let clinicsIsNotActive = ImageResource(name: "ClinicsIsNotActive", bundle: resourceBundle)

    /// The "CllinicProfileTest" asset catalog image resource.
    static let cllinicProfileTest = ImageResource(name: "CllinicProfileTest", bundle: resourceBundle)

    /// The "DoctorProfileTest" asset catalog image resource.
    static let doctorProfileTest = ImageResource(name: "DoctorProfileTest", bundle: resourceBundle)

    /// The "Greeting" asset catalog image resource.
    static let greeting = ImageResource(name: "Greeting", bundle: resourceBundle)

    /// The "HomeIsActive" asset catalog image resource.
    static let homeIsActive = ImageResource(name: "HomeIsActive", bundle: resourceBundle)

    /// The "HomeIsNotActive" asset catalog image resource.
    static let homeIsNotActive = ImageResource(name: "HomeIsNotActive", bundle: resourceBundle)

    /// The "PetIsActive" asset catalog image resource.
    static let petIsActive = ImageResource(name: "PetIsActive", bundle: resourceBundle)

    /// The "PetIsNotActive" asset catalog image resource.
    static let petIsNotActive = ImageResource(name: "PetIsNotActive", bundle: resourceBundle)

    /// The "PetTracker" asset catalog image resource.
    static let petTracker = ImageResource(name: "PetTracker", bundle: resourceBundle)

    /// The "WalkIsActive" asset catalog image resource.
    static let walkIsActive = ImageResource(name: "WalkIsActive", bundle: resourceBundle)

    /// The "WalkIsNotActive" asset catalog image resource.
    static let walkIsNotActive = ImageResource(name: "WalkIsNotActive", bundle: resourceBundle)

    /// The "add" asset catalog image resource.
    static let add = ImageResource(name: "add", bundle: resourceBundle)

    /// The "anyDoctor" asset catalog image resource.
    static let anyDoctor = ImageResource(name: "anyDoctor", bundle: resourceBundle)

    /// The "approvedAppointment" asset catalog image resource.
    static let approvedAppointment = ImageResource(name: "approvedAppointment", bundle: resourceBundle)

    /// The "avatar" asset catalog image resource.
    static let avatar = ImageResource(name: "avatar", bundle: resourceBundle)

    /// The "buttonAdd" asset catalog image resource.
    static let buttonAdd = ImageResource(name: "buttonAdd", bundle: resourceBundle)

    /// The "chat" asset catalog image resource.
    static let chat = ImageResource(name: "chat", bundle: resourceBundle)

    /// The "clinic" asset catalog image resource.
    static let clinic = ImageResource(name: "clinic", bundle: resourceBundle)

    /// The "clinicAdress" asset catalog image resource.
    static let clinicAdress = ImageResource(name: "clinicAdress", bundle: resourceBundle)

    /// The "cross" asset catalog image resource.
    static let cross = ImageResource(name: "cross", bundle: resourceBundle)

    /// The "declinedAppointment" asset catalog image resource.
    static let declinedAppointment = ImageResource(name: "declinedAppointment", bundle: resourceBundle)

    /// The "delete" asset catalog image resource.
    static let delete = ImageResource(name: "delete", bundle: resourceBundle)

    /// The "deletePlace" asset catalog image resource.
    static let deletePlace = ImageResource(name: "deletePlace", bundle: resourceBundle)

    /// The "dislike" asset catalog image resource.
    static let dislike = ImageResource(name: "dislike", bundle: resourceBundle)

    /// The "dislikeFilled" asset catalog image resource.
    static let dislikeFilled = ImageResource(name: "dislikeFilled", bundle: resourceBundle)

    /// The "doctor" asset catalog image resource.
    static let doctor = ImageResource(name: "doctor", bundle: resourceBundle)

    /// The "dogBowl" asset catalog image resource.
    static let dogBowl = ImageResource(name: "dogBowl", bundle: resourceBundle)

    /// The "dogMedicine" asset catalog image resource.
    static let dogMedicine = ImageResource(name: "dogMedicine", bundle: resourceBundle)

    /// The "email" asset catalog image resource.
    static let email = ImageResource(name: "email", bundle: resourceBundle)

    /// The "fav" asset catalog image resource.
    static let fav = ImageResource(name: "fav", bundle: resourceBundle)

    /// The "favorite" asset catalog image resource.
    static let favorite = ImageResource(name: "favorite", bundle: resourceBundle)

    /// The "female" asset catalog image resource.
    static let female = ImageResource(name: "female", bundle: resourceBundle)

    /// The "femaleSeg" asset catalog image resource.
    static let femaleSeg = ImageResource(name: "femaleSeg", bundle: resourceBundle)

    /// The "filledStar" asset catalog image resource.
    static let filledStar = ImageResource(name: "filledStar", bundle: resourceBundle)

    /// The "kit" asset catalog image resource.
    static let kit = ImageResource(name: "kit", bundle: resourceBundle)

    /// The "like" asset catalog image resource.
    static let like = ImageResource(name: "like", bundle: resourceBundle)

    /// The "likeFilled" asset catalog image resource.
    static let likeFilled = ImageResource(name: "likeFilled", bundle: resourceBundle)

    /// The "line" asset catalog image resource.
    static let line = ImageResource(name: "line", bundle: resourceBundle)

    /// The "logout" asset catalog image resource.
    static let logout = ImageResource(name: "logout", bundle: resourceBundle)

    /// The "male" asset catalog image resource.
    static let male = ImageResource(name: "male", bundle: resourceBundle)

    /// The "maleSeg" asset catalog image resource.
    static let maleSeg = ImageResource(name: "maleSeg", bundle: resourceBundle)

    /// The "map" asset catalog image resource.
    static let map = ImageResource(name: "map", bundle: resourceBundle)

    /// The "markerDangerous" asset catalog image resource.
    static let markerDangerous = ImageResource(name: "markerDangerous", bundle: resourceBundle)

    /// The "markerPlayground" asset catalog image resource.
    static let markerPlayground = ImageResource(name: "markerPlayground", bundle: resourceBundle)

    /// The "markerWalks" asset catalog image resource.
    static let markerWalks = ImageResource(name: "markerWalks", bundle: resourceBundle)

    /// The "medicalWorker" asset catalog image resource.
    static let medicalWorker = ImageResource(name: "medicalWorker", bundle: resourceBundle)

    /// The "more" asset catalog image resource.
    static let more = ImageResource(name: "more", bundle: resourceBundle)

    /// The "notification" asset catalog image resource.
    static let notification = ImageResource(name: "notification", bundle: resourceBundle)

    /// The "personIsActive" asset catalog image resource.
    static let personIsActive = ImageResource(name: "personIsActive", bundle: resourceBundle)

    /// The "petDetail" asset catalog image resource.
    static let petDetail = ImageResource(name: "petDetail", bundle: resourceBundle)

    /// The "profile" asset catalog image resource.
    static let profile = ImageResource(name: "profile", bundle: resourceBundle)

    /// The "share" asset catalog image resource.
    static let share = ImageResource(name: "share", bundle: resourceBundle)

    /// The "sideArrow" asset catalog image resource.
    static let sideArrow = ImageResource(name: "sideArrow", bundle: resourceBundle)

    /// The "star" asset catalog image resource.
    static let star = ImageResource(name: "star", bundle: resourceBundle)

    /// The "tool" asset catalog image resource.
    static let tool = ImageResource(name: "tool", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    #warning("The \"Blue\" color asset name resolves to a conflicting NSColor symbol \"blue\". Try renaming the asset.")

    /// The "DropDownTableViewBg" asset catalog color.
    static var dropDownTableViewBg: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dropDownTableViewBg)
#else
        .init()
#endif
    }

    #warning("The \"Gray\" color asset name resolves to a conflicting NSColor symbol \"gray\". Try renaming the asset.")

    /// The "GreetingGreen" asset catalog color.
    static var greetingGreen: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greetingGreen)
#else
        .init()
#endif
    }

    /// The "GreetingLightGreen" asset catalog color.
    static var greetingLightGreen: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greetingLightGreen)
#else
        .init()
#endif
    }

    /// The "LightBlue" asset catalog color.
    static var lightBlue: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightBlue)
#else
        .init()
#endif
    }

    /// The "NavBarBgColor" asset catalog color.
    static var navBarBg: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .navBarBg)
#else
        .init()
#endif
    }

    /// The "ShadowColor" asset catalog color.
    static var shadow: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shadow)
#else
        .init()
#endif
    }

    /// The "TabBarBgColor" asset catalog color.
    static var tabBarBg: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabBarBg)
#else
        .init()
#endif
    }

    /// The "TabBarSelectedColor" asset catalog color.
    static var tabBarSelected: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabBarSelected)
#else
        .init()
#endif
    }

    /// The "WrongValue" asset catalog color.
    static var wrongValue: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wrongValue)
#else
        .init()
#endif
    }

    /// The "cover" asset catalog color.
    static var cover: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cover)
#else
        .init()
#endif
    }

    /// The "darkGreen" asset catalog color.
    static var darkGreen: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .darkGreen)
#else
        .init()
#endif
    }

    /// The "error" asset catalog color.
    static var error: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .error)
#else
        .init()
#endif
    }

    /// The "foodNotifCell" asset catalog color.
    static var foodNotifCell: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .foodNotifCell)
#else
        .init()
#endif
    }

    #warning("The \"greenColor\" color asset name resolves to a conflicting NSColor symbol \"green\". Try renaming the asset.")

    /// The "medicineNotifCell" asset catalog color.
    static var medicineNotifCell: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .medicineNotifCell)
#else
        .init()
#endif
    }

    /// The "on-surface" asset catalog color.
    static var onSurface: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .onSurface)
#else
        .init()
#endif
    }

    /// The "outline" asset catalog color.
    static var outline: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .outline)
#else
        .init()
#endif
    }

    /// The "primary" asset catalog color.
    static var primary: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .primary)
#else
        .init()
#endif
    }

    /// The "primary-30%" asset catalog color.
    static var primary30: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .primary30)
#else
        .init()
#endif
    }

    /// The "select" asset catalog color.
    static var select: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .select)
#else
        .init()
#endif
    }

    /// The "surface" asset catalog color.
    static var surface: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .surface)
#else
        .init()
#endif
    }

    /// The "textBlue" asset catalog color.
    static var textBlue: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .textBlue)
#else
        .init()
#endif
    }

    /// The "textColor" asset catalog color.
    static var text: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .text)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    #warning("The \"Blue\" color asset name resolves to a conflicting UIColor symbol \"blue\". Try renaming the asset.")

    /// The "DropDownTableViewBg" asset catalog color.
    static var dropDownTableViewBg: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .dropDownTableViewBg)
#else
        .init()
#endif
    }

    #warning("The \"Gray\" color asset name resolves to a conflicting UIColor symbol \"gray\". Try renaming the asset.")

    /// The "GreetingGreen" asset catalog color.
    static var greetingGreen: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greetingGreen)
#else
        .init()
#endif
    }

    /// The "GreetingLightGreen" asset catalog color.
    static var greetingLightGreen: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greetingLightGreen)
#else
        .init()
#endif
    }

    /// The "LightBlue" asset catalog color.
    static var lightBlue: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .lightBlue)
#else
        .init()
#endif
    }

    /// The "NavBarBgColor" asset catalog color.
    static var navBarBg: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .navBarBg)
#else
        .init()
#endif
    }

    /// The "ShadowColor" asset catalog color.
    static var shadow: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .shadow)
#else
        .init()
#endif
    }

    /// The "TabBarBgColor" asset catalog color.
    static var tabBarBg: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .tabBarBg)
#else
        .init()
#endif
    }

    /// The "TabBarSelectedColor" asset catalog color.
    static var tabBarSelected: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .tabBarSelected)
#else
        .init()
#endif
    }

    /// The "WrongValue" asset catalog color.
    static var wrongValue: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .wrongValue)
#else
        .init()
#endif
    }

    /// The "cover" asset catalog color.
    static var cover: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .cover)
#else
        .init()
#endif
    }

    /// The "darkGreen" asset catalog color.
    static var darkGreen: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .darkGreen)
#else
        .init()
#endif
    }

    /// The "error" asset catalog color.
    static var error: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .error)
#else
        .init()
#endif
    }

    /// The "foodNotifCell" asset catalog color.
    static var foodNotifCell: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .foodNotifCell)
#else
        .init()
#endif
    }

    #warning("The \"greenColor\" color asset name resolves to a conflicting UIColor symbol \"green\". Try renaming the asset.")

    /// The "medicineNotifCell" asset catalog color.
    static var medicineNotifCell: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .medicineNotifCell)
#else
        .init()
#endif
    }

    /// The "on-surface" asset catalog color.
    static var onSurface: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .onSurface)
#else
        .init()
#endif
    }

    /// The "outline" asset catalog color.
    static var outline: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .outline)
#else
        .init()
#endif
    }

    /// The "primary" asset catalog color.
    static var primary: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .primary)
#else
        .init()
#endif
    }

    /// The "primary-30%" asset catalog color.
    static var primary30: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .primary30)
#else
        .init()
#endif
    }

    /// The "select" asset catalog color.
    static var select: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .select)
#else
        .init()
#endif
    }

    /// The "surface" asset catalog color.
    static var surface: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .surface)
#else
        .init()
#endif
    }

    /// The "textBlue" asset catalog color.
    static var textBlue: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .textBlue)
#else
        .init()
#endif
    }

    /// The "textColor" asset catalog color.
    static var text: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .text)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    #warning("The \"Blue\" color asset name resolves to a conflicting Color symbol \"blue\". Try renaming the asset.")

    /// The "DropDownTableViewBg" asset catalog color.
    static var dropDownTableViewBg: SwiftUI.Color { .init(.dropDownTableViewBg) }

    #warning("The \"Gray\" color asset name resolves to a conflicting Color symbol \"gray\". Try renaming the asset.")

    /// The "GreetingGreen" asset catalog color.
    static var greetingGreen: SwiftUI.Color { .init(.greetingGreen) }

    /// The "GreetingLightGreen" asset catalog color.
    static var greetingLightGreen: SwiftUI.Color { .init(.greetingLightGreen) }

    /// The "LightBlue" asset catalog color.
    static var lightBlue: SwiftUI.Color { .init(.lightBlue) }

    /// The "NavBarBgColor" asset catalog color.
    static var navBarBg: SwiftUI.Color { .init(.navBarBg) }

    /// The "ShadowColor" asset catalog color.
    static var shadow: SwiftUI.Color { .init(.shadow) }

    /// The "TabBarBgColor" asset catalog color.
    static var tabBarBg: SwiftUI.Color { .init(.tabBarBg) }

    /// The "TabBarSelectedColor" asset catalog color.
    static var tabBarSelected: SwiftUI.Color { .init(.tabBarSelected) }

    /// The "WrongValue" asset catalog color.
    static var wrongValue: SwiftUI.Color { .init(.wrongValue) }

    /// The "cover" asset catalog color.
    static var cover: SwiftUI.Color { .init(.cover) }

    /// The "darkGreen" asset catalog color.
    static var darkGreen: SwiftUI.Color { .init(.darkGreen) }

    /// The "error" asset catalog color.
    static var error: SwiftUI.Color { .init(.error) }

    /// The "foodNotifCell" asset catalog color.
    static var foodNotifCell: SwiftUI.Color { .init(.foodNotifCell) }

    #warning("The \"greenColor\" color asset name resolves to a conflicting Color symbol \"green\". Try renaming the asset.")

    /// The "medicineNotifCell" asset catalog color.
    static var medicineNotifCell: SwiftUI.Color { .init(.medicineNotifCell) }

    /// The "on-surface" asset catalog color.
    static var onSurface: SwiftUI.Color { .init(.onSurface) }

    /// The "outline" asset catalog color.
    static var outline: SwiftUI.Color { .init(.outline) }

    #warning("The \"primary\" color asset name resolves to a conflicting Color symbol \"primary\". Try renaming the asset.")

    /// The "primary-30%" asset catalog color.
    static var primary30: SwiftUI.Color { .init(.primary30) }

    /// The "select" asset catalog color.
    static var select: SwiftUI.Color { .init(.select) }

    /// The "surface" asset catalog color.
    static var surface: SwiftUI.Color { .init(.surface) }

    /// The "textBlue" asset catalog color.
    static var textBlue: SwiftUI.Color { .init(.textBlue) }

    /// The "textColor" asset catalog color.
    static var text: SwiftUI.Color { .init(.text) }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "DropDownTableViewBg" asset catalog color.
    static var dropDownTableViewBg: SwiftUI.Color { .init(.dropDownTableViewBg) }

    /// The "GreetingGreen" asset catalog color.
    static var greetingGreen: SwiftUI.Color { .init(.greetingGreen) }

    /// The "GreetingLightGreen" asset catalog color.
    static var greetingLightGreen: SwiftUI.Color { .init(.greetingLightGreen) }

    /// The "LightBlue" asset catalog color.
    static var lightBlue: SwiftUI.Color { .init(.lightBlue) }

    /// The "NavBarBgColor" asset catalog color.
    static var navBarBg: SwiftUI.Color { .init(.navBarBg) }

    /// The "ShadowColor" asset catalog color.
    static var shadow: SwiftUI.Color { .init(.shadow) }

    /// The "TabBarBgColor" asset catalog color.
    static var tabBarBg: SwiftUI.Color { .init(.tabBarBg) }

    /// The "TabBarSelectedColor" asset catalog color.
    static var tabBarSelected: SwiftUI.Color { .init(.tabBarSelected) }

    /// The "WrongValue" asset catalog color.
    static var wrongValue: SwiftUI.Color { .init(.wrongValue) }

    /// The "cover" asset catalog color.
    static var cover: SwiftUI.Color { .init(.cover) }

    /// The "darkGreen" asset catalog color.
    static var darkGreen: SwiftUI.Color { .init(.darkGreen) }

    /// The "error" asset catalog color.
    static var error: SwiftUI.Color { .init(.error) }

    /// The "foodNotifCell" asset catalog color.
    static var foodNotifCell: SwiftUI.Color { .init(.foodNotifCell) }

    /// The "medicineNotifCell" asset catalog color.
    static var medicineNotifCell: SwiftUI.Color { .init(.medicineNotifCell) }

    /// The "on-surface" asset catalog color.
    static var onSurface: SwiftUI.Color { .init(.onSurface) }

    /// The "outline" asset catalog color.
    static var outline: SwiftUI.Color { .init(.outline) }

    /// The "primary-30%" asset catalog color.
    static var primary30: SwiftUI.Color { .init(.primary30) }

    /// The "select" asset catalog color.
    static var select: SwiftUI.Color { .init(.select) }

    /// The "surface" asset catalog color.
    static var surface: SwiftUI.Color { .init(.surface) }

    /// The "textBlue" asset catalog color.
    static var textBlue: SwiftUI.Color { .init(.textBlue) }

    /// The "textColor" asset catalog color.
    static var text: SwiftUI.Color { .init(.text) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "ClinicsIsActive" asset catalog image.
    static var clinicsIsActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clinicsIsActive)
#else
        .init()
#endif
    }

    /// The "ClinicsIsNotActive" asset catalog image.
    static var clinicsIsNotActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clinicsIsNotActive)
#else
        .init()
#endif
    }

    /// The "CllinicProfileTest" asset catalog image.
    static var cllinicProfileTest: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cllinicProfileTest)
#else
        .init()
#endif
    }

    /// The "DoctorProfileTest" asset catalog image.
    static var doctorProfileTest: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .doctorProfileTest)
#else
        .init()
#endif
    }

    /// The "Greeting" asset catalog image.
    static var greeting: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greeting)
#else
        .init()
#endif
    }

    /// The "HomeIsActive" asset catalog image.
    static var homeIsActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .homeIsActive)
#else
        .init()
#endif
    }

    /// The "HomeIsNotActive" asset catalog image.
    static var homeIsNotActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .homeIsNotActive)
#else
        .init()
#endif
    }

    /// The "PetIsActive" asset catalog image.
    static var petIsActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .petIsActive)
#else
        .init()
#endif
    }

    /// The "PetIsNotActive" asset catalog image.
    static var petIsNotActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .petIsNotActive)
#else
        .init()
#endif
    }

    /// The "PetTracker" asset catalog image.
    static var petTracker: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .petTracker)
#else
        .init()
#endif
    }

    /// The "WalkIsActive" asset catalog image.
    static var walkIsActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .walkIsActive)
#else
        .init()
#endif
    }

    /// The "WalkIsNotActive" asset catalog image.
    static var walkIsNotActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .walkIsNotActive)
#else
        .init()
#endif
    }

    /// The "add" asset catalog image.
    static var add: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .add)
#else
        .init()
#endif
    }

    /// The "anyDoctor" asset catalog image.
    static var anyDoctor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .anyDoctor)
#else
        .init()
#endif
    }

    /// The "approvedAppointment" asset catalog image.
    static var approvedAppointment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .approvedAppointment)
#else
        .init()
#endif
    }

    /// The "avatar" asset catalog image.
    static var avatar: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .avatar)
#else
        .init()
#endif
    }

    /// The "buttonAdd" asset catalog image.
    static var buttonAdd: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .buttonAdd)
#else
        .init()
#endif
    }

    /// The "chat" asset catalog image.
    static var chat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chat)
#else
        .init()
#endif
    }

    /// The "clinic" asset catalog image.
    static var clinic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clinic)
#else
        .init()
#endif
    }

    /// The "clinicAdress" asset catalog image.
    static var clinicAdress: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clinicAdress)
#else
        .init()
#endif
    }

    /// The "cross" asset catalog image.
    static var cross: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cross)
#else
        .init()
#endif
    }

    /// The "declinedAppointment" asset catalog image.
    static var declinedAppointment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .declinedAppointment)
#else
        .init()
#endif
    }

    /// The "delete" asset catalog image.
    static var delete: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .delete)
#else
        .init()
#endif
    }

    /// The "deletePlace" asset catalog image.
    static var deletePlace: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .deletePlace)
#else
        .init()
#endif
    }

    /// The "dislike" asset catalog image.
    static var dislike: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dislike)
#else
        .init()
#endif
    }

    /// The "dislikeFilled" asset catalog image.
    static var dislikeFilled: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dislikeFilled)
#else
        .init()
#endif
    }

    /// The "doctor" asset catalog image.
    static var doctor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .doctor)
#else
        .init()
#endif
    }

    /// The "dogBowl" asset catalog image.
    static var dogBowl: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dogBowl)
#else
        .init()
#endif
    }

    /// The "dogMedicine" asset catalog image.
    static var dogMedicine: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dogMedicine)
#else
        .init()
#endif
    }

    /// The "email" asset catalog image.
    static var email: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .email)
#else
        .init()
#endif
    }

    /// The "fav" asset catalog image.
    static var fav: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fav)
#else
        .init()
#endif
    }

    /// The "favorite" asset catalog image.
    static var favorite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .favorite)
#else
        .init()
#endif
    }

    /// The "female" asset catalog image.
    static var female: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .female)
#else
        .init()
#endif
    }

    /// The "femaleSeg" asset catalog image.
    static var femaleSeg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .femaleSeg)
#else
        .init()
#endif
    }

    /// The "filledStar" asset catalog image.
    static var filledStar: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .filledStar)
#else
        .init()
#endif
    }

    /// The "kit" asset catalog image.
    static var kit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .kit)
#else
        .init()
#endif
    }

    /// The "like" asset catalog image.
    static var like: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .like)
#else
        .init()
#endif
    }

    /// The "likeFilled" asset catalog image.
    static var likeFilled: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .likeFilled)
#else
        .init()
#endif
    }

    /// The "line" asset catalog image.
    static var line: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .line)
#else
        .init()
#endif
    }

    /// The "logout" asset catalog image.
    static var logout: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logout)
#else
        .init()
#endif
    }

    /// The "male" asset catalog image.
    static var male: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .male)
#else
        .init()
#endif
    }

    /// The "maleSeg" asset catalog image.
    static var maleSeg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .maleSeg)
#else
        .init()
#endif
    }

    /// The "map" asset catalog image.
    static var map: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .map)
#else
        .init()
#endif
    }

    /// The "markerDangerous" asset catalog image.
    static var markerDangerous: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .markerDangerous)
#else
        .init()
#endif
    }

    /// The "markerPlayground" asset catalog image.
    static var markerPlayground: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .markerPlayground)
#else
        .init()
#endif
    }

    /// The "markerWalks" asset catalog image.
    static var markerWalks: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .markerWalks)
#else
        .init()
#endif
    }

    /// The "medicalWorker" asset catalog image.
    static var medicalWorker: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .medicalWorker)
#else
        .init()
#endif
    }

    /// The "more" asset catalog image.
    static var more: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .more)
#else
        .init()
#endif
    }

    /// The "notification" asset catalog image.
    static var notification: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .notification)
#else
        .init()
#endif
    }

    /// The "personIsActive" asset catalog image.
    static var personIsActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .personIsActive)
#else
        .init()
#endif
    }

    /// The "petDetail" asset catalog image.
    static var petDetail: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .petDetail)
#else
        .init()
#endif
    }

    /// The "profile" asset catalog image.
    static var profile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profile)
#else
        .init()
#endif
    }

    /// The "share" asset catalog image.
    static var share: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .share)
#else
        .init()
#endif
    }

    /// The "sideArrow" asset catalog image.
    static var sideArrow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sideArrow)
#else
        .init()
#endif
    }

    /// The "star" asset catalog image.
    static var star: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .star)
#else
        .init()
#endif
    }

    /// The "tool" asset catalog image.
    static var tool: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tool)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "ClinicsIsActive" asset catalog image.
    static var clinicsIsActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clinicsIsActive)
#else
        .init()
#endif
    }

    /// The "ClinicsIsNotActive" asset catalog image.
    static var clinicsIsNotActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clinicsIsNotActive)
#else
        .init()
#endif
    }

    /// The "CllinicProfileTest" asset catalog image.
    static var cllinicProfileTest: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cllinicProfileTest)
#else
        .init()
#endif
    }

    /// The "DoctorProfileTest" asset catalog image.
    static var doctorProfileTest: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .doctorProfileTest)
#else
        .init()
#endif
    }

    /// The "Greeting" asset catalog image.
    static var greeting: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .greeting)
#else
        .init()
#endif
    }

    /// The "HomeIsActive" asset catalog image.
    static var homeIsActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .homeIsActive)
#else
        .init()
#endif
    }

    /// The "HomeIsNotActive" asset catalog image.
    static var homeIsNotActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .homeIsNotActive)
#else
        .init()
#endif
    }

    /// The "PetIsActive" asset catalog image.
    static var petIsActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .petIsActive)
#else
        .init()
#endif
    }

    /// The "PetIsNotActive" asset catalog image.
    static var petIsNotActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .petIsNotActive)
#else
        .init()
#endif
    }

    /// The "PetTracker" asset catalog image.
    static var petTracker: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .petTracker)
#else
        .init()
#endif
    }

    /// The "WalkIsActive" asset catalog image.
    static var walkIsActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .walkIsActive)
#else
        .init()
#endif
    }

    /// The "WalkIsNotActive" asset catalog image.
    static var walkIsNotActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .walkIsNotActive)
#else
        .init()
#endif
    }

    #warning("The \"add\" image asset name resolves to a conflicting UIImage symbol \"add\". Try renaming the asset.")

    /// The "anyDoctor" asset catalog image.
    static var anyDoctor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .anyDoctor)
#else
        .init()
#endif
    }

    /// The "approvedAppointment" asset catalog image.
    static var approvedAppointment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .approvedAppointment)
#else
        .init()
#endif
    }

    /// The "avatar" asset catalog image.
    static var avatar: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .avatar)
#else
        .init()
#endif
    }

    /// The "buttonAdd" asset catalog image.
    static var buttonAdd: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .buttonAdd)
#else
        .init()
#endif
    }

    /// The "chat" asset catalog image.
    static var chat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chat)
#else
        .init()
#endif
    }

    /// The "clinic" asset catalog image.
    static var clinic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clinic)
#else
        .init()
#endif
    }

    /// The "clinicAdress" asset catalog image.
    static var clinicAdress: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clinicAdress)
#else
        .init()
#endif
    }

    /// The "cross" asset catalog image.
    static var cross: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cross)
#else
        .init()
#endif
    }

    /// The "declinedAppointment" asset catalog image.
    static var declinedAppointment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .declinedAppointment)
#else
        .init()
#endif
    }

    /// The "delete" asset catalog image.
    static var delete: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .delete)
#else
        .init()
#endif
    }

    /// The "deletePlace" asset catalog image.
    static var deletePlace: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .deletePlace)
#else
        .init()
#endif
    }

    /// The "dislike" asset catalog image.
    static var dislike: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dislike)
#else
        .init()
#endif
    }

    /// The "dislikeFilled" asset catalog image.
    static var dislikeFilled: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dislikeFilled)
#else
        .init()
#endif
    }

    /// The "doctor" asset catalog image.
    static var doctor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .doctor)
#else
        .init()
#endif
    }

    /// The "dogBowl" asset catalog image.
    static var dogBowl: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dogBowl)
#else
        .init()
#endif
    }

    /// The "dogMedicine" asset catalog image.
    static var dogMedicine: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dogMedicine)
#else
        .init()
#endif
    }

    /// The "email" asset catalog image.
    static var email: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .email)
#else
        .init()
#endif
    }

    /// The "fav" asset catalog image.
    static var fav: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fav)
#else
        .init()
#endif
    }

    /// The "favorite" asset catalog image.
    static var favorite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .favorite)
#else
        .init()
#endif
    }

    /// The "female" asset catalog image.
    static var female: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .female)
#else
        .init()
#endif
    }

    /// The "femaleSeg" asset catalog image.
    static var femaleSeg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .femaleSeg)
#else
        .init()
#endif
    }

    /// The "filledStar" asset catalog image.
    static var filledStar: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .filledStar)
#else
        .init()
#endif
    }

    /// The "kit" asset catalog image.
    static var kit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .kit)
#else
        .init()
#endif
    }

    /// The "like" asset catalog image.
    static var like: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .like)
#else
        .init()
#endif
    }

    /// The "likeFilled" asset catalog image.
    static var likeFilled: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .likeFilled)
#else
        .init()
#endif
    }

    /// The "line" asset catalog image.
    static var line: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .line)
#else
        .init()
#endif
    }

    /// The "logout" asset catalog image.
    static var logout: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logout)
#else
        .init()
#endif
    }

    /// The "male" asset catalog image.
    static var male: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .male)
#else
        .init()
#endif
    }

    /// The "maleSeg" asset catalog image.
    static var maleSeg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .maleSeg)
#else
        .init()
#endif
    }

    /// The "map" asset catalog image.
    static var map: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .map)
#else
        .init()
#endif
    }

    /// The "markerDangerous" asset catalog image.
    static var markerDangerous: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .markerDangerous)
#else
        .init()
#endif
    }

    /// The "markerPlayground" asset catalog image.
    static var markerPlayground: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .markerPlayground)
#else
        .init()
#endif
    }

    /// The "markerWalks" asset catalog image.
    static var markerWalks: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .markerWalks)
#else
        .init()
#endif
    }

    /// The "medicalWorker" asset catalog image.
    static var medicalWorker: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .medicalWorker)
#else
        .init()
#endif
    }

    /// The "more" asset catalog image.
    static var more: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .more)
#else
        .init()
#endif
    }

    /// The "notification" asset catalog image.
    static var notification: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .notification)
#else
        .init()
#endif
    }

    /// The "personIsActive" asset catalog image.
    static var personIsActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .personIsActive)
#else
        .init()
#endif
    }

    /// The "petDetail" asset catalog image.
    static var petDetail: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .petDetail)
#else
        .init()
#endif
    }

    /// The "profile" asset catalog image.
    static var profile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profile)
#else
        .init()
#endif
    }

    /// The "share" asset catalog image.
    static var share: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .share)
#else
        .init()
#endif
    }

    /// The "sideArrow" asset catalog image.
    static var sideArrow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sideArrow)
#else
        .init()
#endif
    }

    /// The "star" asset catalog image.
    static var star: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .star)
#else
        .init()
#endif
    }

    /// The "tool" asset catalog image.
    static var tool: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tool)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif