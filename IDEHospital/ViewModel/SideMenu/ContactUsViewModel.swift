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
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
                print(error.localizedDescription)
            case .success(let result):
                if result.code == 202 {
                    self.view?.presentSuccessAlert(title: L10n.successfulRequest, message: L10n.successRequestMessage)
                }
            }
            self.view?.hideLoader()
        }
    }
}
extension ContactUsViewModel:ContactUsViewModelProtocol{
    
    func contuctUsRequest(name:String?, email:String?, phoneNumber:String?, message:String?){
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
        guard !message!.isEmpty, message != L10n.enterMessage else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterDetails)
            return
        }
        
        let body = RequsetBodyData(name: name!, email: email, mobile: phoneNumber!, message: message!)
        
        self.sendContactUsRequestAPI(body: body)
    }
}
