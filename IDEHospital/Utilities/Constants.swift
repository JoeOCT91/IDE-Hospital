//
//  Constants.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation

// Storyboards
struct Storyboards {
    
    static let search = "Search"
    static let main = "Main"
    static let home = "Home"
    static let nurse = "Nurse"
    static let favorites = "Favorites"
    static let appointments = "Appointments"
    static let sideMenu = "SideMenu"
    static let authentication = "Authentication"
    static let contactUs = "ContactUs"
    static let staticContent = "StaticContent"
    static let doctorProfile = "DoctorProfile"
    static let rating = "Rating"
    static let editProfile = "EditProfile"
}

// Cells
struct Cells {
    static let category = "Category"
    static let favorites = "Favorites"
    static let appointment = "Appointment"
    static let sideMenu = "SideMenu"
    static let doctorReviewCell = "DoctorReviewCell"
    static let appointmentDateCell = "appointmentDateCell"
}

// View Controllers
struct ViewControllers {

    static let homeVC   = "HomeVC"
    static let searchVC = "SearchVC"
    static let searchResult = "SearchResultVC"
    static let favoritesVC = "FavoritesVC"
    static let scheduleVC = "ScheduleVC"
    static let tabBarVC = "TabBarVC"
    static let nurseVC = "NurseVC"
    static let searchResultCell = "SearchResultCell"
    static let appointmentsVC = "AppointmentsVC"
    static let sideMenu = "SideMenuVC"
    static let termsAndConditionsVC = "TermsAndConditionsVC"
    static let resetPasswordVC = "ResetPasswordVC"
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let contactUsVC = "ContactUsVC"
    static let aboutVC = "AboutVC"
    static let doctorProfileVC = "DoctorProfileVC"
    static let ratingVC = "RatingVC"
    static let bookWithDoctorVC = "BookWithDoctorVC"
    static let editProfile = "EditProfileVC"
    static let unRegisterdBookingVC = "UnRegisteredBookingVC"
}

// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api/"
    static let mainCategories = "main_categories"
    static let getCategories = "main_categories/"
    static let nurseRequest = "nursing_requests"
    static let favorites = "favorites/doctors"
    static let appoitments = "user_appointments"
    static let forgetPassword = "forget_password"
    static let register = "register"
    static let login = "login"
    static let logout = "logout"
    static let termsAndConditions = "terms_and_conditions"
    static let contactUs = "contact_us_requests"
    static let about = "about_us"
    static let doctors = "doctors/"
    static let ratingDoctor = "doctors"
    static let user = "user"
    static let bookWithRegister = "user_appointments/with_register"
    static let bookWithLogin = "user_appointments/with_login"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
    static let accept = "accept"

}
// Authorization Key
struct Authorization {
    static var authValue = (UserDefaultsManager.shared().token ?? "")
}

// Parameters Keys
struct ParameterKeys {
    static let name = "name"
    static let email = "email"
    static let mobile = "mobile"
    static let message = "message"
    static let main_category_id = "main_category_id"
    static var userToken = "userToken"
    static var specialty_id = "specialty_id"
    static var city_id = "city_id"
    static var region_id = "region_id"
    static var company_id = "company_id"
    static var order_by = "order_by"
    static var page = "page"
    static var per_page = "per_page"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}

// AlertMeassages
struct AlertMessages {
    static let selectCityBeforeRegionFirst = "You have to select a city first then select it's Region"
    static let appointmentCancel = "Are you sure that you want to cancel this appointment"
}
