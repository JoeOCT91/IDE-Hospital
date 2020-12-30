//
//  TermsAndConditionsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import Foundation

protocol TermsAndConditionsVMProtocol: class {
    func callTermsAPI()
}

class TermsAndConditionsVM {

    private weak var view: TermsAndConditionsVCProtocol?
    required init(view: TermsAndConditionsVCProtocol) {
        self.view = view
    }
}
extension TermsAndConditionsVM:TermsAndConditionsVMProtocol{
    
    func callTermsAPI() {
        self.view.showLoader()
        APIManager.sendTermsRequestAPI(){(response) in
            switch response{
            case .failure(let error):
                self.view.presentError(title: L10n.sorry, message: error.localizedDescription)
                print(error.localizedDescription)
            case .success(let result):
                print(result.code)
                if result.code == 200 {
                    print(result.data?.terms_and_conditions?.htmlToString)
                }
            }
            self.view.hideLoader()
        }
    }
}

