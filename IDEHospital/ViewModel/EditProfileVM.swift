//
//  EditProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 12/01/2021.
//

import Foundation

protocol EditProfileVMProtocol: class {
    func getUserData()
}

class EditProfileVM: EditProfileVMProtocol {
    
    weak var view: EditProfileVCProtocol?
    
    init(view: EditProfileVCProtocol) {
        self.view = view
    }
    
    internal func getUserData() {
        view?.showLoader()
        APIManager.getUserData { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let userData):
                self.view?.setUserData(userData: userData.userData)
                print(userData)
                self.view?.hideLoader()
            case .failure(let error):
                self.view?.hideLoader()
                print(error)
            }
        }
    }
}
