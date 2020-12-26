//
//  SignInViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation

protocol SignInViewModelProtocol {
    
}
class SignInViewModel {
    private weak var view:SignInVCProtocol!
    
    init(view:SignInVCProtocol) {
        self.view = view
    }
}
extension SignInViewModel:SignInViewModelProtocol{
    
}
