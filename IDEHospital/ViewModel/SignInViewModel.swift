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
    private weak var view:SignInVCProtocol!
    
    init(view:SignInVCProtocol) {
        self.view = view
    }
    
    // MARK:- Private Functions
    private func sendLoginRequestAPI(body:AuthBodyData){
           self.view.showLoader()
        APIManager.sendLoginRequestAPI(body: body){(response) in
              switch response{
              case .failure(let error):
                print("jfjvjdfjjfjf")
                print(error.localizedDescription)
                self.view.presentError(title: L10n.sorry, message: error.localizedDescription)
               case .success(let result):
                if result.code == 201{
                    print(result.data)
                    //UserDefaultsManager.shared().token = result.data.access_token
                    self.view.presentSuccessAlert(title: L10n.successfulRequest, message: L10n.successRequestMessage)
                }
                else{
                    //print("jfjvjdfjjfjf")
                    self.view.presentError(title: L10n.sorry, message: result.message ?? "")
                }
             }
               self.view.hideLoader()
          }
     }
}
extension SignInViewModel:SignInViewModelProtocol{
    func loginRequest(email: String?, password: String?) {
        
                     guard let email = email?.trimmed , !email.isEmpty else {
                          self.view.presentError(title: L10n.sorry, message: L10n.pleaseEnterEmail)
                          return
                      }
                      guard ValidatorManager.shared().isValidEmail(email) else{
                          self.view.presentError(title: L10n.sorry, message: L10n.invalidEMailFormat)
                          return
                      }
                      guard !password!.isEmpty else {
                          self.view.presentError(title: L10n.sorry, message: L10n.pleaseEnterPassword)
                          return
                      }
                      guard ValidatorManager.shared().isPasswordValid(password!) else{
                          self.view.presentError(title: L10n.sorry, message: L10n.rightPasswordFormatDescription)
                          return
                      }
                      let body = AuthBodyData(name: "", email: email, mobile: "", password: password)
                      self.sendLoginRequestAPI(body: body)
    }
}
