//
//  NurseVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/18/20.
//

import UIKit

class NurseVC: UIViewController {

    @IBOutlet var nurseView: NurseView!
    let nurseNavigation = UINavigationController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nurseView.setUp()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.homeNurse, fontColor: .white)
        self.setUpButtonsInNavigationBar()
       
        
    }

    // MARK:- Public Methods
    class func create() -> NurseVC {
        let nurseVC: NurseVC = UIViewController.create(storyboardName: Storyboards.nurse, identifier: ViewControllers.nurseVC)
        //nurseVC.viewModel = SearchViewModel(search: nurseVC, categoryID: id)
        return nurseVC
    }

}
