//
//  Constants.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation

// Storyboards
struct Storyboards {
    static let main = "Main"
    static let home = "Home"
}

// Cells
struct Cells {
    static let category = "Category"
}

// View Controllers
struct ViewControllers {
    static let homeVC   = "HomeVC"
}

// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api/"
    static let mainCategories = "main_categories"
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
