//
//  TermsAndConditionsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import Foundation

protocol TermsAndConditionsVMProtocol: class {
    func getTermsAndConditions()
}

class TermsAndConditionsVM: TermsAndConditionsVMProtocol {

    private weak var view: TermsAndConditionsVCProtocol?
    
    required init(view: TermsAndConditionsVCProtocol) {
        self.view = view
    }
    
    func getTermsAndConditions(){
        view?.showLoader()
        APIManager.getTermsAndConditions { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let termsAndConditions):
                let termsAndConditionsStr = termsAndConditions.data?.termsAndConditions
                let termsAndConditionsAtrr = termsAndConditionsStr?.htmlToAttributedString!
                self.view?.setTermsAndCoditions(termsAndCondtions: termsAndConditionsAtrr!)
                self.view?.hideLoader()
            case .failure(let error):
                print(error)
                self.view?.hideLoader()
            }
        }
    }
}
