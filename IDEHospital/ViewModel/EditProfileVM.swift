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
        var edditedData = edditedData
        if validateEntry(editedData: &edditedData) {
            view?.showLoader()
            APIManager.edditUserData(eddittedData: edditedData) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case.success(let data):
                    if data.code == 200 {
                        self.view?.setUserData(userData: data.data!)
                        self.view?.presentPopupOnMainThread(message: L10n.profileUpdated, alertType: .withSuccess, delegate: nil)
                    }
                    if data.code == 401 {
                        self.view?.presentPopupOnMainThread(message: "data.message!", alertType: .withFaliure, delegate: nil)
                    }
                    self.view?.hideLoader()
                case .failure(let error):
                    print(error)
                    self.view?.hideLoader()
                }
            }
        }
    }
    
    private func validateEntry(editedData: inout EditedData) -> Bool {
        
        let validator = ValidatorManager.shared()
        if editedData.name!.isEmpty {
            self.view?.presentPopupOnMainThread(message: L10n.profileUpdated, alertType: .withFaliure, delegate: nil)
            return false
        }

        if !validator.isValidEmail(editedData.email!) {
            self.view?.presentPopupOnMainThread(message: L10n.validEmail, alertType: .withFaliure, delegate: nil)
            return false
        }

        if !validator.isPhoneNumberValid(phoneNumber: editedData.mobile!) {
            self.view?.presentPopupOnMainThread(message: L10n.validMobile, alertType: .withFaliure, delegate: nil)
            return false
        }
        
        if editedData.oldPassword!.isEmpty && editedData.confirmPassword!.isEmpty && editedData.password!.isEmpty {
            editedData.oldPassword = nil
            editedData.confirmPassword = nil
            editedData.password = nil
            return true
        } else {
            
            if !validator.isPasswordValid(editedData.oldPassword!) {
                self.view?.presentPopupOnMainThread(message: L10n.oldPassValid, alertType: .withFaliure, delegate: nil)
                return false
            }
            
            if editedData.oldPassword == editedData.password {
                self.view?.presentPopupOnMainThread(message: L10n.newIsSame, alertType: .withFaliure, delegate: nil)
                return false
            }
            
            if !validator.isPasswordValid(editedData.password!) {
                self.view?.presentPopupOnMainThread(message: L10n.validNewPass, alertType: .withFaliure, delegate: nil)
                return false
            }
            
            if editedData.password! != editedData.confirmPassword! {
                self.view?.presentPopupOnMainThread(message: L10n.passNotMatch, alertType: .withFaliure, delegate: nil)
                return false
            }
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
                self.view?.hideLoader()
            case .failure(let error):
                self.view?.hideLoader()
                print(error)
            }
        }
    }
}
