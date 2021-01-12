//
//  NurseVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/18/20.
//

import UIKit
protocol NurseVCProtocol: class {
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
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
extension NurseVC:NurseVCProtocol{
    
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
extension NurseVC:AlertVcDelegate{
    func okButtonPressed() {
        self.view.window?.rootViewController?.dismiss(animated: false)
    }
}
