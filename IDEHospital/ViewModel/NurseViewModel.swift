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
    weak private var view:NurseVCProtocol!
    
    init(view:NurseVCProtocol) {
        self.view = view
    }
    // MARK:- Private Functions
    private func sendNurseRequestAPI(name:String, email:String, phoneNumber:String, details:String){
//           let body = User(email: email, password: password)
//           self.signInVC.showLoader()
//           APIManager.loginAPIRouter(body:body){(response) in
//               switch response{
//               case .failure(let error):
//                   self.signInVC.presentError(message:error.localizedDescription)
//                   print(error.localizedDescription)
//               case .success(let result):
//                   print(result.token)
//                   UserDefaultsManager.shared().token = result.token
//                   self.signInVC.switchToMainState()
//               }
//                self.signInVC.hideLoader()
//           }
     }
}
extension NurseViewModel:NurseViewModelProtocol{
    
       func nurseRequest(name:String?, email:String?, phoneNumber:String?, details:String?){
        guard !name!.isEmpty else{
            self.view.presentError(title: L10n.sorry, message: L10n.pleaseEnterName)
            return
        }
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view.presentError(title: L10n.sorry, message: L10n.pleaseEnterEmail)
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view.presentError(title: L10n.sorry, message: L10n.invalidEMailFormat)
            return
        }
        guard !phoneNumber!.isEmpty else {
            self.view.presentError(title: L10n.sorry, message: L10n.pleaseEnterPhoneNumber)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: phoneNumber!) else{
            self.view.presentError(title: L10n.sorry, message: L10n.rightPhoneNumberFormatDescription)
            return
        }
        guard !details!.isEmpty else{
            self.view.presentError(title: L10n.sorry, message: L10n.pleaseEnterDetails)
            return
        }
        self.sendNurseRequestAPI(name: name!, email: email, phoneNumber: phoneNumber!, details: details!)
    }
}
