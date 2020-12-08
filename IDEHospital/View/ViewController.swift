//
//  ViewController.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Public Methods
    class func create() -> ViewController {
        let viewController: ViewController = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.viewController)
        return viewController
    }


}

