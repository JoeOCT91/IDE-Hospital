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
    func getController() -> UIViewController
}

class SideMenuVM: SideMenuVMProtocol {

    
    
    private weak var view: SideMenuVCProtocol?
    
    private lazy var authControlloersArr = [
        
        TermsAndConditionsVC.create()
    ]
    
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
    
    func getController() -> UIViewController {
        if UserDefaultsManager.shared().token == nil {
            return authControlloersArr[0]
        } else {
            return authControlloersArr[0]
        }
    }
}
