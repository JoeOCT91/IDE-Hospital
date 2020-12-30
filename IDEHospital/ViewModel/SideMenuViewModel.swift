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
    func logout()
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
            print()
        } else {
            navigateToWhenAuth(index: index)
        }
    }
    
    private func navigateToWhenAuth(index: Int){
        switch index {
        case 0:
            view?.editProfilePressed()
        case 1:
            view?.favoritesPressed()
        case 2:
            view?.bookedAppointmentsPressed()
        case 3:
            view?.aboutUsPressed()
        case 4:
            view?.contactUsPressed()
        case 5:
            view?.sharePressed()
        case 6:
            view?.termsAndConditionsPressed()
        case 7:
            view?.logoutPressed()
        default:
            return
        }
    }
    
    private func navigateToWhenMain(index: Int){
        switch index {
        case 0:
            view?.loginPressed()
        case 1:
            view?.aboutUsPressed()
        case 2:
            view?.contactUsPressed()
        case 3:
            view?.sharePressed()
        case 4:
            view?.termsAndConditionsPressed()
        default:
            return
        }
    }
    
    func logout(){
        if UserDefaultsManager.shared().token == nil { return }
        APIManager.logoutRequest { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case.success(let result):
                print(result)
                UserDefaultsManager.shared().token = nil
                Authorization.authValue = ""
                self.view?.logoutSuccess()
            case .failure(let error):
                print(error)
            }
        }
    }
}
