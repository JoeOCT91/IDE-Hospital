//
//  ContactUsVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/29/20.
//

import UIKit
protocol ContactUsVCProtocol: class {
    func presentSuccessAlert(title:String, message:String)
       func presentError(title:String,message: String)
       func showLoader()
       func hideLoader()
}

class ContactUsVC: UIViewController {

    @IBOutlet weak var contactUsView: ContactUsView!
    
    private var viewModel:ContactUsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactUsView.setUp()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        setViewControllerTitle(to: L10n.sideMenuContactUs.uppercased())
        setupNavigationBar()
        setupBackWithPopup()
    }
    
    // MARK:- Public Methods
    class func create() -> ContactUsVC {
        let contactUsVC: ContactUsVC = UIViewController.create(storyboardName: Storyboards.sideMenu, identifier: ViewControllers.contactUsVC)
        contactUsVC.viewModel = ContactUsViewModel(view: contactUsVC)
        return contactUsVC
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        viewModel.contuctUsRequest(name: contactUsView.nameTextField.text, email: contactUsView.emailTextField.text, phoneNumber: contactUsView.mobileTextField.text, message: contactUsView.detailsTextArea.text)
    }
    

}
extension ContactUsVC:ContactUsVCProtocol{
    func presentSuccessAlert(title: String, message: String) {
        self.showSuccessfulAlert(title: title, message: message)
      }
      func presentError(title:String,message: String) {
        let alert = AlertVC()
        presentAlertOnMainThread(alertVC: alert)
          //self.showAlert(title: title, message: message)
      }
      func showLoader() {
          self.view.showLoader()
      }
      func hideLoader() {
          self.view.hideLoader()
      }
}
