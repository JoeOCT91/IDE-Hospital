//
//  RatingVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
protocol RatingVcProtocol: PopUPsProtocol {
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
        self.hideKeyboardWhenTappedAround()
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

    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    override func okButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

