//
//  FavoritesVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import UIKit

@objc
protocol PaginationVCProtocol: class {
    func reloadTableview()
    func showLoader()
    func hideLoader()
    func tableViewIsEmpty(message: String)
    func hideEmptyTablePlaceHolder()
    @objc optional func setCellImage(image: Data, indexPath: IndexPath)
}

protocol FavoritesVCProtocol: PaginationVCProtocol {
    func setCellImage(image: Data, indexPath: IndexPath)
}

class FavoritesVC: UIViewController {
    
    @IBOutlet var favoritesView: FavoritesView!
    
    private var viewModel: FavoritesVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesView.setup()
        favoritesView.setupTableView(delgate: self, dataSource: self)
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getData()
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.clearData()
    }
    
    private func configureNavigationBar() {
        self.setViewControllerTitle(to: L10n.myFavorites)
        self.setupNavigationBar()
    }
    
    // Public Methods
    class func create() -> FavoritesVC {
        let favoritesVC: FavoritesVC = UIViewController.create(storyboardName: Storyboards.favorites, identifier: ViewControllers.favoritesVC)
        let viewModel = FavoritesVM(view: favoritesVC)
        favoritesVC.viewModel = viewModel
        return favoritesVC
    }
}

extension FavoritesVC: FavoritesVCProtocol {
    
    func hideEmptyTablePlaceHolder() {
        favoritesView.favoritesTableView.removeNoDataPlaceholder()
    }
    
    func tableViewIsEmpty(message: String) {
        favoritesView.favoritesTableView.setNoDataPlaceholder(message)
    }
    
    func reloadTableview(){
        favoritesView.favoritesTableView.reloadData()
    }
    
    func showLoader(){
        view.showLoader()
    }
    
    func hideLoader(){
        view.hideLoader()
    }
}
//MARK:- Favorites table view delgetes functions
extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.favorites, for: indexPath) as! FavoritesCell
        cell.setupData(doctor: viewModel.getCellData(indexPath: indexPath))
        cell.delgate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.getDoctorImage(indexPath: indexPath)
    }
    
    internal func setCellImage(image: Data, indexPath: IndexPath) {
        guard let cell = favoritesView.favoritesTableView.cellForRow(at: indexPath) as? FavoritesCell else { return }
        cell.setdoctorImage(image: image)
        viewModel.scrollObserve(cellCount: indexPath.row)
    }
}

extension FavoritesVC: FavoritesCellDelgate{
    
    @objc func deleteFavorite(doctorID : Int) {
        self.viewModel.deleteEntry(id: doctorID)
    }
    
    @objc func viewDoctorProfile(doctorID: Int) {
        let doctorProfile = DoctorProfileVC.create(doctorID: doctorID)
        doctorProfile.setupBackWithPopup()
        navigationController?.pushViewController(doctorProfile, animated: true)
    }
    
}

