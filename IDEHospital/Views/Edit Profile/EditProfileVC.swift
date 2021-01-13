//
//  EditProfileVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 12/01/2021.
//

import UIKit

protocol EditProfileVCProtocol: class {
    func setUserData(userData: UserData)
    func showLoader()
    func hideLoader()
}

class EditProfileVC: UIViewController {
    
    //View
    @IBOutlet var editProfileView: EditProfileView!
    //View model
    private var viewModel: EditProfileVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        viewModel.getUserData()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupViews() {
        setupBackWithPopup()
        setViewControllerTitle(to: L10n.editProfile)
        setupNavigationBar()
        editProfileView.setupBackground()
    }
   
    // MARK:- Public Methods
    class func create() -> EditProfileVC {
        let editProfileVC: EditProfileVC = UIViewController.create(storyboardName: Storyboards.editProfile, identifier: ViewControllers.editProfile)
        editProfileVC.viewModel = EditProfileVM(view: editProfileVC)
        return editProfileVC
    }

}
extension EditProfileVC: EditProfileVCProtocol {
    
    func showLoader() {
        view.showLoader()
    }
    
    func hideLoader() {
        view.hideLoader()
    }
    internal func setUserData(userData: UserData){
        editProfileView.setUserrData(userData: userData)
    }

}
