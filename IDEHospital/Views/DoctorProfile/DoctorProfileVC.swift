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
    func reloadTableView()
    
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
    internal func reloadTableView() {
        doctorProfileView.reloadTableView()
    }
    
    
}

extension DoctorProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getReviewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.doctorReviewCell, for: indexPath) as! DoctorReviewCell
        cell.setupData(doctorReview: viewModel.getReviewData(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    
}
