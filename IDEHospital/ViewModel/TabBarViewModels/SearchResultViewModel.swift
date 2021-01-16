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
    func getDoctorsItemsArr() -> [DoctorResponse]?
    func putDoctorItemsInTableView(cell: SearchResultCell, indexPath:Int)  -> SearchResultCell
    func checkPagination(indexPath:Int)
    func callAddOrDeleteDoctorFromFavoriteListAPI(id:Int)
    func loadFirstPage()
    func increasePageValue()
    func changeIsFavoriteValue(id:Int)
}
class SearchResultViewModel{
    private weak var view:SearchResultVCProtocol?
    private let sortArr:[String] = [L10n.fees,L10n.rating]
    private var doctorsDataBody:SearchResultBody!
    private var total_Pages:Int!
    private var doctorItems: [DoctorResponse] = []
    
    init(view:SearchResultVCProtocol, doctorsData:SearchResultBody) {
        self.view = view
        self.doctorsDataBody = doctorsData
        
    }
}
extension SearchResultViewModel:SearchResultViewModelProtocol{
    //MARK:- to change IS_Favorite Value INTernally
    func changeIsFavoriteValue(id: Int) {
        for i in 0..<doctorItems.count {
            if doctorItems[i].id == id {
                if doctorItems[i].is_favorited{
                    doctorItems[i].is_favorited = false
                }
                else{
                    doctorItems[i].is_favorited = true
                }
            }
        }
    }
    //MARK:- To Reset Table View Values
    func loadFirstPage() {
        doctorsDataBody.page = 1
        self.doctorItems = []
        self.view?.reloadTableViewData()
    }
    
    // MARK:- For Change Heart Value
    func callAddOrDeleteDoctorFromFavoriteListAPI(id: Int) {
        guard UserDefaultsManager.shared().token != nil else {
            self.view?.presentPopupOnMainThread(message: L10n.loginFirst, alertType: .withFaliure, delegate: nil)
            return
        }
        print("view Model ID" + " \(id)")
        APIManager.addOrDeleteDoctorFromFavoriteListAPI(doctorID: id){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                if response.code == 202{
                    print("Heart Changed Successfully")
                    self.changeIsFavoriteValue(id: id)
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
    func getDoctorsItemsArr() -> [DoctorResponse]? {
        return self.doctorItems
    }
    // MARK:- Bring Search Reasult API
    func sendSearchResultRequestAPI() {
        self.view?.showLoader()
        APIManager.sendSearchResultRequestAPI(body: doctorsDataBody){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let doctorsData):
                print("Current Page" + " = \(doctorsData.data.page)")
                self.total_Pages = doctorsData.data.total_pages
                self.doctorItems += doctorsData.data.items
                self.view?.reloadTableViewData()
            }
            if self.doctorItems.count == 0{
                self.view?.showEmptyDataLabel()
            }
            self.view?.hideLoader()
        }
    }
    
    func bringSortArrValues(row: Int) -> String {
        return self.sortArr[row]
    }
    
    func bringSortArrCount() -> Int {
        return self.sortArr.count
    }
    
    func itemSelected(tag: Int, row: Int) {
        view?.addSelectedItem(tag: tag, item: self.sortArr[row])
        if self.sortArr[row].lowercased() != doctorsDataBody.order_by {
            doctorsDataBody.order_by = self.sortArr[row].lowercased()
            self.doctorsDataBody.page = 1
            self.doctorItems = []
            self.sendSearchResultRequestAPI()
        }
    }
}
