//
//  AppDelegate.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

protocol AppDelegateProtocol {
    func getMainWindow() -> UIWindow?
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

extension AppDelegate: AppDelegateProtocol {
    func getMainWindow() -> UIWindow? {
        return window
    }
}

