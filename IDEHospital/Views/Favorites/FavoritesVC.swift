//
//  FavoritesVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/10/20.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet var favoritesView: FavoritesView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK:- Public Methods
      class func create() -> FavoritesVC {
          let viewController: FavoritesVC = UIViewController.create(storyboardName: Storyboards.search, identifier: ViewControllers.searchVC)
          return viewController
      }

}
