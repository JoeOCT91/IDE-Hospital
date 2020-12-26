//
//  ViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation
import SDWebImage

protocol HomeVMProtocol: class {
    func getCategories()
    func getCategoriesCount() -> Int
    func getCellData(indexPath: IndexPath)
    func determineWhichVCToOpen(tag:Int)
}

class HomeViewModel: HomeVMProtocol {
    private weak var view: HomeVCProtocol?
    
    private var categories = [MainCategory]()
    
    init(view: HomeVCProtocol){
        self.view = view
    }
    
    internal func getCategories() {
        view?.showLoader()
        APIManager.getCategories { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories.categories
                self.view?.reloadData()
                self.view?.HideLoader()
            case .failure(let error):
                print(error)
                self.view?.HideLoader()
            }
        }
    }
   internal func determineWhichVCToOpen(tag: Int) {
        switch tag {
        case 4:
            view?.goToNurseScreen()
        default:
            view?.goChooseServicesScreen(celTag: tag)
        }
    }
    
    
    internal func getCategoriesCount() -> Int {
        return categories.count
    }
    
    internal func getCellData(indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let urlString = category.image
        guard let url = URL(string: urlString) else { return }
        SDWebImageDownloader().downloadImage(with: url) { [weak self] (image, data, error, bool) in
            guard let self = self else { return }
            guard let data = data else { return }
            self.view?.setCellData(title: category.name, color: category.color, image: data,ID: category.id, indexPath: indexPath)
            }
    }
    
}
