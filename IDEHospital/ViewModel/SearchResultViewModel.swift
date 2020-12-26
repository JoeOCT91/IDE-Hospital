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
    func getDoctorsItemsArr() -> [ItemsInCell]?
    func putDoctorItemsInTableView(cell: SearchResultCell, indexPath:Int)  -> SearchResultCell
    func checkPagination(indexPath:Int)
    func callAddOrDeleteDoctorFromFavoriteListAPI(id:Int)
    func rsetTableViewValuee()
    func increasePageValue()
}
class SearchResultViewModel{
    private weak var view:SearchResultVCProtocol!
    private let sortArr:[String] = [L10n.fees,L10n.rating]
    private var doctorsDataBody:SearchResultBody!
    private var page:Int!
    private var total_Pages:Int!
    private var doctorItems: [ItemsInCell] = []
    
    init(view:SearchResultVCProtocol, doctorsData:SearchResultBody) {
        self.view = view
        self.doctorsDataBody = doctorsData
        
    }
}
extension SearchResultViewModel:SearchResultViewModelProtocol{
  
    
    func rsetTableViewValuee() {
        doctorsDataBody.page = 1
        self.doctorItems = []
        self.view.reloadTableViewData()
    }
    
    // MARK:- For Change Heart Value
    func callAddOrDeleteDoctorFromFavoriteListAPI(id: Int) {
        print("view Model ID" + " \(id)")
        APIManager.addOrDeleteDoctorFromFavoriteListAPI(doctorID: id){(response) in
            switch response{
            case .failure(let error):
                print("ffds")
                print(error.localizedDescription)
            case .success(let response):
                if response.code == 202{
                    print("Heart Changed Successfully")
                   self.doctorsDataBody.page = 1
                   self.doctorItems = []
                   self.sendSearchResultRequestAPI()
                }
            }
        }
    }
    // MARK:- it's For Checking The Pagination
    func checkPagination(indexPath: Int) {
        if indexPath == doctorItems.count - 1 {
            print("\(indexPath)" + "row" + "\(doctorItems.count)")
            increasePageValue()
        }
    }
    
     func increasePageValue() {
        if  doctorsDataBody.page + 1 <= total_Pages {
            print("Enterd The If Condition")
            self.sendSearchResultRequestAPI()
        }
        self.doctorsDataBody.page += 1
      }
    
    // MARK:- Fill Doctors Values in Table View
    func putDoctorItemsInTableView(cell: SearchResultCell, indexPath:Int) -> SearchResultCell {
        cell.configureCell(doctorID: doctorItems[indexPath].id, doctorName: doctorItems[indexPath].name, doctorImage: doctorItems[indexPath].image, rating: doctorItems[indexPath].rating, ratingViewCount: doctorItems[indexPath].reviews_count, doctorSpecilty: doctorItems[indexPath].specialty, secondBio: doctorItems[indexPath].second_bio, region: doctorItems[indexPath].region, address: doctorItems[indexPath].address, heartIamge: doctorItems[indexPath].is_favorited, watingTime: doctorItems[indexPath].waiting_time, fees: doctorItems[indexPath].fees)
        return cell
    }
    func getDoctorsItemsArr() -> [ItemsInCell]? {
        return self.doctorItems
    }
    // MARK:- Bring Search Reasult API
    func sendSearchResultRequestAPI() {
          self.view.showLoader()
        APIManager.sendSearchResultRequestAPI(body: doctorsDataBody){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let doctorsData):
                print("Current Page" + " = \(doctorsData.data.page)")
                self.page = doctorsData.data.page
                self.total_Pages = doctorsData.data.total_pages
                self.doctorItems += doctorsData.data.items
                self.view.reloadTableViewData()
            }
            if self.doctorItems.count == 0{
                self.view.showEmptyDataLabel()
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
        if self.sortArr[row].lowercased() != doctorsDataBody.order_by {
            doctorsDataBody.order_by = self.sortArr[row].lowercased()
            self.doctorsDataBody.page = 1
            self.doctorItems = []
            self.sendSearchResultRequestAPI()
        }
    }
}
