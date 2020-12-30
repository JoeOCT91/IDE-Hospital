//
//  TermsAndConditionsVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit
protocol TermsAndConditionsVCProtocol: class {
    
}

class TermsAndConditionsVC: UIViewController {
    
    private var viewModel: TermsAndConditionsVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
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
    
}
