//
//  SideMenuViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

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
    
    private var authArr = [
        SideMenuItem(title: L10n.sideMenuEditProfile, image: Asset.sideMenuUser.name),
        SideMenuItem(title: L10n.sideMenuFavourites, image: Asset.sideMenuHeart.name),
        SideMenuItem(title: L10n.sideMenuBookedAppointments, image: Asset.sideMenuCalendar.name),
        SideMenuItem(title: L10n.sideMenuAboutUs, image: Asset.sideMenuAbout.name),
        SideMenuItem(title: L10n.sideMenuContactUs, image: Asset.sideMenuContact.name),
        SideMenuItem(title: L10n.sideMenuShare, image: Asset.sideMenuShare.name),
        SideMenuItem(title: L10n.sideMenuTermsConditions, image: Asset.sideMenuSheet.name),
        SideMenuItem(title: L10n.sideMenuLogouts, image: Asset.sideMenuLogin.name)]
    
    private var normallArr = [SideMenuItem]()
    
    func getMenuItem(index: Int) throws -> SideMenuItem {
        if UserDefaultsManager.shared().token == nil {
            if normallArr.isEmpty { throw SideMenuErrors.isEmpty}
            if normallArr.count < index { throw SideMenuErrors.outOfRange }
            return normallArr[index]
        } else {
            if authArr.isEmpty { throw SideMenuErrors.isEmpty}
            if authArr.count < index { throw SideMenuErrors.outOfRange }
            return authArr[index]
        }
    }
    
    func getCount() -> Int {
        if UserDefaultsManager.shared().token == nil {
            return normallArr.count
        } else {
            return authArr.count
        }
    }

}

import Foundation
protocol SideMenuVMProtocol: class {
    func getMenuItemsCount() -> Int
    func getMenuItem(index: Int) -> SideMenuItem
}

class SideMenuVM: SideMenuVMProtocol {
    
    private weak var view: SideMenuVCProtocol?
    
    init(view: SideMenuVCProtocol) {
        self.view = view
    }
    
    func getMenuItem(index: Int) -> SideMenuItem {
        do {
            return try SidemenuItems.shared.getMenuItem(index: index)
        }
        catch(let error){
            print(error.localizedDescription)
            return SideMenuItem(title: "", image: "")
        }
    }
    
    func getMenuItemsCount() -> Int {
        return SidemenuItems.shared.getCount()
    }
    
    
}
