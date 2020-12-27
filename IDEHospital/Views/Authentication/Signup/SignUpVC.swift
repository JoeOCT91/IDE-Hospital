//
//  SignUpVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit
protocol SignUpVCProtocol: class {

}
class SignUpVC: UIViewController {

    private var viewModel:SignUpViewModelProtocol!
    
    @IBOutlet var signUpView: SignUpView!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setUp()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.signUp, fontColor: .white)
        self.setUpButtonsInPushedNavigationBar()
    }
    
    // MARK:- Public Methods
      class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
            signUpVC.viewModel = SignUpViewModel(view: signUpVC)
             return signUpVC
      }

}
extension SignUpVC:SignUpVCProtocol{
    
}
