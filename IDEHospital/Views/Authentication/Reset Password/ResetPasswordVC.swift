//
//  ResetPasswordVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit
protocol ResetPasswordVCProtocol: class {
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
}
class ResetPasswordVC: UIViewController {
    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    
    private var viewModel:ResetPasswordViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.setUp()
        configureNavigationBar()
    }
    
    // MARK:- Public Methods
    class func create() -> ResetPasswordVC {
        let resetPasswordVC: ResetPasswordVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.resetPasswordVC)
        resetPasswordVC.viewModel = RestPasswordViewModel(view: resetPasswordVC)
        return resetPasswordVC
    }
    
    @IBAction func setNewPasswordButtonPressed(_ sender: Any) {
        self.viewModel.resetPasswordRequest(email: resetPasswordView.emailTextField.text)
    }
    
    //MARK:- Private Functions
    private func configureNavigationBar() {
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.resetPassword, fontColor: .white)
        self.setupSettingButton()
        self.setupBackWithPopup()
        
    }
    
}
extension ResetPasswordVC:ResetPasswordVCProtocol{
    func presentSuccessAlert(title: String, message: String) {
        self.presentAlertOnMainThread(message: message, alertTaype: 2, delegate: self)
    }
    func presentErrorAlert(title:String,message: String) {
        self.presentAlertOnMainThread(message: message, alertTaype: 1, delegate: nil)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
}
extension ResetPasswordVC:AlertVcDelegate{
    func okButtonPressed() {
        self.view.window?.rootViewController?.dismiss(animated: false)
    }
    
    
}
