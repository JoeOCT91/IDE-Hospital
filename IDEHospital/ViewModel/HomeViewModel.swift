//
//  ViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation
import SDWebImage


protocol HomeVCProtocol: class {
    func showLoader()
    func HideLoader()
    func setCategory(categories: [MainCategory])
    func setCellImage(image: UIImage, indexPath: IndexPath)}

class HomeViewModel: HomeVMProtocol {
    
    weak var view: HomeVCProtocol?
    
    var categories = [MainCategory]()
    
    init(view: HomeVCProtocol){
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
                self.view?.HideLoader()
            case .failure(let error):
                print(error)
                self.view?.HideLoader()
            }
        }
    }
    
    func getImage(urlString: String, indexpath: IndexPath) {
        guard let url = URL(string: urlString) else { return }
        SDWebImageDownloader().downloadImage(with: url) { [weak self] (image, data, error, bool) in
            guard let self = self else { return }
            guard let image = image else { return }
            self.view?.setCellImage(image: image, indexPath: indexpath)
            }
        }
    }



