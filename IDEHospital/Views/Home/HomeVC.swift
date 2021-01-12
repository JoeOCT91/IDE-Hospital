//
//  HomeVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import UIKit

protocol HomeVCProtocol: class {
    func showLoader()
    func HideLoader()
    func reloadData()
    func setCellData(title: String, color: String, image: Data, ID:Int,indexPath: IndexPath)
    func goToNurseScreen()
    func goChooseServicesScreen(celTag:Int)
}

class HomeVC: UIViewController {
    
    //Outlets
    @IBOutlet var homeView: HomeView!
    
    //ViewModel
    private var viewModel: HomeVMProtocol!
    
    //Proprities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.setup()
        self.viewModel.getCategories()
        configureNavigationBar()
        homeView.setupCollectionView(delgate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    //MARK:- Private Methods
    private func configureNavigationBar() {
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.chooseServices, fontColor: .white)
    }
    
    // MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.homeVC)
        let viewModel = HomeViewModel(view: homeVC)
        homeVC.viewModel = viewModel
        return homeVC
    }
    
}

extension HomeVC: HomeVCProtocol {
    
    internal func goChooseServicesScreen(celTag:Int) {
        let tabBarController = SupplierTabBarVC()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.categoryID = celTag
        self.present(tabBarController, animated: true)
    }
    
    internal func goToNurseScreen() {
        let nurseVC = NurseVC.create()
        nurseVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nurseVC, animated: true)
        
    }
    
    internal func reloadData() {
        homeView.collectionView.reloadData()
    }
    
    internal func showLoader() {
        view.showLoader()
    }
    
    internal func HideLoader() {
        view.hideLoader()
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.category, for: indexPath) as! CategoryCell
        viewModel.getCellData(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        //Cell tag hold category ID to use when navigate to others controllers
        viewModel.determineWhichVCToOpen(tag: cell.tag)
    }
    
    
    internal func setCellData(title: String, color: String, image: Data,ID: Int, indexPath: IndexPath) {
        let cell = homeView.collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.tag = ID
        cell.setupCell(title: title, color: color , image: image)
    }
    
}
