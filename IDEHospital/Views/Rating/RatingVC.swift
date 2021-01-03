//
//  RatingVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
protocol RatingVcProtocol:class {
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
}
class RatingVC: UIViewController {
    
    @IBOutlet var ratingView: RatingView!
    private var viewModel:RatingViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.setUp()
        configureNavigationBar()
    }
    // MARK:- Public Methods
    class func create(doctorID:Int) -> RatingVC {
        let ratingVC: RatingVC = UIViewController.create(storyboardName: Storyboards.rating, identifier: ViewControllers.ratingVC)
        ratingVC.viewModel = RatingViewModel(view: ratingVC, doctorID: doctorID)
        return ratingVC
    }
    @IBAction func submitReview(_ sender: Any) {
        self.viewModel.addDoctorRating(rating: Int(ratingView.ratingView.rating), comment: ratingView.commentTextField.text)
    }
    
    //MARK:- Private Functions
    private func configureNavigationBar() {
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.review, fontColor: .white)
        self.setupSettingButton()
        self.setupBackWithPopup()
        
    }
}
extension RatingVC:RatingVcProtocol{
    func presentSuccessAlert(title: String, message: String) {
        let alertVC = AlertVC(message: message,alertTaype: 2)
        alertVC.alertDelegate = self
        presentAlertOnMainThread(alertVC: alertVC)
    }
    func presentErrorAlert(title:String,message: String) {
        let alertVC = AlertVC(message: message,alertTaype: 1)
        presentAlertOnMainThread(alertVC: alertVC)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
}
extension RatingVC:AlertVcDelegate{
    func okButtonPressed() {
        self.view.window?.rootViewController?.dismiss(animated: false)
    }
}
