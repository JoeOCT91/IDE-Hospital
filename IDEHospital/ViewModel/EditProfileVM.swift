//
//  EditProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 12/01/2021.
//

import Foundation

protocol EditProfileVMProtocol: class {
    func saveUserData(edditedData: EditedData)
    func getUserData()
}

class EditProfileVM: EditProfileVMProtocol {
    
    weak var view: EditProfileVCProtocol?
    
    init(view: EditProfileVCProtocol) {
        self.view = view
    }
    
    internal func saveUserData(edditedData: EditedData){
        if validateEntry(editedData: edditedData) {
            view?.showLoader()
            APIManager.edditUserData(eddittedData: edditedData) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case.success(let data):
                    if data.code == 200 {
                        self.view?.setUserData(userData: data.data!)
                        self.view?.presentError(message: L10n.profileUpdated, alertType: 2)
                    }
                    if data.code == 401 {
                        self.view?.presentError(message: data.message!, alertType: 2)
                    }
                    self.view?.hideLoader()
                case .failure(let error):
                    print(error)
                    self.view?.hideLoader()
                }
            }
        }
    }
    
    private func validateEntry(editedData: EditedData) -> Bool {
        
        let validator = ValidatorManager.shared()
        if editedData.name!.isEmpty {
            view?.presentError(message: L10n.nameIsEmpty, alertType: 1)
            return false
        }

        if !validator.isValidEmail(editedData.email!) {
            view?.presentError(message: L10n.validEmail, alertType: 1)
            return false
        }

        if !validator.isPhoneNumberValid(phoneNumber: editedData.mobile!) {
            view?.presentError(message: L10n.validMobile, alertType: 1)
            return false
        }

        if !validator.isPasswordValid(editedData.oldPassword!) {
            view?.presentError(message: L10n.validPass, alertType: 1)
            return false
        }
        
        if editedData.oldPassword == editedData.password {
            view?.presentError(message: L10n.newIsSame, alertType: 1)
            return false
        }

        if !validator.isPasswordValid(editedData.password!) {
            view?.presentError(message: L10n.validNewPass, alertType: 1)
            return false
        }
         
        if editedData.password! != editedData.confirmPassword! {
            view?.presentError(message: L10n.passNotMatch, alertType: 1)
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
