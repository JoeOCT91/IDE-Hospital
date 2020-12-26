//
//  NurseVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/18/20.
//

import UIKit
protocol NurseVCProtocol: class {
    func presentSuccessAlert(title:String, message:String)
    func presentError(title:String,message: String)
    func showLoader()
    func hideLoader()
}

class NurseVC: UIViewController {

    @IBOutlet var nurseView: NurseView!
    private var viewModel:NurseViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nurseView.setUp()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.homeNurse, fontColor: .white)
        self.setUpButtonsInPushedNavigationBar()
    }

    // MARK:- Public Methods
    class func create() -> NurseVC {
        let nurseVC: NurseVC = UIViewController.create(storyboardName: Storyboards.nurse, identifier: ViewControllers.nurseVC)
        nurseVC.viewModel = NurseViewModel(view: nurseVC)
        return nurseVC
    }
    
    @IBAction func nurseRequestButtonPressed(_ sender: Any) {
        self.viewModel.nurseRequest(name: nurseView.nameTextField.text, email: nurseView.emailTextField.text, phoneNumber: nurseView.phoneNumberTextField.text, details: nurseView.detailsTextView.text)
    }
}
extension NurseVC:NurseVCProtocol{
    
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
