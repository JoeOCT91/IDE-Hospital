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
  
}
class SearchViewModel{
   weak private var view:SearchVCProtocol!
   private var specialtiesArr:[Specialties] = []
   private var citiesArr:[Cities] = []
   private var regionArr:[Regions] = []
   private var companiesArr:[Companies] = []
   private var categoryID = 0
    init(search:SearchVCProtocol, categoryID:Int) {
        self.view = search
        self.categoryID = categoryID
    }
}
extension SearchViewModel:SearchViewModelProtocol{
    
    func callGetCategoriesAPI() {
        APIManager.getCategoriesAPIRouter(categoryID: self.categoryID){(response) in
              self.view.showLoader()
               switch response {
                 case .failure(let error):
                         print(error.localizedDescription)
                  case .success(let data):
                         print(data.data)
                         self.specialtiesArr = data.data.specialties
                         self.citiesArr = data.data.cities
                         self.companiesArr = data.data.companies
                     }
               self.view.hideLoader()
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
               view.addSelectedItem(tag: tag, item: self.specialtiesArr[row].name)
           case 2:
               view.addSelectedItem(tag: tag, item: self.citiesArr[row].name)
               self.regionArr = citiesArr[row].regions
           case 3:
                  view.addSelectedItem(tag: tag, item:self.regionArr[row].name)
           case 4:
               view.addSelectedItem(tag: tag, item: self.companiesArr[row].name)
           default:
               break
           }
       }
    
    func checkResistingRegionValueOrNot(tag: Int) {
        if tag == 2 {
            self.view.resetRegionTextFieldValue()
        }
    }
    func checkIfCityFieldSelectedFirstOrNot(tag:Int) {
        if (tag == 3) && (regionArr.count == 0) {
            DispatchQueue.main.async {
                self.view.presentError(title: L10n.sorry, message: AlertMessages.selectCityBeforeRegionFirst)
            }
             self.view.switchToCityTextField()
         }
    }
}