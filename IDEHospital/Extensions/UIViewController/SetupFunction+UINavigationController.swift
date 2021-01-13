//
//  SetupFunction+UINavigationController.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 11/12/2020.
//

import UIKit

extension UINavigationController {

    func setNavigationBar(backgroundColor: UIColor = ColorName.veryLightPink.color) {
        // change navigation bar background behivor
        self.navigationBar.tintColor = .clear
        self.navigationBar.isTranslucent = true
        
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.backgroundColor = backgroundColor
    }

    func setUpNavigationBar() {
        self.setViewControllerTitle(to: L10n.serviceSearch, fontColor: .white)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
