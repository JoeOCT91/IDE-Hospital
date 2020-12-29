//
//  TermsAndConditionsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import Foundation

protocol TermsAndConditionsVMProtocol: class {
    
}

class TermsAndConditionsVM: TermsAndConditionsVMProtocol {
    
    
    private weak var view: TermsAndConditionsVCProtocol?
    
    required init(view: TermsAndConditionsVCProtocol) {
        self.view = view
    }
}
