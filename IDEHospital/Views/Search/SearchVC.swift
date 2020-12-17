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
        self.setUpNavigationBar()
        self.searchViewModel = SearchViewModel(search: self)
        self.searchViewModel.callGetCategoriesAPI(categoryID: self.categoryId)
    }
    
    // MARK:- Public Methods
    class func create(id:Int) -> SearchVC {
        let viewController: SearchVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchVC)
        viewController.categoryId = id
        return viewController
    }
}
extension SearchVC:SearchVCProtocol{
    func resetRegionTextFieldValue() {
        searchView.textField3.text = searchView.textField3.placeholder
    }
    
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
    private func setUpNavigationBar() {
        navigationController?.setViewControllerTitle(to: L10n.serviceSearch, fontColor: .white)
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
        self.dismiss(animated: true)
    }
    
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
