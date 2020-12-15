//
//  TabBarControllerTCViewController.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/10/20.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 // MARK:- Public Methods
 class func createTabBarController() -> UITabBarController {
    let tabBarController: UITabBarController = UITabBarController.createTabBarController(storyboardName: Storyboards.search, identifier: ViewControllers.tabBarVC)
     return tabBarController
 }


}
