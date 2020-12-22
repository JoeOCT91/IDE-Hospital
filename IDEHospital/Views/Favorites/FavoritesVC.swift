//
//  FavoritesVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import UIKit

protocol PaginationVCProtocol: class {
    func reloadTableview()
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
        navigationController?.setViewControllerTitle(to: L10n.myFavorites)
        setUpButtonsInNavigationBar()
        viewModel.getData()
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
    func reloadTableview(){
        favoritesView.favoritesTableView.reloadData()
    }
}

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesVC: FavoritesCellDelgate{
    
    @objc func deleteFavorite(doctorID : Int) {
        let alertVC = ConfirmationAlert(id: doctorID)
        alertVC.delgate = self
        self.presentAlertOnMainThread(alertVC: alertVC)
    }
    
    @objc func viewDoctorProfile(doctorID: Int) {
        print(doctorID)
        let alertVC = AlertVC()
        self.presentAlertOnMainThread(alertVC: alertVC)
    }
    
}
extension FavoritesVC: ConfirmationAlertDelgate {
    func confirmPressed(id: Int) {
        self.viewModel.deleteEntry(id: id)
    }

    
    
}
