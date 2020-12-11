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
    func setCellData(title: String, color: String, image: Data, indexPath: IndexPath)
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
        navigationController?.setViewControllerTitle(to: "Choose Services", fontColor: .white)
        homeView.setupCollectionView(delgate: self, dataSource: self)
    }
    
    //MARK:- Private Methods
    private func configureNavigationBar() {
        self.title = "Choose Services"
        var navFont = UIFont(font: FontFamily.PTSans.bold, size: 20)
        navFont = navFont?.withSize(20)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: .white)]
        navigationController?.navigationBar.barTintColor = UIColor(named: .veryLightPink)
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
        //categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.category, for: indexPath) as! CategoryCell
        viewModel.getCellData(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        print(cell.tag)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    func setCellData(title: String, color: String, image: Data, indexPath: IndexPath) {
        let cell = homeView.collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.tag = indexPath.row + 1
        cell.setupCell(title: title, color: color , image: image)
    }
  
}
