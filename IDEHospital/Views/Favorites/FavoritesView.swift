//
//  FavoritesView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import UIKit

class FavoritesView: UIView {

    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    func setup() {
        setupBackgroundImage()
        configureTableView()
    }
    
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        favoritesTableView.separatorStyle = .none
        favoritesTableView.register(FavoritesCell.self, forCellReuseIdentifier: Cells.favorites)
        favoritesTableView.delegate = delgate
        favoritesTableView.dataSource = dataSource
    }
    
    private func setupBackgroundImage() {
        backgroundImage.frame = UIScreen.main.bounds
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(asset: Asset.splashBackGround)
    }
    
    private func configureTableView() {
        favoritesTableView.backgroundColor = .clear
    }

}
