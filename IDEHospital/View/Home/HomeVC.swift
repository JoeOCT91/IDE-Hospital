//
//  HomeVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import UIKit

class HomeVC: UIViewController {
    
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.homeVC)
        let viewModel = HomeViewModel(view: homeVC)
        viewModel.view = homeVC
        return homeVC
    }
}

extension HomeVC: HomeViewModelProtocol {
    
}
