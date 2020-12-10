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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.setup()
        self.viewModel.getCategories()
        configureNavigationBar()
    }
    
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
    
    @IBAction func humanMedicineButtonPressed(_ sender: UIButton) {
        print("category is is \(sender.tag)"  )
    }
    
    @IBAction func MRIButtonPressed(_ sender: UIButton) {
        print("category is is \(sender.tag)"  )
    }
    
    @IBAction func homeNursePressed(_ sender: UIButton) {
        print("category is is \(sender.tag)"  )
    }
    
    @IBAction func veterinaryPressed(_ sender: UIButton) {
        print("category is is \(sender.tag)"  )
    }

}

extension HomeVC: HomeViewModelProtocol {
    internal func setCategory(categories: [Category]) {
        homeView.setCategories(categories: categories)
    }
    
    internal func showLoader() {
        view.showLoader()
    }
    
    internal func HideLoader() {
        view.hideLoader()
    }
}
