//
//  UITabBarController+Storyboard.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/10/20.
//

import Foundation
import UIKit
extension UITabBarController {
    class func createTabBarController<T: UITabBarController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

