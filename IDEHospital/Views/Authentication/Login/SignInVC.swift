//
//  LoginVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit

protocol SignInVCProtocol:class {
    func presentSuccessAlert(title:String, message:String)
     func presentError(title:String,message: String)
     func showLoader()
     func hideLoader()
}
class SignInVC: UIViewController {

    @IBOutlet weak var signInView: SignInView!
    private var viewModel:SignInViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
         signInView.setUp()
         self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.login, fontColor: .white)
         self.setUpButtonsInPushedNavigationBar()
    }
    // MARK:- Public Methods
     class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
            signInVC.viewModel = SignInViewModel(view: signInVC)
                return signInVC
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.viewModel.loginRequest(email: signInView.emailTextField.text, password: signInView.passwordTextField.text)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        let resetPasswordVC = ResetPasswordVC.create()
        resetPasswordVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let signUpVC = SignUpVC.create()
            signUpVC.modalPresentationStyle = .fullScreen
           self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}
extension SignInVC:SignInVCProtocol{
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
