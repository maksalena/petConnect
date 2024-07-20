// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum PetConnectAsset {
  public static let accentColor = PetConnectColors(name: "AccentColor")
  public static let greeting = PetConnectImages(name: "Greeting")
  public static let greetingGreen = PetConnectColors(name: "GreetingGreen")
  public static let greetingLightGreen = PetConnectColors(name: "GreetingLightGreen")
  public static let wrongValue = PetConnectColors(name: "WrongValue")
  public static let shadowColor = PetConnectColors(name: "ShadowColor")
  public static let cllinicProfileTest = PetConnectImages(name: "CllinicProfileTest")
  public static let doctorProfileTest = PetConnectImages(name: "DoctorProfileTest")
  public static let anyDoctor = PetConnectImages(name: "anyDoctor")
  public static let approvedAppointment = PetConnectImages(name: "approvedAppointment")
  public static let chat = PetConnectImages(name: "chat")
  public static let clinic = PetConnectImages(name: "clinic")
  public static let clinicAdress = PetConnectImages(name: "clinicAdress")
  public static let cover = PetConnectColors(name: "cover")
  public static let declinedAppointment = PetConnectImages(name: "declinedAppointment")
  public static let doctor = PetConnectImages(name: "doctor")
  public static let filledStar = PetConnectImages(name: "filledStar")
  public static let kit = PetConnectImages(name: "kit")
  public static let medicalWorker = PetConnectImages(name: "medicalWorker")
  public static let sideArrow = PetConnectImages(name: "sideArrow")
  public static let star = PetConnectImages(name: "star")
  public static let surface = PetConnectColors(name: "surface")
  public static let tool = PetConnectImages(name: "tool")
  public static let dropDownTableViewBg = PetConnectColors(name: "DropDownTableViewBg")
  public static let petTracker = PetConnectImages(name: "PetTracker")
  public static let cross = PetConnectImages(name: "cross")
  public static let dogBowl = PetConnectImages(name: "dogBowl")
  public static let dogMedicine = PetConnectImages(name: "dogMedicine")
  public static let foodNotifCell = PetConnectColors(name: "foodNotifCell")
  public static let medicineNotifCell = PetConnectColors(name: "medicineNotifCell")
  public static let deletePlace = PetConnectImages(name: "deletePlace")
  public static let dislike = PetConnectImages(name: "dislike")
  public static let dislikeFilled = PetConnectImages(name: "dislikeFilled")
  public static let fav = PetConnectImages(name: "fav")
  public static let favorite = PetConnectImages(name: "favorite")
  public static let like = PetConnectImages(name: "like")
  public static let likeFilled = PetConnectImages(name: "likeFilled")
  public static let markerDangerous = PetConnectImages(name: "markerDangerous")
  public static let markerPlayground = PetConnectImages(name: "markerPlayground")
  public static let markerWalks = PetConnectImages(name: "markerWalks")
  public static let more = PetConnectImages(name: "more")
  public static let share = PetConnectImages(name: "share")
  public static let navBarBgColor = PetConnectColors(name: "NavBarBgColor")
  public static let avatar = PetConnectImages(name: "avatar")
  public static let delete = PetConnectImages(name: "delete")
  public static let email = PetConnectImages(name: "email")
  public static let logout = PetConnectImages(name: "logout")
  public static let notification = PetConnectImages(name: "notification")
  public static let profile = PetConnectImages(name: "profile")
  public static let blue = PetConnectColors(name: "Blue")
  public static let gray = PetConnectColors(name: "Gray")
  public static let lightBlue = PetConnectColors(name: "LightBlue")
  public static let map = PetConnectImages(name: "map")
  public static let textBlue = PetConnectColors(name: "textBlue")
  public static let error = PetConnectColors(name: "error")
  public static let onSurface = PetConnectColors(name: "on-surface")
  public static let outline = PetConnectColors(name: "outline")
  public static let add = PetConnectImages(name: "add")
  public static let buttonAdd = PetConnectImages(name: "buttonAdd")
  public static let darkGreen = PetConnectColors(name: "darkGreen")
  public static let female = PetConnectImages(name: "female")
  public static let femaleSeg = PetConnectImages(name: "femaleSeg")
  public static let male = PetConnectImages(name: "male")
  public static let maleSeg = PetConnectImages(name: "maleSeg")
  public static let greenColor = PetConnectColors(name: "greenColor")
  public static let line = PetConnectImages(name: "line")
  public static let petDetail = PetConnectImages(name: "petDetail")
  public static let select = PetConnectColors(name: "select")
  public static let textColor = PetConnectColors(name: "textColor")
  public static let primary30 = PetConnectColors(name: "primary-30%")
  public static let primary = PetConnectColors(name: "primary")
  public static let clinicsIsActive = PetConnectImages(name: "ClinicsIsActive")
  public static let clinicsIsNotActive = PetConnectImages(name: "ClinicsIsNotActive")
  public static let homeIsActive = PetConnectImages(name: "HomeIsActive")
  public static let homeIsNotActive = PetConnectImages(name: "HomeIsNotActive")
  public static let petIsActive = PetConnectImages(name: "PetIsActive")
  public static let petIsNotActive = PetConnectImages(name: "PetIsNotActive")
  public static let personIsActive = PetConnectImages(name: "personIsActive")
  public static let tabBarBgColor = PetConnectColors(name: "TabBarBgColor")
  public static let tabBarSelectedColor = PetConnectColors(name: "TabBarSelectedColor")
  public static let walkIsActive = PetConnectImages(name: "WalkIsActive")
  public static let walkIsNotActive = PetConnectImages(name: "WalkIsNotActive")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class PetConnectColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension PetConnectColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: PetConnectColors) {
    let bundle = PetConnectResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: PetConnectColors) {
    let bundle = PetConnectResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct PetConnectImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = PetConnectResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension PetConnectImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the PetConnectImages.image property")
  convenience init?(asset: PetConnectImages) {
    #if os(iOS) || os(tvOS)
    let bundle = PetConnectResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: PetConnectImages) {
    let bundle = PetConnectResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: PetConnectImages, label: Text) {
    let bundle = PetConnectResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: PetConnectImages) {
    let bundle = PetConnectResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
