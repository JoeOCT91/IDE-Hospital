//
//  ContactUsViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/29/20.
//

import Foundation
protocol ContactUsViewModelProtocol {
    func contuctUsRequest(name:String?, email:String?, phoneNumber:String?, message:String?)
}
class ContactUsViewModel{
    
    private weak var view:ContactUsVCProtocol?

    init(view:ContactUsVCProtocol) {
        self.view = view
    }
    
    
    // MARK:- Private Functions
    private func sendContactUsRequestAPI(body:RequsetBodyData){
        self.view?.showLoader()
        APIManager.sendContactUsRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                self.view?.presentPopupOnMainThread(message: error.localizedDescription, alertType: .withFaliure, delegate: nil)
                print(error.localizedDescription)
            case .success(let result):
                if result.code == 202 {
                    self.view?.presentPopupOnMainThread(message: L10n.successfulRequest, alertType: .withSuccess, delegate: self.view)

                }
            }
            self.view?.hideLoader()
        }
    }
}
extension ContactUsViewModel:ContactUsViewModelProtocol{
    
    func contuctUsRequest(name:String?, email:String?, phoneNumber:String?, message:String?){
        guard !name!.isEmpty else{
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterName, alertType: .withFaliure, delegate: nil)
            return
        }
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterEmail, alertType: .withFaliure, delegate: nil)

            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentPopupOnMainThread(message: L10n.invalidEMailFormat, alertType: .withFaliure, delegate: nil)

            return
        }
        guard !phoneNumber!.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterPhoneNumber, alertType: .withFaliure, delegate: nil)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: phoneNumber!) else{
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterDetails, alertType: .withFaliure, delegate: nil)

            return
        }
        guard !message!.isEmpty, message != L10n.enterMessage else{
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterDetails, alertType: .withFaliure, delegate: nil)

            return
        }
        
        let body = RequsetBodyData(name: name!, email: email, mobile: phoneNumber!, message: message!)
        
        self.sendContactUsRequestAPI(body: body)
    }
}
