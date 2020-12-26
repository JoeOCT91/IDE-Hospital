//
//  ResetPasswordViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
protocol ResetPasswordViewModelProtocol {
    
}
class RestPasswordViewModel {
    
    private weak var view:ResetPasswordVCProtocol!
    
    init(view:ResetPasswordVCProtocol) {
        self.view = view
    }
}
extension RestPasswordViewModel:ResetPasswordViewModelProtocol{
    
}
