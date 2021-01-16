//
//  NurseViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/18/20.
//

import Foundation
protocol NurseViewModelProtocol {
    func nurseRequest(name:String?, email:String?, phoneNumber:String?, details:String?)
}
class NurseViewModel {
    // Nurse View
    weak private var view:NurseVCProtocol?
    
    init(view: NurseVCProtocol) {
        self.view = view
    }
    // MARK:- Private Functions
    private func sendNurseRequestAPI(body:RequsetBodyData){
        self.view?.showLoader()
        APIManager.sendNurseRequestAPI(body: body){ [weak self] (response) in
            guard let self = self else { return }
            switch response{
            case .failure(let error):
                self.view?.presentPopupOnMainThread(message: error.localizedDescription, alertType: .withFaliure, delegate: nil)
            case .success(let result):
                print(result.code)
                if result.code == 202 {
                    self.view?.presentPopupOnMainThread(message: L10n.successfulRequest, alertType: .withSuccess, delegate: self.view)
                }
            }
            self.view?.hideLoader()
        }
    }
}
extension NurseViewModel:NurseViewModelProtocol{
    
    func nurseRequest(name:String?, email:String?, phoneNumber:String?, details:String?){
        guard !name!.isEmpty else{
            self.view?.presentPopupOnMainThread(message:  L10n.pleaseEnterName, alertType: .withFaliure, delegate: nil)
            return
        }
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentPopupOnMainThread(message:  L10n.pleaseEnterEmail, alertType: .withFaliure, delegate: nil)
            
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentPopupOnMainThread(message:  L10n.invalidEMailFormat, alertType: .withFaliure, delegate: nil)
            return
        }
        guard !phoneNumber!.isEmpty else {
            self.view?.presentPopupOnMainThread(message:  L10n.pleaseEnterPhoneNumber, alertType: .withFaliure, delegate: nil)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: phoneNumber!) else{
            self.view?.presentPopupOnMainThread(message: L10n.rightPhoneNumberFormatDescription, alertType: .withFaliure, delegate: nil)
            return
        }
        guard !details!.isEmpty else{
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterDetails, alertType: .withFaliure, delegate: nil)
            return
        }
        
        let body = RequsetBodyData(name: name!, email: email, mobile: phoneNumber!, message: details!)
        self.sendNurseRequestAPI(body: body)
    }
}
