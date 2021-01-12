//
//  DoctorProfileView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

protocol doctorProfileViewDelegate: class {
    func favoriteButtonPressed(doctorID: Int)
    func showOnMapPressed(lng: Double, lat: Double)
    func previousDayPressed()
    func nextDayPressed()
    func tapToReviewPressed(doctorID: Int)
    func bookpressed()
}

class DoctorProfileView: UIView {
    
    let doctorTopView = DoctorTopView()
    private let doctorBottomView = DoctorBottomView()
    
    weak var delgate: doctorProfileViewDelegate?
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        doctorTopView.configureViews()
    }
    
    //MARK:- Public methods
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        doctorBottomView.setupTableView(delgate: delgate, dataSource: dataSource)
    }
    
    func setupCollectioView(delgate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        doctorTopView.setupCollectioView(delgate: delgate, dataSource: dataSource)
    }
    
    func setupDoctorImage(image: Data){
        doctorTopView.setDoctorImage(image: image)
    }
    
    func setupDoctorData(doctorInformation: DoctorInformation) {
        doctorTopView.delegate = delgate
        doctorBottomView.delegate = delgate
        doctorBottomView.setupData(doctorInformation: doctorInformation)
        doctorTopView.setupData(doctorInformation: doctorInformation)
    }
    
    func reloadTableView() {
        doctorBottomView.reloadTableView()
    }
    
    func reloadCollectionData() {
        doctorTopView.reloadCollectionData()
    }
    
    func favoriteVisability(isHidden: Bool){
        doctorTopView.favoriteVisability(isHidden: isHidden)
    }
    
    func setupAppointmentData(date: String){
        doctorTopView.setupAppointmentData(date: date)
    }
    
    func isFavorite(imageName: String) {
        doctorTopView.isFavorite(imageName: imageName)
    }
    
    func enableBookButton(){
        doctorTopView.enableBookButton()
    }
    
    func disableBookButton(){
        doctorTopView.disableBookButton()
    }
    
    func scrollTobegining(){
        doctorTopView.scrollTobegining()
    }
    
    //MARK:- Private methods
    private func setup(){
        self.addSubview(doctorTopView)
        configureDctorTopView()
        self.addSubview(doctorBottomView)
        configureDoctorButtomView()
    }
    
    private func configureDctorTopView(){
        doctorTopView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: self.centerYAnchor, trailing: self.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0))
    }
    
    private func configureDoctorButtomView(){
        doctorBottomView.anchor(top: doctorTopView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

