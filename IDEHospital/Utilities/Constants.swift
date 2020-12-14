//
//  Constants.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation

//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


// Storyboards
struct Storyboards {
    static let search = "Search"
    static let main = "Main"
}

// View Controllers
struct ViewControllers {
    static let searchVC = "SearchVC"
    static let favoritesVC = "FavoritesVC"
    static let scheduleVC = "ScheduleVC"
}

// TabBar Controllers
struct TabBarControllers {
    static let tabBarController = "TabBarControllerTC"
}

// Urls
struct URLs {
     static let base = "http://ide-hospital.ideaeg.co/api/"
     static let getCategories = "http://ide-hospital.ideaeg.co/api/main_categories/"
   
}

// Header Keys
struct HeaderKeys {

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
