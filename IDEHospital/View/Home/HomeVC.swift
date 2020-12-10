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
    
    //ViewModel
    private var viewModel: HomeVCProtocol!
    
    //Outlets
    @IBOutlet var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Services"
        self.homeView.setup()
        self.viewModel.getCategories()
        	
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#cccccc")
        //navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
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
    func setCategory(category: Category) {
        homeView.configureButton(category: category)
    }
    
    func showLoader() {
        view.showLoader()
    }
    
    func HideLoader() {
        view.hideLoader()
    }

    
}
