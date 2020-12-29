//
//  ResetPasswordVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit
protocol ResetPasswordVCProtocol: class {
    func presentSuccessAlert(title:String, message:String)
        func presentError(title:String,message: String)
        func showLoader()
        func hideLoader()
}
class ResetPasswordVC: UIViewController {
    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    
    private var viewModel:ResetPasswordViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.setUp()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.resetPassword, fontColor: .white)
        self.setUpButtonsInPushedNavigationBar()
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
    
}
extension ResetPasswordVC:ResetPasswordVCProtocol{
    func presentSuccessAlert(title: String, message: String) {
                self.showSuccessfulAlert(title: title, message: message)
            }
            func presentError(title:String,message: String) {
                   self.showAlert(title: title, message: message)
            }
            func showLoader() {
                   self.view.showLoader()
            }
            func hideLoader() {
                   self.view.hideLoader()
            }
}
