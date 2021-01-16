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
                self.view?.presentPopupOnMainThread(message: error.localizedDescription, alertType: .withFaliure, delegate: nil)
            case .success(let result):
                if result.code == 202{
                    self.view?.presentPopupOnMainThread(message: L10n.successfulRequest, alertType: .withSuccess, delegate: self.view)
                }
                else{
                    self.view?.presentPopupOnMainThread(message: (result.errors?.email?[0])!, alertType: .withFaliure, delegate: nil)
                }
            }
            self.view?.hideLoader()
        }
    }
}
extension RestPasswordViewModel: ResetPasswordViewModelProtocol {
    func resetPasswordRequest(email: String?) {
        
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterEmail, alertType: .withFaliure, delegate: nil)
            return
        }
        
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentPopupOnMainThread(message: L10n.invalidEMailFormat, alertType: .withFaliure, delegate: nil)
            return
        }
        let body = AuthBodyData(name: "", email: email, mobile: "", password: "")
        self.sendResetPasswordRequestAPI(body: body)
    }
    
    
}
