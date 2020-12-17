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
    func getRegion() -> [Regions]
    func getCompaniesArr() -> [Companies]
    func bringPickerValues(tag:Int, row:Int) -> String
    func bringCountPickerValues(tag:Int) -> Int
    func itemSelected(tag:Int, row:Int)
    func checkIfCityFieldSelectedFirstOrNot(tag:Int)
    func checkResistingRegionValueOrNot(tag:Int)
  
}
class SearchViewModel{
    weak var searchVC:SearchVCProtocol!
    var specialtiesArr:[Specialties] = []
    var citiesArr:[Cities] = []
    var regionArr:[Regions] = []
    var companiesArr:[Companies] = []
    
    init(search:SearchVCProtocol) {
        self.searchVC = search
    }
}
extension SearchViewModel:SearchViewModelProtocol{
    
    func callGetCategoriesAPI(categoryID:Int) {
           APIManager.getCategoriesAPIRouter(categoryID: categoryID){(response) in
              self.searchVC.showLoader()
               switch response {
                 case .failure(let error):
                         print(error.localizedDescription)
                  case .success(let data):
                         print(data.data)
                         self.specialtiesArr = data.data.specialties
                         self.citiesArr = data.data.cities
                         self.companiesArr = data.data.companies
                     }
               self.searchVC.hideLoader()
          }
      }
    
    func getRegion() -> [Regions] {

         return self.regionArr
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
    
    func bringCountPickerValues(tag: Int) -> Int {
         switch tag {
            case 1:
                return getSpecialtiesArr().count
            case 2:
                return getCitiesArr().count
            case 3:
                return getRegion().count
            case 4:
                return getCompaniesArr().count
            default:
                return 1
            }
    }
    
    func bringPickerValues(tag: Int, row: Int) -> String {
        switch tag {
        case 1:
            return getSpecialtiesArr()[row].name
        case 2:
            return getCitiesArr()[row].name
        case 3:
            return getRegion()[row].name
        case 4:
            return getCompaniesArr()[row].name
        default:
            return "Data Not Found"
        }
    }
       func itemSelected(tag: Int, row: Int) {
           switch tag {
           case 1:
               searchVC.addSelectedItem(tag: tag, item: self.specialtiesArr[row].name)
           case 2:
               searchVC.addSelectedItem(tag: tag, item: self.citiesArr[row].name)
               self.regionArr = citiesArr[row].regions
           case 3:
                  searchVC.addSelectedItem(tag: tag, item:self.regionArr[row].name)
           case 4:
               searchVC.addSelectedItem(tag: tag, item: self.companiesArr[row].name)
           default:
               break
           }
       }
    
    func checkResistingRegionValueOrNot(tag: Int) {
        if tag == 2 {
            self.searchVC.resetRegionTextFieldValue()
        }
    }
    func checkIfCityFieldSelectedFirstOrNot(tag:Int) {
        if (tag == 3) && (regionArr.count == 0) {
            DispatchQueue.main.async {
                self.searchVC.presentError(title: "Sorry", message: "you have to choose City First!")
            }
             self.searchVC.switchToCityTextField()
         }
    }
}
