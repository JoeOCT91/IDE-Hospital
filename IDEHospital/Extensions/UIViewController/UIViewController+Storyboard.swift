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
//    class func create<T: UIViewController>(nibName: String) -> T {
//        return UIViewController(nibName: nibName, bundle: nil) as! T
//    }
    
    func setupNavigationBar(backgroundColor: UIColor = UIColor(named: ColorName.veryLightPink)) {
        navigationController?.setNavigationBar(backgroundColor: backgroundColor)
    }
    
    func setViewControllerTitle(to title:String, fontColor: UIColor = .white) {
        let titleLabel = UILabel()
        titleLabel.font = FontFamily.PTSans.bold.font(size: 20)
        titleLabel.text = title
        titleLabel.textColor = fontColor
        self.navigationItem.titleView = titleLabel
    }
    
    internal func setupSettingButton(){
        var settingIcon = UIImage(asset: Asset.settings)
        settingIcon = settingIcon?.withRenderingMode(.alwaysOriginal)
        let settingButton = UIBarButtonItem(image: settingIcon, style: .plain, target: self, action: #selector(settingsButton))
        navigationItem.rightBarButtonItem = settingButton
    }
    //Control setting button pressed
    @objc private func settingsButton(_ sender:UIBarButtonItem){
        let sideMenuVC = SideMenuVC.create()
        let settingNavigation = UINavigationController(rootViewController: sideMenuVC)
        settingNavigation.modalPresentationStyle = .overFullScreen
        //settingNavigation.modalTransitionStyle = .crossDissolve
        present(settingNavigation, animated: true)
    }
    
    internal func setupBackWithDismiss() {
        var backIcon = UIImage(asset: Asset.back2)
        backIcon = backIcon?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backIcon, style: .plain, target: self, action: #selector(dismissAction))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func dismissAction() {
        self.dismiss(animated: true)
    }
    
    internal func setupBackWithPopup() {
        var backIcon = UIImage(asset: Asset.back2)
        backIcon = backIcon?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backIcon, style: .plain, target: self, action: #selector(popUpAction))
        navigationItem.leftBarButtonItem = backButton
    }
    @objc private func popUpAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
