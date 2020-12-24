//
//  SearchResultViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/22/20.
//

import Foundation
import UIKit
protocol SearchResultViewModelProtocol {
    func bringSortArrCount() -> Int
    func bringSortArrValues(row:Int) -> String
    func itemSelected(tag: Int, row: Int)
    func sendSearchResultRequestAPI()
    func getDoctorsData() -> SearchResultData?
    func getDoctorsItemsArr() -> [ItemsInCell]?
    func putDoctorItemsInTableView(cell: SearchResultCell, indexPath:Int)  -> SearchResultCell
    func checkPagination(indexPath:Int)

}
class SearchResultViewModel{
    private weak var view:SearchResultVCProtocol!
    private let sortArr:[String] = [L10n.fees,L10n.rating]
    private var doctorsDataBody:SearchResultBody!
    private var doctorsSearchResultData:SearchResultData!
    private var doctorItems: [ItemsInCell] = []
    
    init(view:SearchResultVCProtocol, doctorsData:SearchResultBody) {
        self.view = view
        self.doctorsDataBody = doctorsData
    }
}
extension SearchResultViewModel:SearchResultViewModelProtocol{
    func checkPagination(indexPath: Int) {
        if indexPath == doctorItems.count - 1 {
            if doctorsDataBody.page <= doctorsSearchResultData.total_pages{
                self.doctorsDataBody.page += 1
                self.sendSearchResultRequestAPI()
            }
        }
    }
    
    
    func putDoctorItemsInTableView(cell: SearchResultCell, indexPath:Int) -> SearchResultCell {
        cell.configureCell(doctorName: doctorItems[indexPath].name, doctorImage: doctorItems[indexPath].image, ratingImage: UIImage(), ratingViewCount: doctorItems[indexPath].reviews_count, doctorSpecilty: doctorItems[indexPath].specialty, secondBio: doctorItems[indexPath].second_bio, region: doctorItems[indexPath].region, address: doctorItems[indexPath].address, heartIamge: doctorItems[indexPath].is_favorited, watingTime: doctorItems[indexPath].waiting_time, fees: doctorItems[indexPath].fees)
        return cell
    }
    func getDoctorsItemsArr() -> [ItemsInCell]? {
        return self.doctorItems
    }
    
    func getDoctorsData() -> SearchResultData? {
        return self.doctorsSearchResultData
    }
    
    func sendSearchResultRequestAPI() {
        APIManager.sendSearchResultRequestAPI(body: doctorsDataBody){(response) in
            self.view.showLoader()
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let doctorsData):
                print(doctorsData.data)
                self.doctorsSearchResultData = doctorsData.data
                self.doctorItems += doctorsData.data.items
                self.view.reloadTableViewData()
            }
            self.view.hideLoader()
        }
    }
    
    func bringSortArrValues(row: Int) -> String {
        return self.sortArr[row]
    }
    
    func bringSortArrCount() -> Int {
        return self.sortArr.count
    }
    
    func itemSelected(tag: Int, row: Int) {
        view.addSelectedItem(tag: tag, item: self.sortArr[row])
             
    }
    
    
}
