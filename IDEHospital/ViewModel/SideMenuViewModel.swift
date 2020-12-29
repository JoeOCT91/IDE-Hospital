//
//  SideMenuViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//
import UIKit

protocol SideMenuVMProtocol: class {
    func getMenuItemsCount() -> Int
    func getMenuItem(index: Int) -> SideMenuItem
    func navigateTo(index: Int)
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
    
    func navigateTo(index: Int){
        if UserDefaultsManager.shared().token == nil {
            navigateToWhenMain(index: index)
        } else {
            navigateToWhenAuth(index: index)
        }
    }
    
    private func navigateToWhenAuth(index: Int){
        switch index {
        case 0:
            view?.editProfilePressed()
        case 6:
            view?.termsAndConditionsPressed()
        default:
            return
        }
    }
    
    private func navigateToWhenMain(index: Int){
        switch index {
        case 0:
            view?.editProfilePressed()
        case 1:
            view?.favoritesPressed()
        case 6:
            view?.termsAndConditionsPressed()
        default:
            return
        }
    }
}
