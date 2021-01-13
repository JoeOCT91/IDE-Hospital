//
//  EditProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 12/01/2021.
//

import Foundation

protocol EditProfileVMProtocol: class {
    func saveUserData(edditedData: EdditedData)
    func getUserData()
}

class EditProfileVM: EditProfileVMProtocol {
    
    weak var view: EditProfileVCProtocol?
    
    init(view: EditProfileVCProtocol) {
        self.view = view
    }
    
    internal func saveUserData(edditedData: EdditedData){
        if validateEntry(edditedData: edditedData) {
            view?.showLoader()
            APIManager.edditUserData(eddittedData: edditedData) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case.success(let data):
                    if data.code == 200 {
                        self.view?.setUserData(userData: data.data!)
                    }
                    if data.code == 401 {
                        self.view?.presentError(message: data.message!)
                    }
                    self.view?.hideLoader()
                case .failure(let error):
                    print(error)
                    self.view?.hideLoader()
                }
            }
        }
    }
    
    private func validateEntry(edditedData: EdditedData) -> Bool {
        
        let validator = ValidatorManager.shared()
        if edditedData.name!.isEmpty {
            view?.presentError(message: L10n.nameIsEmpty)
            return false
        }

        if !validator.isValidEmail(edditedData.email!) {
            view?.presentError(message: L10n.validEmail)
            return false
        }

        if !validator.isPhoneNumberValid(phoneNumber: edditedData.mobile!) {
            view?.presentError(message: L10n.validMobile)
            return false
        }

        if !validator.isPasswordValid(edditedData.oldPassword!) {
            view?.presentError(message: L10n.validPass)
            return false
        }

        if !validator.isPasswordValid(edditedData.password!) {
            view?.presentError(message: L10n.validNewPass)
            return false
        }

        if edditedData.password! != edditedData.confirmPassword! {
            view?.presentError(message: L10n.passNotMatch)
            return false
        }
        
        return true
    }
    
    internal func getUserData() {
        view?.showLoader()
        APIManager.getUserData { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let userData):
                if userData.success != nil {
                    self.view?.setUserData(userData: userData.data!)
                }
                print(userData)
                self.view?.hideLoader()
            case .failure(let error):
                self.view?.hideLoader()
                print(error)
            }
        }
    }
}
