//
//  ViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation

protocol SearchViewModelProtocol {
    func callGetCategoriesAPI()
    func bringPickerValues(tag:Int, row:Int) -> String
    func bringCountPickerValues(tag:Int) -> Int
    func itemSelected(tag:Int, row:Int)
    func checkIfCityFieldSelectedFirstOrNot(tag:Int)
    func checkResistingRegionValueOrNot(tag:Int)
    func getCurrentChoosenData() -> SearchResultBody
}

class SearchViewModel{
    weak private var view:SearchVCProtocol?
    private var specialtiesArr:[Specialties] = []
    private var citiesArr:[Cities] = []
    private var regionArr:[Regions] = []
    private var companiesArr:[Companies] = []
    private var categoryID = 0
    private var currentSpecialtiesID:Int?
    private var currentCitiesID:Int?
    private var currentRegionID:Int?
    private var currentCompaniesID:Int?
    init(search:SearchVCProtocol, categoryID:Int) {
        self.view = search
        self.categoryID = categoryID
    }
}
extension SearchViewModel:SearchViewModelProtocol{
    func getCurrentChoosenData() -> SearchResultBody {
        let currentChosenData = SearchResultBody(main_category_id: self.categoryID, userToken: nil, specialty_id: self.currentSpecialtiesID, city_id: self.currentCitiesID, region_id: self.currentRegionID, company_id: self.currentCompaniesID, name: self.view?.getCurrentDoctorValue(), order_by: nil, page: 1, per_page: 15)
        return currentChosenData
    }
    
    func callGetCategoriesAPI() {
        APIManager.getCategoriesAPIRouter(categoryID: self.categoryID){(response) in
            self.view?.showLoader()
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.specialtiesArr = data.data.specialties
                self.citiesArr = data.data.cities
                self.companiesArr = data.data.companies
            }
            self.view?.hideLoader()
        }
    }
    
    func bringCountPickerValues(tag: Int) -> Int {
        switch tag {
        case 1:
            return self.specialtiesArr.count
        case 2:
            return self.citiesArr.count
        case 3:
            return self.regionArr.count
        case 4:
            return self.companiesArr.count
        default:
            return 1
        }
    }
    
    func bringPickerValues(tag: Int, row: Int) -> String {
        switch tag {
        case 1:
            return self.specialtiesArr[row].name
        case 2:
            return self.citiesArr[row].name
        case 3:
            return self.regionArr[row].name
        case 4:
            return self.companiesArr[row].name
        default:
            return L10n.dataNotFound
        }
    }
    func itemSelected(tag: Int, row: Int) {
        switch tag {
        case 1:
            self.currentSpecialtiesID = self.specialtiesArr[row].id
            view?.addSelectedItem(tag: tag, item: self.specialtiesArr[row].name)
        case 2:
            self.currentCitiesID = self.citiesArr[row].id
            view?.addSelectedItem(tag: tag, item: self.citiesArr[row].name)
            self.regionArr = citiesArr[row].regions
        case 3:
            self.currentRegionID = self.regionArr[row].id
            view?.addSelectedItem(tag: tag, item:self.regionArr[row].name)
        case 4:
            self.currentCompaniesID = self.companiesArr[row].id
            view?.addSelectedItem(tag: tag, item: self.companiesArr[row].name)
        default:
            break
        }
    }
    
    func checkResistingRegionValueOrNot(tag: Int) {
        if tag == 2 {
            self.view?.resetRegionTextFieldValue()
        }
    }
    func checkIfCityFieldSelectedFirstOrNot(tag:Int) {
        if (tag == 3) && (regionArr.count == 0) {
            DispatchQueue.main.async {
                self.view?.presentPopupOnMainThread(message: L10n.selectCityBeforeRegionFirst, alertType: .withFaliure, delegate: self.view)
            }
        }
    }
}
