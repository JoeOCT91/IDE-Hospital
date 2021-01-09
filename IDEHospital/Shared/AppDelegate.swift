//
//  AppDelegate.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        
        let homeVC = HomeVC.create()
        let navigationController = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navigationController
        
        
//        let appointmentVC = DoctorProfileVC.create(doctorID: 65)
//        let navigationController = UINavigationController(rootViewController: appointmentVC)
//        window?.rootViewController = navigationController
        
//        let favoritesVC = FavoritesVC.create()
//        let navigationController = UINavigationController(rootViewController: favoritesVC)
//        window?.rootViewController = navigationController

//        let sideMenu = SideMenuVC.create()
//        let navigationController = UINavigationController(rootViewController: sideMenu)
//        window?.rootViewController = navigationController

        
        return true
    }
}

