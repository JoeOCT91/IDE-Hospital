//
//  ViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation

protocol HomeViewModelProtocol: NSObject {
    func showLoader()
    func HideLoader()
    func setCategory(categories: [Category])
}

class HomeViewModel: HomeVCProtocol {
    
    weak var view: HomeViewModelProtocol?
    
    var categories = [Category]()
    
    init(view: HomeViewModelProtocol){
        self.view = view
    }
    
    func getCategories() {
        view?.showLoader()
        APIManager.getCategories { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories.categories
                self.view?.setCategory(categories: self.categories)
                //self.downloadimages()
                self.view?.HideLoader()
            case .failure(let error):
                print(error)
                self.view?.HideLoader()
            }
        }
    }
    
//'    func downloadimages(){
//        for index in 0 ..< categories.count {
//            APIManager.downloadImageAsData(urlString: categories[index].image) { [weak self] (result) in
//                guard let self = self else { return }
//                switch result {
//                case .success(let data):
//                    self.categories[index].imageAsData = data
//                    self.view?.setCategory(category: self.categories[index])
//                    self.view?.HideLoader()
//                case .failure(let error):
//                    print(error)
//                    return
//                }
//            }
//        }
//    }
}

