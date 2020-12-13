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
}
class SearchVC: UIViewController {

    @IBOutlet var searchView: SearchView!
    var searchViewModel:SearchViewModelProtocol!
    var chooseSpecialistsPickerView = UIPickerView()
    var chooseCityPickerView = UIPickerView()
    var chooseRegionPickerView = UIPickerView()
    var chooseCompaniesPickerView = UIPickerView()

    var regionsArr:[Regions] = []
    var numberOfRegions = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
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
extension SearchVC {
    private func setUpNavigationBar() {
           self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
           self.navigationController?.navigationBar.shadowImage = UIImage()
           self.navigationController?.navigationBar.backgroundColor = .lightGray
           let navigationTitle:UILabel = UILabel()
           navigationTitle.text = "Service Search"
           navigationTitle.font = UIFont(name: "PTSans-Bold", size: 20)
           navigationItem.titleView = navigationTitle
           self.navigationItem.hidesBackButton = true
           self.navigationController?.navigationBar.isTranslucent = true
           createRightButtonInNavigationBar()
           createLeftButtonInNavigationBar()
        }
       private func createRightButtonInNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(settingsButton))
        navigationItem.rightBarButtonItem?.setBackgroundImage(UIImage(named: "settings"), for: .normal, barMetrics: .default)
        }
       @objc func settingsButton(_ sender:UIBarButtonItem){
            // Settings Button
        }

       private func createLeftButtonInNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(goBackButton))
        navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "back-2"), for: .normal, barMetrics: .default)
       }
       @objc func goBackButton(_ sender:UIBarButtonItem){
             //Go Back
          }
}
extension SearchVC:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return searchViewModel.getSpecialtiesArr().count
        case 2:
            return searchViewModel.getCitiesArr().count
        case 3:
            return self.numberOfRegions
        case 4:
            return searchViewModel.getCompaniesArr().count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return searchViewModel.getSpecialtiesArr()[row].name
        case 2:
            return searchViewModel.getCitiesArr()[row].name
        case 3:
            return searchViewModel.getRegion(row: row)[row].name
        case 4:
            return searchViewModel.getCompaniesArr()[row].name
        default:
            return "Data Not Found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
               case 1:
                  searchView.textField1.text = searchViewModel.getSpecialtiesArr()[row].name
                  searchView.textField1.resignFirstResponder()
               case 2:
                   searchView.textField2.text = searchViewModel.getCitiesArr()[row].name
                   numberOfRegions = searchViewModel.getCitiesArr()[row].regions.count
                   regionsArr = searchViewModel.getCitiesArr()[row].regions
                   searchView.textField2.resignFirstResponder()
               case 3:
                searchView.textField3.text = regionsArr[row].name
                  searchView.textField3.resignFirstResponder()
               case 4:
                    searchView.textField4.text = searchViewModel.getCompaniesArr()[row].name
                    searchView.textField4.resignFirstResponder()
               default:
                   return
               }
            }
    
    
}
