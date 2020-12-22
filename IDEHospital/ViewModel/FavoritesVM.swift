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
    
    //Call data from the server
    func getData(){
        APIManager.getFavorites(page: page) { [weak self] (result: Result<BaseResponse<Doctor>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.dataList.append(contentsOf: favorites.data.items)
                print(self.page)
                self.isHasMorePages(pagesCount: favorites.data.totalPages)
                self.page += 1
                self.view?.reloadTableview()
                print(self.dataList.count)
            case .failure(let error):
                print(error)
            }
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
        print("entry deleted")
        APIManager.removeFavorite(doctorID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.page = 1
                self.clearData()
                self.getData()
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
