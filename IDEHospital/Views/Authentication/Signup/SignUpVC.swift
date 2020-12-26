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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
