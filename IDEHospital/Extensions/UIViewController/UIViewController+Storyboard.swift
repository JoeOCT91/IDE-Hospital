//
//  UIViewController+Storyboard.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

extension UIViewController {
    class func create<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    func setUpButtonsInNavigationBar() {
        self.createRightButtonInNavigationBar()
        self.createLeftButtonInNavigationBar()
    }
    private func createRightButtonInNavigationBar() {
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingsButton))
       navigationItem.rightBarButtonItem?.setBackgroundImage(Asset.settings.image, for: .normal, barMetrics: .default)
       }
      @objc private func settingsButton(_ sender:UIBarButtonItem){
          print("Settings Button")
       }
       private func createLeftButtonInNavigationBar() {
       navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(goBackButton))
       navigationItem.leftBarButtonItem?.setBackgroundImage(Asset.back2.image, for: .normal, barMetrics: .default)
      }
    @objc private func goBackButton(_ sender:UIBarButtonItem){
       self.dismiss(animated: true)
    }
}
