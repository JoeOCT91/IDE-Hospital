//
//  AppDelegate.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let homeVC = HomeVC.create()
        let navigationController = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navigationController
        return true
    }
}

