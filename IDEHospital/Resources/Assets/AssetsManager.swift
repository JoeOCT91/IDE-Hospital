// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let alertConfirmation = ImageAsset(name: "AlertConfirmation")
  internal static let backgroundImage = ImageAsset(name: "Background_Image")
  internal static let bioIcon = ImageAsset(name: "BioIcon")
  internal static let blackBackground = ImageAsset(name: "Black-Background")
  internal static let buttonBar = ImageAsset(name: "Button Bar")
  internal static let component411 = ImageAsset(name: "Component 41 – 1")
  internal static let dismiss = ImageAsset(name: "Dismiss")
  internal static let addressIcon = ImageAsset(name: "AddressIcon")
  internal static let companiesIcon = ImageAsset(name: "CompaniesIcon")
  internal static let feesIcon = ImageAsset(name: "FeesIcon")
  internal static let onMapIcon = ImageAsset(name: "OnMapIcon")
  internal static let secondBio = ImageAsset(name: "SecondBio")
  internal static let specialityIcon = ImageAsset(name: "SpecialityIcon")
  internal static let timeIcon = ImageAsset(name: "TimeIcon")
  internal static let dateBack = ImageAsset(name: "dateBack")
  internal static let dateNext = ImageAsset(name: "dateNext")
  internal static let emailIcon = ImageAsset(name: "Email_Icon")
  internal static let emptyCheckbox = ImageAsset(name: "Empty-Checkbox")
  internal static let filledCheckbox = ImageAsset(name: "Filled-Checkbox")
  internal static let greyButtonBar = ImageAsset(name: "Grey_Button_Bar")
  internal static let halfCircle = ImageAsset(name: "Half_Circle")
  internal static let heart = ImageAsset(name: "Heart")
  internal static let locationIcon = ImageAsset(name: "Location_Icon")
  internal static let nameIcon = ImageAsset(name: "Name_Icon")
  internal static let passwordIcon = ImageAsset(name: "Password_Icon")
  internal static let path29 = ImageAsset(name: "Path 29")
  internal static let phoneIcon = ImageAsset(name: "Phone_Icon")
  internal static let shild = ImageAsset(name: "Shild")
  internal static let sideMenuAbout = ImageAsset(name: "SideMenuAbout")
  internal static let sideMenuBack = ImageAsset(name: "SideMenuBack")
  internal static let sideMenuCalendar = ImageAsset(name: "SideMenuCalendar")
  internal static let sideMenuContact = ImageAsset(name: "SideMenuContact")
  internal static let sideMenuHeart = ImageAsset(name: "SideMenuHeart")
  internal static let sideMenuLogin = ImageAsset(name: "SideMenuLogin")
  internal static let sideMenuShare = ImageAsset(name: "SideMenuShare")
  internal static let sideMenuSheet = ImageAsset(name: "SideMenuSheet")
  internal static let sideMenuUser = ImageAsset(name: "SideMenuUser")
  internal static let whiteCloseButton = ImageAsset(name: "White-Close-Button")
  internal static let alertError = ImageAsset(name: "alertError")
  internal static let arrow = ImageAsset(name: "arrow")
  internal static let back2 = ImageAsset(name: "back-2")
  internal static let calendar3 = ImageAsset(name: "calendar-3")
  internal static let clock = ImageAsset(name: "clock")
  internal static let deleteButton = ImageAsset(name: "deleteButton")
  internal static let doctor = ImageAsset(name: "doctor")
  internal static let emptyStar = ImageAsset(name: "empty star")
  internal static let emptyHeart = ImageAsset(name: "empty_heart")
  internal static let filledStar = ImageAsset(name: "filled Star")
  internal static let joheart = ImageAsset(name: "joheart")
  internal static let logo = ImageAsset(name: "logo")
  internal static let money = ImageAsset(name: "money")
  internal static let money3 = ImageAsset(name: "money3")
  internal static let pin = ImageAsset(name: "pin")
  internal static let placeholderImage = ImageAsset(name: "placeholder-image")
  internal static let rateStar = ImageAsset(name: "rateStar")
  internal static let redHeart = ImageAsset(name: "red_heart")
  internal static let settings = ImageAsset(name: "settings")
  internal static let splashBackGround = ImageAsset(name: "splashBackGround")
  internal static let whiteArrow = ImageAsset(name: "white_arrow")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
