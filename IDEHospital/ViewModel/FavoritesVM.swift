//
//  FavoritesVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import Foundation
import SDWebImage

protocol FavoritesVMProtocol: class {
    func getFavoritesList()
    func getDoctorImage(indexPath: IndexPath)
    func getCellData(indexPath: IndexPath) -> CellData
    func getFavoritesCount() -> Int
}

class FavoritesVM: FavoritesVMProtocol {
    
    
    var cache = NSCache<NSString, AnyObject>()
    private weak var view: FavoritesVCProtocol?
    
    private var favoritesList = [Doctor]()
    //typealias CellData = (name: String, address : String, specialty : String, fees : String )
    
    init(view: FavoritesVCProtocol){
        self.view = view
    }
    
    internal func getFavoritesList(){
        APIManager.getFavorites { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.favoritesList = data.data.items
                print(self.favoritesList)
                self.view?.reloadTableview()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func getDoctorImage(indexPath: IndexPath){
        let urlString  = favoritesList[indexPath.row].image
        guard let url = URL(string: urlString) else { return }
        SDWebImageDownloader().downloadImage(with: url) { [weak self] (image, data, error, bool) in
            guard let self = self else { return }
            guard let data = data else { return }
            SDWebImageCacheSerializer().cacheData(with: image!, originalData: data, imageURL: url)
            self.view?.setCellImage(image: data, indexPath: indexPath)
        }
    }
    
    func getFavoritesCount() -> Int {
        return favoritesList.count
    }
    
    func getCellData(indexPath: IndexPath) -> CellData {
        let cellData: CellData
        cellData.name = favoritesList[indexPath.row].name
        cellData.specialty = favoritesList[indexPath.row].specialty
        cellData.secondBio = favoritesList[indexPath.row].secondBio
        cellData.address = favoritesList[indexPath.row].address
        cellData.waitingTime = favoritesList[indexPath.row].waitingTime
        cellData.fees = String(favoritesList[indexPath.row].fees)
        cellData.rating = favoritesList[indexPath.row].rating
        cellData.reviesCount = favoritesList[indexPath.row].reviewsCount
        cellData.doctorID = favoritesList[indexPath.row].id
        
        return cellData
    }
}
