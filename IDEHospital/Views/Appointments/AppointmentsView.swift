//
//  AppointmentsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import UIKit

class AppointmentsView: UIView {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var appointmentsTableView: UITableView!
    
    func setup(){
        setupBackgroundImage()
        configureTableView()
    }
    
    private func setupBackgroundImage() {
        backgroundImage.frame = UIScreen.main.bounds
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(asset: Asset.splashBackGround)
    }
    
    private func configureTableView() {
        appointmentsTableView.backgroundColor = .clear
    }
    
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        appointmentsTableView.separatorStyle = .none
        appointmentsTableView.register(AppoinmentCell.self, forCellReuseIdentifier: Cells.appointment)
        appointmentsTableView.delegate = delgate
        appointmentsTableView.dataSource = dataSource
    }
}
