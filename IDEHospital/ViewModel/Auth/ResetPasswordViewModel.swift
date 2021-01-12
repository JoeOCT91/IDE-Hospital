//
//  ResetPasswordViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
protocol ResetPasswordViewModelProtocol {
    func resetPasswordRequest(email:String?)
}
class RestPasswordViewModel {
    
    private weak var view:ResetPasswordVCProtocol?
    
    init(view:ResetPasswordVCProtocol) {
        self.view = view
    }
    
    // MARK:- Private Functions
    private func sendResetPasswordRequestAPI(body:AuthBodyData){
        self.view?.showLoader()
        APIManager.sendResetPasswordRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
            case .success(let result):
                if result.code == 202{
                    self.view?.presentSuccessAlert(title: L10n.successfulRequest, message: L10n.successRequestMessage)
                }
                else{
                    self.view?.presentErrorAlert(title: L10n.sorry, message: result.errors?.email?[0] ?? "")
                }
            }
            self.view?.hideLoader()
        }
    }
}
extension RestPasswordViewModel:ResetPasswordViewModelProtocol{
    func resetPasswordRequest(email: String?) {
        
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterEmail)
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.invalidEMailFormat)
            return
        }
        let body = AuthBodyData(name: "", email: email, mobile: "", password: "")
        self.sendResetPasswordRequestAPI(body: body)
    }
    
    
}
