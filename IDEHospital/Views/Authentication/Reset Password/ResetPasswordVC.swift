//
//  ResetPasswordVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import UIKit
protocol ResetPasswordVCProtocol: class {
    
}
class ResetPasswordVC: UIViewController {

    private var viewModel:ResetPasswordViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:- Public Methods
      class func create() -> ResetPasswordVC {
        let resetPasswordVC: ResetPasswordVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.resetPasswordVC)
             resetPasswordVC.viewModel = RestPasswordViewModel(view: resetPasswordVC)
             return resetPasswordVC
      }
}
extension ResetPasswordVC:ResetPasswordVCProtocol{
    
}
