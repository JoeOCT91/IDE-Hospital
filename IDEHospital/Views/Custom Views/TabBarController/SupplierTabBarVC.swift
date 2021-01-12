//
//  SupplierTabBarVC.swift
//  IUMAK-iOS
//
//  Created by Mohamed Elshaer on 9/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SupplierTabBarVC: UITabBarController {

    // MARK: - Properties
    let searchNavigation = UINavigationController()
    let favoriteNavigation = UINavigationController()
    let scheduleNavigation = UINavigationController()
    
    var categoryID:Int = 0{
          didSet(newValue){
            self.setViewControllers()
          }
      }
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers()
        setupTabBarView()
    }
    // MARK:- Private Methods
    private func setupTabBarView(){
        tabBar.backgroundColor = .white
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
    }
    // MARK:- Public Methods
    private func setSearchTab() {
        let searchVC = SearchVC.create(id: self.categoryID)
        searchVC.setupBackWithDismiss()
        searchVC.tabBarItem.image = Asset.component411.image.withRenderingMode(.alwaysOriginal)
        searchVC.tabBarItem.title = L10n.search
        searchVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.selected)
        searchNavigation.viewControllers = [searchVC]
    }
    private func setFavoriteTab() {
        let favoriteVC = FavoritesVC.create()
        favoriteVC.setupBackWithDismiss()
        favoriteVC.setupSettingButton()
        favoriteVC.tabBarItem.image = Asset.joheart.image.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.selected)
        favoriteVC.tabBarItem.title = L10n.favorite
        favoriteNavigation.viewControllers = [favoriteVC]
    }
    
    private func setScheduleTab() {
        let appointmentsVC = AppointmentsVC.create()
        appointmentsVC.setupBackWithDismiss()
        appointmentsVC.setupSettingButton()
        appointmentsVC.tabBarItem.image = Asset.calendar3.image.withRenderingMode(.alwaysOriginal)
        appointmentsVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.selected)
        appointmentsVC.tabBarItem.title = L10n.schedule
        scheduleNavigation.viewControllers = [appointmentsVC]
    }
    
    private func setViewControllers() {
        setSearchTab()
        setFavoriteTab()
        setScheduleTab()
        self.viewControllers = [searchNavigation, favoriteNavigation, scheduleNavigation]
        self.selectedIndex = 0
        for vc in self.viewControllers! {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 1, left: 0, bottom: -1, right: 0)
        }
    }
}
