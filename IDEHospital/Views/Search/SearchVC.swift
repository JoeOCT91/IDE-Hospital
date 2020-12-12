//
//  ViewController.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit
protocol SearchVCProtocol: class {
    func presentError(message: String)
    func showLoader()
    func hideLoader()
    func fillPickerValues()
}
class SearchVC: UIViewController {

    @IBOutlet var searchView: SearchView!
    var searchViewModel:SearchViewModelProtocol!
     var chooseSpecialistsPickerView = UIPickerView()
     var chooseCityPickerView = UIPickerView()
     var chooseRegionPickerView = UIPickerView()
     var chooseCompaniesPickerView = UIPickerView()
    
    var specialtiesArr:[Specialties] = []
    var citiesArr:[Cities] = []
    var regionsArr:[Regions] = []
    var companiesArr:[Companies] = []
        
    var numberOfRegions = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchViewModel = SearchViewModel(search: self)
        self.searchViewModel.callGetCategoriesAPI(categoryID: 1)
        self.searchView.setUp()
        self.setUpPickerViews()
    }
    
    private func setUpPickerViews(){
        chooseSpecialistsPickerView.delegate = self
        chooseSpecialistsPickerView.dataSource = self
        chooseCityPickerView.delegate = self
        chooseCityPickerView.dataSource = self
        chooseRegionPickerView.delegate = self
        chooseRegionPickerView.dataSource = self
        chooseCompaniesPickerView.delegate = self
        chooseCompaniesPickerView.dataSource = self
        
        searchView.textField1.inputView = chooseSpecialistsPickerView
        searchView.textField2.inputView = chooseCityPickerView
        searchView.textField3.inputView = chooseRegionPickerView
        searchView.textField4.inputView = chooseCompaniesPickerView

        chooseSpecialistsPickerView.tag = 1
        chooseCityPickerView.tag = 2
        chooseRegionPickerView.tag = 3
        chooseCompaniesPickerView.tag = 4
    }
    
    @IBAction func customNavigationBackButtonPressed(_ sender: Any) {
    }
    @IBAction func customNavigationSettingsButtonPressed(_ sender: UIButton) {
    }
    @IBAction func findDoctorButtonPressed(_ sender: UIButton) {
    }
    
    
    // MARK:- Public Methods
    class func create() -> SearchVC {
        let viewController: SearchVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchVC)
        return viewController
    }
}
extension SearchVC:SearchVCProtocol{
    func fillPickerValues() {
        let result = self.searchViewModel.getPickersValues()
        self.specialtiesArr = result.0
        self.citiesArr = result.1
        self.companiesArr = result.2
    }
    
    
    func presentError(message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
}
extension SearchVC:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return specialtiesArr.count
        case 2:
            return citiesArr.count
        case 3:
            return self.numberOfRegions
        case 4:
            return companiesArr.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return specialtiesArr[row].name
        case 2:
            return citiesArr[row].name
        case 3:
            return regionsArr[row].name
        case 4:
            return companiesArr[row].name
        default:
            return "Data Not Found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
               case 1:
                  searchView.textField1.text = specialtiesArr[row].name
                  searchView.textField1.resignFirstResponder()
               case 2:
                   searchView.textField2.text = citiesArr[row].name
                   numberOfRegions = citiesArr[row].regions.count
                   regionsArr = citiesArr[row].regions
                   searchView.textField2.resignFirstResponder()
               case 3:
                searchView.textField3.text = regionsArr[row].name
                  searchView.textField3.resignFirstResponder()
               case 4:
                    searchView.textField4.text = companiesArr[row].name
                    searchView.textField4.resignFirstResponder()
               default:
                   return
               }
            }
    
    
}
