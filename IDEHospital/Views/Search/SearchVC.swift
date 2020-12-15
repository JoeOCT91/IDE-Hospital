//
//  ViewController.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit
protocol SearchVCProtocol: class {
    func presentError(title:String,message: String)
    func showLoader()
    func hideLoader()
}
class SearchVC: UIViewController {

    @IBOutlet var searchView: SearchView!
    var searchViewModel:SearchViewModelProtocol!
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
   
    var currentSelectedCity = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        self.searchViewModel = SearchViewModel(search: self)
        self.searchViewModel.callGetCategoriesAPI(categoryID: 1)
        self.searchView.setUp()
    }
    
    // MARK:- Public Methods
    class func create() -> SearchVC {
        let viewController: SearchVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchVC)
        return viewController
    }
}
extension SearchVC:SearchVCProtocol{
    func presentError(title:String,message: String) {
        self.showAlert(title: title, message: message)
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
           navigationTitle.textColor = .white
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
             print("goBack")
          }
}
extension SearchVC:UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
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
            return self.searchViewModel.getRegion(row: currentSelectedCity).count
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
            return searchViewModel.getRegion(row: currentSelectedCity)[row].name
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
                   currentSelectedCity = row
                   searchView.textField2.resignFirstResponder()
               case 3:
                  searchView.textField3.text = searchViewModel.getRegion(row: currentSelectedCity)[row].name
                  searchView.textField3.resignFirstResponder()
               case 4:
                  searchView.textField4.text = searchViewModel.getCompaniesArr()[row].name
                  searchView.textField4.resignFirstResponder()
               default:
                   return
               }
            }
    
       func textFieldDidBeginEditing(_ textField: UITextField) {
             pickerView.delegate = self
             pickerView.dataSource = self
             currentTextField = textField
                switch currentTextField {
                case searchView.textField1:
                    currentTextField.inputView = pickerView
                    pickerView.tag = 1
                case searchView.textField2:
                     currentTextField.inputView = pickerView
                     pickerView.tag = 2
                case searchView.textField3:
                    if searchView.textField2.text == "" {
                        self.showAlert(title: "Sorry", message: AlertMessages.selectCityBeforeRegionFirst)
                    }
                    else{
                        currentTextField.inputView = pickerView
                        pickerView.tag = 3
                    }
                case searchView.textField4:
                     currentTextField.inputView = pickerView
                    pickerView.tag = 4
                default:
                    print("Nothing")
                }
      }
}
