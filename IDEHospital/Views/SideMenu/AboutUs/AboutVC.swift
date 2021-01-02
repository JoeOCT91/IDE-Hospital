//
//  AboutVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/30/20.
//

import UIKit

protocol AboutVCProtocol:class {
    func presentSuccessAlert(title:String, message:String)
    func presentError(title:String,message: String)
    func setAboutUs(aboutUs: NSAttributedString)
    func showLoader()
    func hideLoader()
}
class AboutVC: UIViewController {
    @IBOutlet weak var aboutView: AboutView!
    
    private var viewModel:AboutViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutView.setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
        viewModel.callAboutAPI()
    }
    
    private func configureNavigationBar() {
        setViewControllerTitle(to: L10n.about)
        setupNavigationBar()
        setupBackWithPopup()
    }
    
    // MARK:- Public Methods
    class func create() -> AboutVC {
        let aboutVC: AboutVC = UIViewController.create(storyboardName: Storyboards.sideMenu, identifier: ViewControllers.aboutVC)
        aboutVC.viewModel = AboutUsVM(view: aboutVC)
        return aboutVC
    }
}
extension AboutVC:AboutVCProtocol{
    func presentSuccessAlert(title: String, message: String) {
        self.showSuccessfulAlert(title: title, message: message)
    }
    func presentError(title:String,message: String) {
        self.showAlert(title: title, message: message)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    func setAboutUs(aboutUs: NSAttributedString){
        aboutView.setAboutUs(termsAndConditions: aboutUs)
    }
}
