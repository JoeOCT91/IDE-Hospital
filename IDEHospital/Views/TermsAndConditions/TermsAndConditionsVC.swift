//
//  TermsAndConditionsVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit
protocol TermsAndConditionsVCProtocol: class {
    func showLoader()
    func hideLoader()
    func setTermsAndCoditions(termsAndCondtions: NSAttributedString)
}

class TermsAndConditionsVC: UIViewController {
    
    @IBOutlet var termsAndConditionsView: TermsAndConditionsView!
    private var viewModel: TermsAndConditionsVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndConditionsView.setup()
        viewModel.getTermsAndConditions()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    private func configureNavigationBar() {
        self.setViewControllerTitle(to: L10n.termsAndConditions)
        self.setupNavigationBar()
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
    func showLoader() {
        view.showLoader()
    }
    
    func hideLoader() {
        view.hideLoader()
    }
    
    func setTermsAndCoditions(termsAndCondtions: NSAttributedString){
        termsAndConditionsView.setTermsAndConditions(termsAndConditions: termsAndCondtions)
    }
    
}
