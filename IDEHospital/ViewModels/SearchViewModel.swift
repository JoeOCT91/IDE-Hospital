//
//  ViewModel.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation
protocol SearchViewModelProtocol {
    func callGetCategoriesAPI(categoryID:Int)
    func getSpecialtiesArr() -> [Specialties]
    func getCitiesArr() -> [Cities]
    func getRegion(row:Int) -> [Regions]
    func getCompaniesArr() -> [Companies]
}
class SearchViewModel{
     weak var searchVC:SearchVCProtocol!
    var specialtiesArr:[Specialties] = []
    var citiesArr:[Cities] = []
    var companiesArr:[Companies] = []
    init(search:SearchVCProtocol) {
        self.searchVC = search
    }
}
extension SearchViewModel:SearchViewModelProtocol{
    func getRegion(row: Int) -> [Regions] {
        return self.citiesArr[row].regions
    }
    func getSpecialtiesArr() -> [Specialties] {
          return self.specialtiesArr
    }
    func getCitiesArr() -> [Cities] {
        return self.citiesArr
    }
    func getCompaniesArr() -> [Companies] {
        return self.companiesArr
    }
    
    func callGetCategoriesAPI(categoryID:Int) {
         APIManager.getCategoriesAPIRouter(categoryID: 1){(response) in
             switch response {
               case .failure(let error):
                       print(error.localizedDescription)
                case .success(let data):
                       print(data.data)
                       self.specialtiesArr = data.data.specialties
                       self.citiesArr = data.data.cities
                       self.companiesArr = data.data.companies
                   }
        }
    }
}
