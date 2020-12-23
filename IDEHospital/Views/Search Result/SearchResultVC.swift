//
//  SearchResultVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/21/20.
//

import UIKit
protocol SearchResultVCProtocol: class {
    func presentError(title:String,message: String)
    func showLoader()
    func hideLoader()
    func addSelectedItem(tag:Int, item:String)
}
class SearchResultVC: UIViewController {

    @IBOutlet var searchResultView: SearchResultView!
    private var viewModel:SearchResultViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.setupView()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.searchResult, fontColor: .white)
        self.setUpButtonsInPushedNavigationBar()
        self.setUpSearchResultTable()
    }
    // MARK:- Public Methods
    class func create() -> SearchResultVC {
        let searchResultVC: SearchResultVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchResult)
        searchResultVC.viewModel = SearchResultViewModel(view: searchResultVC)
           return searchResultVC
    }
    // MARK:- Private Methods
    private func setUpSearchResultTable() {
        self.searchResultView.searchResultTableView.register(UINib.init(nibName: ViewControllers.searchResultCell , bundle: nil), forCellReuseIdentifier: L10n.cellIdentifire)
        self.searchResultView.searchResultTableView.delegate = self
        self.searchResultView.searchResultTableView.dataSource = self
    }
}
extension SearchResultVC:SearchResultVCProtocol{
    
    func addSelectedItem(tag: Int, item: String) {
        let texFiled = self.searchResultView.viewWithTag(tag) as! UITextField
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

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.searchResultView.searchResultTableView.dequeueReusableCell(withIdentifier: L10n.cellIdentifire, for: indexPath) as? SearchResultCell else {
            self.searchResultView.searchResultTableView.alpha = 0
            self.searchResultView.emptyDataLabel.alpha = 1
            return UITableViewCell()
        }
        
        cell.configureCell(doctorName: "Mostafa", doctorImage: "http://ide-hospital.ideaeg.co/assets/images/avatar.png", ratingImage: UIImage(), ratingViewCount: "10 Review", doctorSpecilty: "Dogs", secondBio: "Cats", region: "Giza", address: "6 of October", heartIamge: true, watingTime: "10", fees: "10")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath) Cell Cliced")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256.5
    }
    
}

extension SearchResultVC:UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    @objc private func donePressed(_ sender:UIBarButtonItem){
          viewModel.itemSelected(tag: sender.tag, row: searchResultView.pickerView.selectedRow(inComponent: 0))

      }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.bringSortArrCount()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.bringSortArrValues(row: row)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
          self.searchResultView.pickerView.delegate = self
          self.searchResultView.pickerView.dataSource = self
          self.searchResultView.pickerView.tag = textField.tag
          textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(donePressed(_:)))
    }
}
