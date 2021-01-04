//
//  DoctorBottomView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

class DoctorBottomView: UIView {
    
    private let profileButton = UIButton(frame: .zero)
    private let reviewsButton = UIButton(frame: .zero)
    private let scrollView = UIScrollView(frame: .zero)
    private let scrollViewContainer = UIView()
    private let reviewsTableView = UITableView()

    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        reviewsTableView.separatorStyle = .none
        //reviewsTableView.register(AppoinmentCell.self, forCellReuseIdentifier: Cells.appointment)
        reviewsTableView.delegate = delgate
        reviewsTableView.dataSource = dataSource
        reviewsTableView.isHidden = true
    }
    
    private func configureViews() {
        self.addSubview(profileButton)
        configureProfileButton()
        self.addSubview(reviewsButton)
        configureReviewsButton()
        self.addSubview(scrollView)
        configureScrollView()
        self.addSubview(reviewsTableView)
        configureReviewsTableView()
    }
    
    private func configureProfileButton(){
        profileButton.addTarget(self, action: #selector(profileButtonHasClicked), for: .touchUpInside)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileButton.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: self.topAnchor),
            profileButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        profileButton.setBackgroundColor(ColorName.white.color, for: .normal)
        profileButton.setBackgroundColor(ColorName.veryLightPink.color, for: .selected)
        profileButton.setBackgroundColor(ColorName.veryLightPink.color, for: .highlighted)

        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = 28
        profileButton.layer.maskedCorners = [.layerMinXMinYCorner]
        profileButton.isHighlighted = true
    }
    
    private func configureReviewsButton(){
        reviewsButton.addTarget(self, action: #selector(reviewsButtonHasClicked), for: .touchUpInside)
        reviewsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewsButton.topAnchor.constraint(equalTo: self.topAnchor),
            reviewsButton.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            reviewsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            reviewsButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        reviewsButton.setBackgroundColor(ColorName.white.color, for: .normal)
        reviewsButton.setBackgroundColor(ColorName.veryLightPink.color, for: .selected)
        reviewsButton.setBackgroundColor(ColorName.veryLightPink.color, for: .highlighted)
        
        reviewsButton.backgroundColor = ColorName.white.color
        reviewsButton.clipsToBounds = true
        reviewsButton.layer.cornerRadius = 28
        reviewsButton.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    @objc private func profileButtonHasClicked(){
        profileButton.isHighlighted = true
        reviewsButton.isHighlighted = false
        reviewsButton.isSelected = false
        profileButton.isSelected = true
        //Hide Reviews View
        reviewsTableView.isHidden = true
        // Show Profile View
        scrollView.isHidden = false
    }
    @objc private func reviewsButtonHasClicked() {
        profileButton.isHighlighted = false
        reviewsButton.isHighlighted = true
        reviewsButton.isSelected = true
        profileButton.isSelected = false
        //hideProfileView
        scrollView.isHidden = true
        //Show Reviews View
        reviewsTableView.isHidden = false
    }
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: reviewsButton.bottomAnchor)
        ])
        scrollView.addSubview(scrollViewContainer)
        configureScrollViewContainer()
    }
    func configureScrollViewContainer(){
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.backgroundColor = ColorName.veryLightPink.color
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        let uilabel = UILabel()
        uilabel.text = "sssssssssfff"
        scrollViewContainer.addSubview(uilabel)
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uilabel.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            uilabel.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor),

        ])
        scrollViewContainer.addSubview(uilabel)
    }
    private func configureReviewsTableView() {
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewsTableView.topAnchor.constraint(equalTo: profileButton.bottomAnchor),
            reviewsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            reviewsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            reviewsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
