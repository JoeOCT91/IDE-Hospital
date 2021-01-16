//
//  FavoritesVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import Foundation
import SDWebImage

protocol FavoritesVMProtocol: ViewModelWithPaginatioProtocol {
    func getDoctorImage(indexPath: IndexPath)
    func getCellData(indexPath: IndexPath) -> Doctor
    func deleteEntry(id: Int)
}

class FavoritesVM<T: FavoritesVCProtocol>: ViewModelWithPagination<T>, FavoritesVMProtocol {
    
    init(view: T) {
        super.init()
        self.view = view
        child = self
    }
    
    private func hasNoDataToPresent(){
        view?.tableViewIsEmpty(message: L10n.youHaveNoFavorites)
    }
    
    private  func removeEmptyDataPlaceholder(){
        if !dataList.isEmpty {
            view?.hideEmptyTablePlaceHolder()
        }
        else{
            self.view?.tableViewIsEmpty(message: L10n.youHaveNoFavorites)
        }
    }
    
    //Call data from the server
    func getData(){
        if UserDefaultsManager.shared().token != nil {
            self.view?.showLoader()
            APIManager.getFavorites(page: page) { [weak self] (result: Result<BaseResponse<Doctor>, Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let favorites):
                    self.dataList.append(contentsOf: favorites.data.items)
                    self.isHasMorePages(pagesCount: favorites.data.totalPages)
                    self.page += 1
                    self.view?.hideLoader()
                    self.removeEmptyDataPlaceholder()
                    self.view?.reloadTableview()
                case .failure(let error):
                    self.view?.hideLoader()
                    print(error)
                }
            }
        } else {
            view?.tableViewIsEmpty(message: L10n.loginToShowYourData)
        }
    }
    
    func getDoctorImage(indexPath: IndexPath){
        let urlString  = (dataList[indexPath.row] as! Doctor).image 
        guard let url = URL(string: urlString) else { return }
        SDWebImageDownloader().downloadImage(with: url) { [weak self] (image, data, error, bool) in
            guard let self = self else { return }
            guard let data = data else { return }
            SDWebImageCacheSerializer().cacheData(with: image!, originalData: data, imageURL: url)
            self.view?.setCellImage(image: data, indexPath: indexPath)
        }
    }
    
    func getCellData(indexPath: IndexPath) -> Doctor {
        return dataList[indexPath.row] as! Doctor
    }
    
    func deleteEntry(id: Int){
        APIManager.removeFavorite(doctorID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.clearData()
                self.getData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
