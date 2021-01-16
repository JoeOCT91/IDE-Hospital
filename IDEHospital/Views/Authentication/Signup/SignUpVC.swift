//
//  SignUpVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit
protocol SignUpVCProtocol: PopUPsProtocol {
//    func presentSuccessAlert(title:String, message:String)
//    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
}
class SignUpVC: UIViewController {
    
    private var viewModel:SignUpViewModelProtocol!
    @IBOutlet weak var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setUp()
        configureNavigationBar()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.viewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }
    
    // MARK:- To SignUp
    @IBAction func signUpButtonPressed(_ sender: Any) {
        self.viewModel.signUpRequest(name: signUpView.nameTextField.text, email: signUpView.emailTextField.text, mobile: signUpView.mobileTextField.text, password: signUpView.choosePasswordTextfield.text, confirmPassword: signUpView.confirmPasswordTextField.text)
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: Any) {
        let termsVC = TermsAndConditionsVC.create()
        termsVC.setupBackWithPopup()
        self.navigationController?.pushViewController(termsVC, animated: true)
    }
    
    //MARK:- Private Functions
    private func configureNavigationBar() {
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.signUp, fontColor: .white)
        self.setupBackWithPopup()
    }
    
}
extension SignUpVC: SignUpVCProtocol{

    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    override func okButtonPressed() {
        self.view.window?.rootViewController?.dismiss(animated: false)
    }
}

