//
//  HomeVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import UIKit

protocol HomeVCProtocol {
    func getCategories()
}

class HomeVC: UIViewController {
    
    //Outlets
    @IBOutlet var homeView: HomeView!
    
    //ViewModel
    private var viewModel: HomeVCProtocol!
    
    //Proprities
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.setup()
        self.viewModel.getCategories()
        configureNavigationBar()
        homeView.setupCollectionView(delgate: self, dataSource: self)
    }
    
    //MARK:- Private Methods
    private func configureNavigationBar() {
        self.title = "Choose Services"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#cccccc")
    }
    
    // MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.homeVC)
        let viewModel = HomeViewModel(view: homeVC)
        homeVC.viewModel = viewModel
        return homeVC
    }

}

extension HomeVC: HomeViewModelProtocol {
    internal func setCategory(categories: [Category]) {
        self.categories = categories
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
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.tag = categories[indexPath.row].id
        cell.setupCell(color: categories[indexPath.row].color,categoryTitle: categories[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        print(cell.tag)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
  
}
