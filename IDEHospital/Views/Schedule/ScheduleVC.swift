//
//  ScheduleVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/10/20.
//

import UIKit

class ScheduleVC: UIViewController {

    @IBOutlet var scheduleView: ScheduleView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- Public Methods
    class func create() -> ScheduleVC {
        let viewController: ScheduleVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.scheduleVC)
        return viewController
    }

}
