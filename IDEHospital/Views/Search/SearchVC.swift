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
    func addSelectedItem(tag:Int, item:String)
    func switchToCityTextField()
    func resetRegionTextFieldValue()
}
class SearchVC: UIViewController {

    @IBOutlet var searchView: SearchView!
    var searchViewModel:SearchViewModelProtocol!
    var categoryId:Int!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.setUp()
        self.navigationController?.setUpNavigationBar()
        self.setUpButtonsInNavigationBar()
        self.searchViewModel.callGetCategoriesAPI()
    }
    
    // MARK:- Public Methods
    class func create(id:Int) -> SearchVC {
        let searchVC: SearchVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchVC)
        searchVC.searchViewModel = SearchViewModel(search: searchVC, categoryID: id)
        return searchVC
    }
}
extension SearchVC:SearchVCProtocol{
    // For Reset Reaion Value after Picking new City Value
    func resetRegionTextFieldValue() {
        searchView.textField3.text = searchView.textField3.placeholder
    }
    // for auto open city Picker if he pressed reagion peicker first
    func switchToCityTextField() {
        self.searchView.textField2.becomeFirstResponder()
    }
    
    func addSelectedItem(tag: Int, item: String) {
        let texFiled = self.searchView.viewWithTag(tag) as! UITextField
        texFiled.text = item
    }
    
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
    
    
    @objc private func donePressed(_ sender:UIBarButtonItem){
        searchViewModel.itemSelected(tag: sender.tag, row: searchView.pickerView.selectedRow(inComponent: 0))
        searchViewModel.checkResistingRegionValueOrNot(tag: sender.tag)
    }
}
extension SearchVC:UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        searchViewModel.bringCountPickerValues(tag: pickerView.tag)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        searchViewModel.bringPickerValues(tag: pickerView.tag, row: row)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchView.pickerView.delegate = self
        searchView.pickerView.dataSource = self
        searchView.pickerView.tag = textField.tag
        searchViewModel.checkIfCityFieldSelectedFirstOrNot(tag: textField.tag)
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(donePressed(_:)))
    }
}
