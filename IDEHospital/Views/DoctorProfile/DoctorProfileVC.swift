//
//  DoctorProfileVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

protocol DoctorProfileVCProtocol: class {
    func showLoader()
    func HideLoader()
    
}

class DoctorProfileVC: UIViewController {
    
    // View model
    private var viewModel: DoctorProfileVMProtocol!
    // view
    @IBOutlet var doctorProfileView: DoctorProfileView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewsSetup()
        viewModel.getDoctorReviews()
    }
    
    private func viewsSetup(){
        setViewControllerTitle(to: "Search Result")
        doctorProfileView.setupBackground()
        self.edgesForExtendedLayout = UIRectEdge([])
        doctorProfileView.setupTableView(delgate: self, dataSource: self)
    }
    
    // Public Methods
    class func create(doctorID: Int) -> DoctorProfileVC {
        let doctorProfileVC: DoctorProfileVC = UIViewController.create(storyboardName: Storyboards.doctorProfile, identifier: ViewControllers.doctorProfileVC)
        let viewModel = DoctorProfileVM(view: doctorProfileVC, doctorID: doctorID)
        doctorProfileVC.viewModel = viewModel
        return doctorProfileVC
    }
}
extension DoctorProfileVC: DoctorProfileVCProtocol {
    func showLoader() {
        
    }
    
    func HideLoader() {
        
    }
    
    
}
extension DoctorProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
