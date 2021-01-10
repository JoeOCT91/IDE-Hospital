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
    weak private var view:NurseVCProtocol?
    
    init(view:NurseVCProtocol) {
        self.view = view
    }
    // MARK:- Private Functions
    private func sendNurseRequestAPI(body:RequsetBodyData){
        self.view?.showLoader()
        APIManager.sendNurseRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
                print(error.localizedDescription)
            case .success(let result):
                print(result.code)
                if result.code == 202 {
                    self.view?.presentSuccessAlert(title: L10n.successfulRequest, message: L10n.successRequestMessage)
                }
            }
            self.view?.hideLoader()
        }
    }
}
extension NurseViewModel:NurseViewModelProtocol{
    
    func nurseRequest(name:String?, email:String?, phoneNumber:String?, details:String?){
        guard !name!.isEmpty else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterName)
            return
        }
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterEmail)
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.invalidEMailFormat)
            return
        }
        guard !phoneNumber!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterPhoneNumber)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: phoneNumber!) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.rightPhoneNumberFormatDescription)
            return
        }
        guard !details!.isEmpty else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterDetails)
            return
        }
        
        let body = RequsetBodyData(name: name!, email: email, mobile: phoneNumber!, message: details!)
        
        self.sendNurseRequestAPI(body: body)
    }
}
