//
//  NurseVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/18/20.
//

import UIKit

protocol NurseVCProtocol: PopUPsProtocol {
    func showLoader()
    func hideLoader()
}

class NurseVC: UIViewController {
    
    @IBOutlet weak var nurseView: NurseView!
    private var viewModel:NurseViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nurseView.setUp()
        configureNavigationBar()
    }

    override func okButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
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
    
    //MARK:- Private Functions
    private func configureNavigationBar() {
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.homeNurse, fontColor: .white)
        self.setupSettingButton()
        self.setupBackWithPopup()
    }
    
}
extension NurseVC: NurseVCProtocol {
    
    internal func showLoader() {
        self.view.showLoader()
    }
    
    internal func hideLoader() {
        self.view.hideLoader()
    }
}
