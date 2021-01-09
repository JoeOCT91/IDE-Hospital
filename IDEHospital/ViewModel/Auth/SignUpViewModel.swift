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
                print(error.localizedDescription)
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
            case .success(let result):
                if result.code == 201{
                    UserDefaultsManager.shared().token = result.data?.access_token
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
extension SignUpViewModel:SignUpViewModelProtocol{
    func signUpRequest(name: String?, email: String?, mobile: String?, password: String?, confirmPassword: String?) {
        
        guard !name!.isEmpty else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterName)
            return
        }
        guard name!.count > 3 else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.nameFieldCountIsSmall)
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
        guard !mobile!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterPhoneNumber)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: mobile!) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.rightPhoneNumberFormatDescription)
            return
        }
        guard !password!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterPassword)
            return
        }
        guard ValidatorManager.shared().isPasswordValid(password!) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.rightPasswordFormatDescription)
            return
        }
        guard !confirmPassword!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseConfirmPassword)
            return
        }
        guard password == confirmPassword else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.disMatchedPassword)
            return
        }
        let body = AuthBodyData(name: name, email: email, mobile: mobile, password: password)
        self.sendRegisterRequestAPI(body: body)
    }
}
