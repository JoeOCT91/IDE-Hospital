//
//  SearchResultVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/21/20.
//

import UIKit

class SearchResultVC: UIViewController {

    @IBOutlet var searchResultView: SearchResultView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setupBackground()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.searchResult, fontColor: .white)
        self.setUpButtonsInPushedNavigationBar()
    }
    // MARK:- Public Methods
    class func create() -> SearchResultVC {
        let searchResultVC: SearchResultVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchResult)
           return searchResultVC
    }
}
