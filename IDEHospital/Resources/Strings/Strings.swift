// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Choose City
  internal static let chooseCity = L10n.tr("Localizable", "chooseCity")
  /// Choose Companies
  internal static let chooseCompanies = L10n.tr("Localizable", "chooseCompanies")
  /// Choose Region
  internal static let chooseRegion = L10n.tr("Localizable", "chooseRegion")
  /// Choose Services
  internal static let chooseServices = L10n.tr("Localizable", "chooseServices")
  /// Choose Specialists
  internal static let chooseSpecialists = L10n.tr("Localizable", "chooseSpecialists")
  /// Data Not Found
  internal static let dataNotFound = L10n.tr("Localizable", "dataNotFound")
  /// DoctorName
  internal static let doctorName = L10n.tr("Localizable", "DoctorName")
  /// done
  internal static let done = L10n.tr("Localizable", "done")
  /// Find a doctor
  internal static let findDoctor = L10n.tr("Localizable", "findDoctor")
  /// IDEA EG HOSPITAL THE BEST CHOICE
  internal static let homeDescription = L10n.tr("Localizable", "homeDescription")
  /// IDEA EG HOSPITAL THE BEST CHOICE
  internal static let ideaEgHospitalTheBestChoice = L10n.tr("Localizable", "ideaEgHospitalTheBestChoice")
  /// IDEA EG HOSPITAL
  internal static let ideaHospital = L10n.tr("Localizable", "ideaHospital")
  /// My Favorites
  internal static let myFavorites = L10n.tr("Localizable", "myFavorites")
  /// Service Search
  internal static let serviceSearch = L10n.tr("Localizable", "serviceSearch")
  /// Sorry
  internal static let sorry = L10n.tr("Localizable", "sorry")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
