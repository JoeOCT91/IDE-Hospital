//
//  AboutViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/30/20.
//

import Foundation
protocol AboutViewModelProtocol: class {
    func callAboutAPI()
}

class AboutUsVM: AboutViewModelProtocol {
    
    private weak var view:AboutVCProtocol!
    
    required init(view: AboutVCProtocol) {
        self.view = view
    }
    
    func callAboutAPI() {
        self.view.showLoader()
        APIManager.getAboutUS() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view.presentError(title: L10n.sorry, message: error.localizedDescription)
                print(error.localizedDescription)
            case .success(let result):
                if result.code == 200 {
                    let aboutStr = result.data?.about_us
                    let aboutAtrr = aboutStr?.htmlToAttributedString
                    self.view.setAboutUs(aboutUs: aboutAtrr!)
                }
            }
            self.view.hideLoader()
        }
    }
}
