//
//  EditProfileVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 12/01/2021.
//

import UIKit

protocol EditProfileVCProtocol: PopUPsProtocol {
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
        viewModel.getUserData()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    private func setupViews() {
        editProfileView.delegate = self
        setupBackWithPopup()
        setViewControllerTitle(to: L10n.editProfile)
        setupNavigationBar()
        editProfileView.setupBackground()
        self.hideKeyboardWhenTappedAround()
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

extension EditProfileVC: EditProfileDelegate{
    func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func savePressed(edittedData: EditedData) {
        viewModel.saveUserData(edditedData: edittedData)
    }
}
