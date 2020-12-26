//
//  LoginVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit

protocol SignInVCProtocol:class {
    
}
class SignInVC: UIViewController {

    private var viewModel:SignInViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK:- Public Methods
     class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
            signInVC.viewModel = SignInViewModel(view: signInVC)
                return signInVC
    }

}
extension SignInVC:SignInVCProtocol{
    
}
