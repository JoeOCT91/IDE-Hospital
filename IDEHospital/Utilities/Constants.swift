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
}

// Cells
struct Cells {
    static let category = "Category"
}

// View Controllers
struct ViewControllers {
    
    static let homeVC   = "HomeVC"
    static let searchVC = "SearchVC"
    static let favoritesVC = "FavoritesVC"
    static let scheduleVC = "ScheduleVC"
    static let tabBarVC = "TabBarVC"
    static let nurseVC = "NurseVC"
}


// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api/"
    static let mainCategories = "main_categories"
    static let getCategories = "main_categories/"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
}
// Authorization Key
struct Authorization {
    static var authValue = (UserDefaultsManager.shared().token ?? "")
}

// Parameters Keys
struct ParameterKeys {
    
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}

// AlertMeassages
struct AlertMessages {
    static let selectCityBeforeRegionFirst = "You have to select a city first then select it's Region"
}
