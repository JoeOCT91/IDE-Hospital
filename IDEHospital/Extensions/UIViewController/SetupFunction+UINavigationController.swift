//
//  SetupFunction+UINavigationController.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 11/12/2020.
//

import UIKit

extension UINavigationController {


//
//    func setViewControllerTitle(to title:String, fontColor: UIColor = .white) {
//        // lable that hold the title
//        let titleLabel = UILabel()
//        self.navigationBar.addSubview(titleLabel)
//        //title lable text configuration
//        titleLabel.font = UIFont(font: FontFamily.PTSans.bold, size: 20)
//        titleLabel.font = titleLabel.font.withSize(20)
//        titleLabel.textAlignment = .center
//        titleLabel.text = title
//        titleLabel.textColor = fontColor
//        //lable setting it frame
//        titleLabel.frame = navigationBar.frame
//
//        // To make status area translusent
//        self.navigationBar.backgroundColor = UIColor(named: ColorName.veryLightPink)
//        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationBar.isTranslucent = true
//
//    }
//
    func setUpNavigationBar() {
        self.setViewControllerTitle(to: L10n.serviceSearch, fontColor: .white)
    }
}
