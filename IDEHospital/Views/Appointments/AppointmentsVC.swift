//
//  AppointmentsVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import UIKit

protocol AppointmentsVCProtocol: class {
    
}


class AppointmentsVC: UIViewController {
    
    @IBOutlet var appointmentsView: AppointmentsView!
    private var viewModel: AppointmentsVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentsView.setup()
        navigationController?.setViewControllerTitle(to: "Appointments")
    }
    
    // Public Methods
    class func create() -> AppointmentsVC {
        let appointmentsVC: AppointmentsVC = UIViewController.create(storyboardName: Storyboards.appointments, identifier: ViewControllers.appointmentsVC)
        let viewModel = AppointmentsVM(view: appointmentsVC)
        appointmentsVC.viewModel = viewModel
        return appointmentsVC
    }


}

extension AppointmentsVC: AppointmentsVCProtocol {
    
}
