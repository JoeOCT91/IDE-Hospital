//
//  SignUpViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
protocol SignUpViewModelProtocol {

}
class SignUpViewModel {
    private weak var view:SignUpVCProtocol!
    
    init(view:SignUpVCProtocol) {
        self.view = view
    }
}
extension SignUpViewModel:SignUpViewModelProtocol{
    
}
