//
//  DoctorProfileView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

class DoctorProfileView: UIView {
    
    private let dctorTopView = DoctorTopView()
    private let doctorButtomView = DoctorBottomView()
    
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        doctorButtomView.setupTableView(delgate: delgate, dataSource: dataSource)
    }
    
    private func setup(){
        self.addSubview(dctorTopView)
        configureDctorTopView()
        self.addSubview(doctorButtomView)
        configureDoctorButtomView()
        
    }
    
    private func configureDctorTopView(){
        dctorTopView.backgroundColor = .systemRed
        dctorTopView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.centerYAnchor, trailing: self.trailingAnchor)
    }
    private func configureDoctorButtomView(){
        doctorButtomView.anchor(top: dctorTopView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    func reloadTableView() {
        doctorButtomView.reloadTableView()
    }
    
    

}
