//
//  TermsAndConditionsVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit
protocol TermsAndConditionsVCProtocol: class {
    func presentSuccessAlert(title:String, message:String)
    func presentError(title:String,message: String)
    func showLoader()
    func hideLoader()
}

class TermsAndConditionsVC: UIViewController {
    
    @IBOutlet weak var termsView: TermsView!
    private var viewModel: TermsAndConditionsVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.termsView.setUp()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.terms.uppercased(), fontColor: .white)
        self.setUpButtonsInPushedNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.callTermsAPI()
    }
    
    
    class func create() -> UIViewController {
        let TermsAndConditionsVC: TermsAndConditionsVC =
            UIViewController.create(storyboardName: Storyboards.sideMenu, identifier: ViewControllers.termsAndConditionsVC)
        let viewModel = TermsAndConditionsVM(view: TermsAndConditionsVC)
        TermsAndConditionsVC.viewModel = viewModel
        return TermsAndConditionsVC
    }
    
}
extension TermsAndConditionsVC: TermsAndConditionsVCProtocol {
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
