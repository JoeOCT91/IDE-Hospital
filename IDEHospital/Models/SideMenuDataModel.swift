//
//  SideMenuDataModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import Foundation

struct SideMenuItem {
    var title: String
    var image: String
}

struct SidemenuItems {
    
    static var shared = SidemenuItems()
    
    private init(){}
    
    enum SideMenuErrors: String, Error {
        case outOfRange = "Index is Out of Range"
        case isEmpty = "There is no data to be showen"
    }
    
    private var mainArr = [
        SideMenuItem(title: L10n.sideMenuLogin, image: Asset.sideMenuLogin.name),
        SideMenuItem(title: L10n.sideMenuAboutUs, image: Asset.sideMenuAbout.name),
        SideMenuItem(title: L10n.sideMenuContactUs, image: Asset.sideMenuContact.name),
        SideMenuItem(title: L10n.sideMenuShare, image: Asset.sideMenuShare.name),
        SideMenuItem(title: L10n.sideMenuTermsConditions, image: Asset.sideMenuSheet.name)
    ]
    
    private var authArr = [
        SideMenuItem(title: L10n.sideMenuEditProfile, image: Asset.sideMenuUser.name),
        SideMenuItem(title: L10n.sideMenuFavourites, image: Asset.sideMenuHeart.name),
        SideMenuItem(title: L10n.sideMenuBookedAppointments, image: Asset.sideMenuCalendar.name),
        SideMenuItem(title: L10n.sideMenuAboutUs, image: Asset.sideMenuAbout.name),
        SideMenuItem(title: L10n.sideMenuContactUs, image: Asset.sideMenuContact.name),
        SideMenuItem(title: L10n.sideMenuShare, image: Asset.sideMenuShare.name),
        SideMenuItem(title: L10n.sideMenuTermsConditions, image: Asset.sideMenuSheet.name),
        SideMenuItem(title: L10n.sideMenuLogouts, image: Asset.sideMenuLogin.name)
    ]
    
    func getMenuItem(index: Int) throws -> SideMenuItem {
        
        if UserDefaultsManager.shared().token == nil {
            if mainArr.isEmpty { throw SideMenuErrors.isEmpty}
            if mainArr.count < index { throw SideMenuErrors.outOfRange }
            return mainArr[index]
        } else {
            if authArr.isEmpty { throw SideMenuErrors.isEmpty}
            if authArr.count < index { throw SideMenuErrors.outOfRange }
            return authArr[index]
        }
    }
    
    func getCount() -> Int {
        if UserDefaultsManager.shared().token == nil {
            return mainArr.count
        } else {
            return authArr.count
        }
    }

}
