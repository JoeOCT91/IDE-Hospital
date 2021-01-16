//
//  SignInViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation

protocol SignInViewModelProtocol {
    func loginRequest(email:String?, password:String?)
}
class SignInViewModel {
    private weak var view:SignInVCProtocol?
    
    init(view:SignInVCProtocol) {
        self.view = view
    }
    
    // MARK:- Private Functions
    private func sendLoginRequestAPI(body:AuthBodyData){
        self.view?.showLoader()
        APIManager.sendLoginRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                self.view?.presentPopupOnMainThread(message: error.localizedDescription, alertType: .withFaliure, delegate: nil)
            case .success(let result):
                if result.code == 201{
                    UserDefaultsManager.shared().token = result.data?.access_token
                    self.view?.presentPopupOnMainThread(message: L10n.successLogin, alertType: .withSuccess, delegate: self.view)
                }
                else{
                    self.view?.presentPopupOnMainThread(message: result.message!, alertType: .withFaliure, delegate: nil)
                }
            }
            self.view?.hideLoader()
        }
    }
}
extension SignInViewModel:SignInViewModelProtocol{
    func loginRequest(email: String?, password: String?) {
        
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterEmail, alertType: .withFaliure, delegate: nil)
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentPopupOnMainThread(message: L10n.invalidEMailFormat, alertType: .withFaliure, delegate: nil)
            return
        }
        guard !password!.isEmpty else {
            self.view?.presentPopupOnMainThread(message:  L10n.pleaseEnterPassword, alertType: .withFaliure, delegate: nil)
            return
        }
        guard ValidatorManager.shared().isPasswordValid(password!) else{
            self.view?.presentPopupOnMainThread(message: L10n.rightPasswordFormatDescription, alertType: .withFaliure, delegate: nil)

            return
        }
        let body = AuthBodyData(name: "", email: email, mobile: "", password: password)
        self.sendLoginRequestAPI(body: body)
    }
}
