//
//  SideMenuView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit

class SideMenuView: UIView {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    func setUP(){
        
    }
    
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        sideMenuTableView.separatorStyle = .none
        sideMenuTableView.register(SideMenuCell.self, forCellReuseIdentifier: Cells.sideMenu)
        sideMenuTableView.delegate = delgate
        sideMenuTableView.dataSource = dataSource
    }

}
