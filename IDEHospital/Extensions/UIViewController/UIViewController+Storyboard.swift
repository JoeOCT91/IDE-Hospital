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
    
    func setupNavigationBar() {
      // NavBar Appearance
      navigationController?.navigationBar.tintColor = .clear
      navigationController?.navigationBar.isTranslucent = true
      navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
      // Remove shadow
      navigationController?.navigationBar.shadowImage = UIImage()
     self.navigationController?.navigationBar.backgroundColor = UIColor(named: ColorName.veryLightPink)
    }
    func setViewControllerTitle(to title:String, fontColor: UIColor = .white) {
      let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 25))
      titleLabel.font = FontFamily.PTSans.bold.font(size: 20)
      titleLabel.textAlignment = .center
      titleLabel.text = title
      titleLabel.textColor = fontColor
      self.navigationItem.titleView = titleLabel
     }
    func setUpButtonsInNavigationBar() {
        self.createRightButtonInNavigationBar()
        self.createLeftButtonInNavigationBar()
    }
    func setUpButtonsInPushedNavigationBar() {
      self.createRightButtonInNavigationBar()
      self.createBackButtonInNavigationBar()
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
        print("dkfk")
        self.dismiss(animated: true)
    }
    private func createBackButtonInNavigationBar() {
          navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButton))
          navigationItem.leftBarButtonItem?.setBackgroundImage(Asset.back2.image, for: .normal, barMetrics: .default)
    }
    
    @objc private func backButton(_ sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
}
