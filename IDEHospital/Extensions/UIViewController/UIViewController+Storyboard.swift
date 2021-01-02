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
    
    func setUpButtonsInNavigationBar() {
        self.createRightButtonInNavigationBar()
        self.createLeftButtonInNavigationBar()
    }
    
    func setUpButtonsInPushedNavigationBar() {
        self.createRightButtonInNavigationBar()
        self.createBackButtonInNavigationBar()
    }
    
    internal func setupSettingButton(){
        var settingIcon = UIImage(asset: Asset.settings)
        settingIcon = settingIcon?.withRenderingMode(.alwaysOriginal)
        let settingButton = UIBarButtonItem(image: settingIcon, style: .plain, target: self, action: #selector(settingsButton))
        navigationItem.rightBarButtonItem = settingButton
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
    
    internal func createRightButtonInNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingsButton))
        navigationItem.rightBarButtonItem?.setBackgroundImage(Asset.settings.image, for: .normal, barMetrics: .default)
    }
    
    //Control setting button pressed
    @objc private func settingsButton(_ sender:UIBarButtonItem){
        let sideMenuVC = SideMenuVC.create()
        let settingNavigation = UINavigationController(rootViewController: sideMenuVC)
        settingNavigation.modalPresentationStyle = .overFullScreen
        //settingNavigation.modalTransitionStyle = .crossDissolve
        present(settingNavigation, animated: true)
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
