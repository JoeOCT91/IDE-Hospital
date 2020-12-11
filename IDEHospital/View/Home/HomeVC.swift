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
    func setCategory(categories: [MainCategory])
    func setCellImage(image: UIImage, indexPath: IndexPath)
    
}

class HomeVC: IDEHospitalNavigation {
    
    //Outlets
    @IBOutlet var homeView: HomeView!
    
    //ViewModel
    private var viewModel: HomeVMProtocol!
    
    //Proprities
    var categories = [MainCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.setup()
        self.viewModel.getCategories()
        setViewControllerTitle(to: "Choose Services")
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
    internal func setCategory(categories: [MainCategory]) {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.category, for: indexPath) as! CategoryCell
        cell.tag = categories[indexPath.row].id
        cell.setupCell(color: categories[indexPath.row].color,categoryTitle: categories[indexPath.row].name)
        viewModel.getImage(urlString: categories[indexPath.row].image, indexpath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        print(cell.tag)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func setCellImage(image: UIImage, indexPath: IndexPath) {
        let cell = homeView.collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.setimage(image: image)
    }
  
}
