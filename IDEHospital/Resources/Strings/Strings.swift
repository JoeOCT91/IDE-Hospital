// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// SearchResultTableViewCell
  internal static let cellIdentifire = L10n.tr("Localizable", "cellIdentifire")
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
  /// Doctor Name
  internal static let doctorName = L10n.tr("Localizable", "DoctorName")
  /// done
  internal static let done = L10n.tr("Localizable", "done")
  ///  LE
  internal static let egyptionPound = L10n.tr("Localizable", "egyptionPound")
  /// Your Email
  internal static let emailTextFieldPlaceholder = L10n.tr("Localizable", "emailTextFieldPlaceholder")
  /// Enter Details
  internal static let enterDetails = L10n.tr("Localizable", "enterDetails")
  /// Examination Fees: 
  internal static let examinationFess = L10n.tr("Localizable", "examinationFess")
  /// Favorite
  internal static let favorite = L10n.tr("Localizable", "favorite")
  /// Fees
  internal static let fees = L10n.tr("Localizable", "fees")
  /// Find a doctor
  internal static let findDoctor = L10n.tr("Localizable", "findDoctor")
  /// IDEA EG HOSPITAL THE BEST CHOICE
  internal static let homeDescription = L10n.tr("Localizable", "homeDescription")
  /// Home Nurse
  internal static let homeNurse = L10n.tr("Localizable", "homeNurse")
  /// IDEA EG HOSPITAL THE BEST CHOICE
  internal static let ideaEgHospitalTheBestChoice = L10n.tr("Localizable", "ideaEgHospitalTheBestChoice")
  /// IDEA EG HOSPITAL
  internal static let ideaHospital = L10n.tr("Localizable", "ideaHospital")
  /// Invalid E-mail Format
  internal static let invalidEMailFormat = L10n.tr("Localizable", "invalidE-mailFormat")
  ///  minutes
  internal static let minutes = L10n.tr("Localizable", "minutes")
  /// My Appointments
  internal static let myAppointment = L10n.tr("Localizable", "myAppointment")
  /// My Favorites
  internal static let myFavorites = L10n.tr("Localizable", "myFavorites")
  /// Your Name
  internal static let nameTextFieldPlaceholder = L10n.tr("Localizable", "nameTextFieldPlaceholder")
  /// No Search Result Found
  internal static let noSearchResult = L10n.tr("Localizable", "noSearchResult")
  /// Your Request has been Sent Successfully
  internal static let nurseSuccessRequestMessage = L10n.tr("Localizable", "nurseSuccessRequestMessage")
  /// If you would like further information about how we can help you and your health it would be great to hear from you
  internal static let nurseVcLabel = L10n.tr("Localizable", "nurseVcLabel")
  /// Mobile Number
  internal static let phoneTextFieldPlaceholder = L10n.tr("Localizable", "phoneTextFieldPlaceholder")
  /// Details Field is Empty, Please Write your Details
  internal static let pleaseEnterDetails = L10n.tr("Localizable", "pleaseEnterDetails")
  /// Email Field is Empty, Please Re-Enter your Email
  internal static let pleaseEnterEmail = L10n.tr("Localizable", "pleaseEnterEmail")
  /// Name Field is Empty, Please Re-Enter your Name
  internal static let pleaseEnterName = L10n.tr("Localizable", "pleaseEnterName")
  /// Phone Number Field is Empty, Please Re-Enter your Phone Number
  internal static let pleaseEnterPhoneNumber = L10n.tr("Localizable", "pleaseEnterPhoneNumber")
  /// Rating
  internal static let rating = L10n.tr("Localizable", "rating")
  ///  Review
  internal static let review = L10n.tr("Localizable", "review")
  /// The Entered Number Doesn't Start with 010,011,012 or 015 with Max 11 Numbers at All
  internal static let rightPhoneNumberFormatDescription = L10n.tr("Localizable", "rightPhoneNumberFormatDescription")
  /// Schedule
  internal static let schedule = L10n.tr("Localizable", "schedule")
  /// Search
  internal static let search = L10n.tr("Localizable", "search")
  /// Search Result
  internal static let searchResult = L10n.tr("Localizable", "searchResult")
  /// Send Request
  internal static let sendRequest = L10n.tr("Localizable", "sendRequest")
  /// Service Search
  internal static let serviceSearch = L10n.tr("Localizable", "serviceSearch")
  /// About Us
  internal static let sideMenuAboutUs = L10n.tr("Localizable", "sideMenuAboutUs ")
  /// Booked Appointments
  internal static let sideMenuBookedAppointments = L10n.tr("Localizable", "sideMenuBookedAppointments")
  /// Contact Us
  internal static let sideMenuContactUs = L10n.tr("Localizable", "sideMenuContactUs")
  /// Edit Profile
  internal static let sideMenuEditProfile = L10n.tr("Localizable", "sideMenuEditProfile")
  /// Favourites
  internal static let sideMenuFavourites = L10n.tr("Localizable", "sideMenuFavourites")
  /// Logouts
  internal static let sideMenuLogouts = L10n.tr("Localizable", "sideMenuLogouts")
  /// Share
  internal static let sideMenuShare = L10n.tr("Localizable", "sideMenuShare")
  /// Terms & Conditions
  internal static let sideMenuTermsConditions = L10n.tr("Localizable", "sideMenuTerms&Conditions")
  /// Sorry
  internal static let sorry = L10n.tr("Localizable", "sorry")
  /// Sort By
  internal static let sortBy = L10n.tr("Localizable", "sortBy")
  /// Successful Request
  internal static let successfulRequest = L10n.tr("Localizable", "successfulRequest")
  /// Wating Time: 
  internal static let watingTime = L10n.tr("Localizable", "watingTime")
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
