//
//  dimissKeyboardWhenTap.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

extension UIViewController {

    func dimissKeyboardWhenTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
