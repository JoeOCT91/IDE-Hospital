//
//  SearchResultVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/21/20.
//

import UIKit
protocol SearchResultVCProtocol: PopUPsProtocol {
    func showLoader()
    func hideLoader()
    func addSelectedItem(tag:Int, item:String)
    func reloadTableViewData()
    func showEmptyDataLabel()
}
class SearchResultVC: UIViewController {
    
    @IBOutlet weak var searchResultView: SearchResultView!
    private var viewModel:SearchResultViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.setupView()
        configureNavigationBar()
        self.setUpSearchResultTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.sendSearchResultRequestAPI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.loadFirstPage()
    }
    // MARK:- Public Methods
    class func create(doctorsData:SearchResultBody) -> SearchResultVC {
        let searchResultVC: SearchResultVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchResult)
        searchResultVC.viewModel = SearchResultViewModel(view: searchResultVC, doctorsData: doctorsData)
        return searchResultVC
    }
    // MARK:- Private Methods
    private func setUpSearchResultTable() {
        self.searchResultView.searchResultTableView.register(UINib.init(nibName: ViewControllers.searchResultCell , bundle: nil), forCellReuseIdentifier: L10n.cellIdentifire)
        self.searchResultView.searchResultTableView.delegate = self
        self.searchResultView.searchResultTableView.dataSource = self
    }
    private func configureNavigationBar() {
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.searchResult, fontColor: .white)
        self.setupSettingButton()
        self.setupBackWithPopup()
    }
    
    @objc private func donePressed(_ sender:UIBarButtonItem){
        viewModel.itemSelected(tag: sender.tag, row: searchResultView.pickerView.selectedRow(inComponent: 0))
        
    }
}
extension SearchResultVC:SearchResultVCProtocol{
    
    // MARK:- to SHow a label when there is no values in Table View
    func showEmptyDataLabel() {
        self.searchResultView.searchResultTableView.setNoDataPlaceholder(L10n.noSearchResult)
    }
    
    // MARK:- to Reload Table View Values
    func reloadTableViewData() {
        self.searchResultView.searchResultTableView.reloadData()
    }
    
    // MARK:- to Add Value in Filter Picker
    func addSelectedItem(tag: Int, item: String) {
        let texFiled = self.searchResultView.viewWithTag(tag) as! UITextField
        texFiled.text = item
    }
        
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
}

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource , sendDoctorIdDelegate{
    func bookNowPressed(doctorID: Int) {
        let doctorProfileVC = DoctorProfileVC.create(doctorID: doctorID)
        navigationController?.pushViewController(doctorProfileVC, animated: true)
    }
    
    // MARK:- Send doctor ID to Add or Delete Dorcor From Favorite List API
    func getDoctorID(id: Int) {
        self.viewModel.callAddOrDeleteDoctorFromFavoriteListAPI(id: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDoctorsItemsArr()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.searchResultView.searchResultTableView.dequeueReusableCell(withIdentifier: L10n.cellIdentifire, for: indexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
        
        cell.sendDoctorDelegate = self
        return viewModel.putDoctorItemsInTableView(cell: cell, indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath) Cell Cliced")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // MARK:- to Send Current Row Number To Check Pagination
        self.viewModel.checkPagination(indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256.5
    }
}

extension SearchResultVC:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.bringSortArrCount()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.bringSortArrValues(row: row)
    }
}

extension SearchResultVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.searchResultView.pickerView.delegate = self
        self.searchResultView.pickerView.dataSource = self
        self.searchResultView.pickerView.tag = textField.tag
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(donePressed(_:)))
    }
}
