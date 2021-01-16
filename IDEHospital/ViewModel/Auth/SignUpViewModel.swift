//
//  SignUpViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
protocol SignUpViewModelProtocol {
    func signUpRequest(name:String?, email:String?, mobile:String?, password:String?, confirmPassword:String?)
}
class SignUpViewModel {
    private weak var view:SignUpVCProtocol?
    
    init(view:SignUpVCProtocol) {
        self.view = view
    }
    
    
    // MARK:- Private Functions
    private func sendRegisterRequestAPI(body:AuthBodyData){
        self.view?.showLoader()
        APIManager.sendRegisterRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                self.view?.presentPopupOnMainThread(message: error.localizedDescription, alertType: .withFaliure, delegate: nil)
            case .success(let result):
                if result.code == 201{
                    UserDefaultsManager.shared().token = result.data?.access_token
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
extension SignUpViewModel:SignUpViewModelProtocol{
    func signUpRequest(name: String?, email: String?, mobile: String?, password: String?, confirmPassword: String?) {
        
        guard !name!.isEmpty else{
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterName, alertType: .withFaliure, delegate: nil)
            return
        }
        guard name!.count > 3 else{
            self.view?.presentPopupOnMainThread(message: L10n.nameFieldCountIsSmall, alertType: .withFaliure, delegate: nil)
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
        guard !mobile!.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterPhoneNumber, alertType: .withFaliure, delegate: nil)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: mobile!) else{
            self.view?.presentPopupOnMainThread(message: L10n.rightPhoneNumberFormatDescription, alertType: .withFaliure, delegate: nil)
            return
        }
        guard !password!.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterPassword, alertType: .withFaliure, delegate: nil)
            return
        }
        guard ValidatorManager.shared().isPasswordValid(password!) else{
            self.view?.presentPopupOnMainThread(message: L10n.rightPasswordFormatDescription, alertType: .withFaliure, delegate: nil)
            return
        }
        guard !confirmPassword!.isEmpty else {
            self.view?.presentPopupOnMainThread(message: L10n.pleaseConfirmPassword, alertType: .withFaliure, delegate: nil)
            return
        }
        guard password == confirmPassword else{
            self.view?.presentPopupOnMainThread(message: L10n.disMatchedPassword, alertType: .withFaliure, delegate: nil)
            return
        }
        let body = AuthBodyData(name: name, email: email, mobile: mobile, password: password)
        self.sendRegisterRequestAPI(body: body)
    }
}
