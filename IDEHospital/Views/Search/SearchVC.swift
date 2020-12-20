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
    private var viewModel:SearchViewModelProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.setUp()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.serviceSearch, fontColor: .white)
        self.setUpButtonsInNavigationBar()
        self.viewModel.callGetCategoriesAPI()
    }
    
    // MARK:- Public Methods
    class func create(id:Int) -> SearchVC {
        let searchVC: SearchVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchVC)
        searchVC.viewModel = SearchViewModel(search: searchVC, categoryID: id)
        return searchVC
    }
}
extension SearchVC:SearchVCProtocol{
    // For Reset Reaion Value after Picking new City Value
    func resetRegionTextFieldValue() {
        searchView.textField3.text = ""
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
        viewModel.itemSelected(tag: sender.tag, row: searchView.pickerView.selectedRow(inComponent: 0))
        viewModel.checkResistingRegionValueOrNot(tag: sender.tag)
    }
}
extension SearchVC:UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.bringCountPickerValues(tag: pickerView.tag)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.bringPickerValues(tag: pickerView.tag, row: row)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchView.pickerView.delegate = self
        searchView.pickerView.dataSource = self
        searchView.pickerView.tag = textField.tag
        viewModel.checkIfCityFieldSelectedFirstOrNot(tag: textField.tag)
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(donePressed(_:)))
    }
}
