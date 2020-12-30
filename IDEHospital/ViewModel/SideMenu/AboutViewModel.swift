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

class AboutViewModel {
    private weak var view:AboutVCProtocol!
    
    required init(view: AboutVCProtocol) {
        self.view = view
    }
}
extension AboutViewModel:AboutViewModelProtocol{
        func callAboutAPI() {
            self.view.showLoader()
            APIManager.sendAboutRequestAPI(){(response) in
                switch response{
                case .failure(let error):
                    self.view.presentError(title: L10n.sorry, message: error.localizedDescription)
                    print(error.localizedDescription)
                case .success(let result):
                    print(result.code)
                    if result.code == 200 {
                        print(result.data?.about_us?.htmlToString)
                    }
                }
                self.view.hideLoader()
            }
        }
}
