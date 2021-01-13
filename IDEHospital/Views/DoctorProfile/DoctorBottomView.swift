//
//  DoctorBottomView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

class DoctorBottomView: UIView {
    
    weak var delegate: doctorProfileViewDelegate?
    
    private var profileButton = UIButton(frame: .zero)
    private var reviewsButton = UIButton(frame: .zero)
    private let scrollView = UIScrollView(frame: .zero)
    private let scrollViewContainer = UIView()
    private let reviewsTableView = UITableView()
    private let speciality = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let secondBio = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let doctorAddress = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let sohowOnMapButton = UIButton(frame: .zero)
    private let watingTime = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let examinationFees = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let doctorcompanies = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    
    private var doctorLat = Double()
    private var doctorLng = Double()

    

    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(doctorInformation: DoctorInformation) {
        speciality.setupContent(imageName: Asset.specialityIcon.name, text: doctorInformation.specialty, textColor: UIColor.black)
        secondBio.setupContent(imageName: Asset.secondBio.name, text: doctorInformation.secondBio, textColor: UIColor.black)
        doctorAddress.setupContent(imageName: Asset.addressIcon.name, text: doctorInformation.address, textColor: UIColor.black)
        watingTime.setupContent(imageName: Asset.timeIcon.name, text: "Waiting Time : \(doctorInformation.waitingTime) minutes", textColor: UIColor.black)
        examinationFees.setupContent(imageName: Asset.feesIcon.name, text: "\(L10n.examinationFess) \(doctorInformation.fees) LE", textColor: UIColor.black)
        let joinedCompanies = doctorInformation.companies.joined(separator: ", ")
        doctorcompanies.setupContent(imageName: Asset.companiesIcon.name, text: joinedCompanies, textColor: UIColor.black)
        reviewsButton.setAttributedTitle(getReviewsButtonString(reviewsCount: doctorInformation.reviewsCount), for: .normal)
        doctorLat = doctorInformation.lat
        doctorLng = doctorInformation.lng
    }
    
    func setupTableView(delgate: UITableViewDelegate, dataSource: UITableViewDataSource){
        reviewsTableView.separatorStyle = .none
        reviewsTableView.register(DoctorReviewCell.self, forCellReuseIdentifier: Cells.doctorReviewCell)
        reviewsTableView.delegate = delgate
        reviewsTableView.dataSource = dataSource
        reviewsTableView.backgroundColor = ColorName.white.color.withAlphaComponent(0.75)
        reviewsTableView.alpha = 0
    }
    
    func reloadTableView() {
        reviewsTableView.reloadData()
    }
    
    private func configureViews() {
        profileButton = buttonConfigure()
        self.addSubview(profileButton)
        configureProfileButton()
        reviewsButton = buttonConfigure()
        self.addSubview(reviewsButton)
        configureReviewsButton()
        self.addSubview(scrollView)
        configureScrollView()
        self.addSubview(reviewsTableView)
        configureReviewsTableView()
    }
    
    private func buttonConfigure() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundColor(ColorName.veryLightPink.color, for: .normal)
        button.setBackgroundColor(ColorName.white.color, for: .selected)
        button.setBackgroundColor(ColorName.white.color, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: FontFamily.PTSans.bold.name, size: 15)
        button.titleLabel?.font = UIFont(name: FontFamily.PTSans.bold.name, size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 28
        return button
    }
    
    private func configureProfileButton(){
        profileButton.isHighlighted = true
        profileButton.setTitle(L10n.doctorProfile, for: .normal)
        profileButton.layer.maskedCorners = [.layerMinXMinYCorner]
        profileButton.addTarget(self, action: #selector(profileButtonHasClicked), for: .touchUpInside)

        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileButton.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: self.topAnchor),
            profileButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureReviewsButton(){
        reviewsButton.layer.maskedCorners = [.layerMaxXMinYCorner]
        reviewsButton.addTarget(self, action: #selector(reviewsButtonHasClicked), for: .touchUpInside)
        reviewsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewsButton.topAnchor.constraint(equalTo: self.topAnchor),
            reviewsButton.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            reviewsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            reviewsButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        reviewsButton.setAttributedTitle(getReviewsButtonString(reviewsCount: 0), for: .normal)
        reviewsButton.titleLabel?.numberOfLines = 0
        reviewsButton.titleLabel?.textAlignment = .center
    }
    
    private func getReviewsButtonString(reviewsCount: Int) -> NSAttributedString? {
        
        var font = UIFont(font: FontFamily.PTSans.bold, size: 15)?.withSize(15)
        let reviewsattributes : [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: UIColor.black ]
        let reviews = NSMutableAttributedString(string: "Reviews", attributes: reviewsattributes)
        font = UIFont(font: FontFamily.PTSans.regular, size: 15)
        let reviewsCountAttributes : [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: ColorName.richPurpleTwo.color ]
        let reviewsCount = NSMutableAttributedString(string: "\n\(reviewsCount) Review", attributes: reviewsCountAttributes)

        reviews.append(reviewsCount)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        style.alignment = .center
        reviews.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: reviews.string.count-1))
        return reviews
    }
    
    @objc private func profileButtonHasClicked(){
        profileButton.isHighlighted = true
        reviewsButton.isHighlighted = false
        reviewsButton.isSelected = false
        profileButton.isSelected = true
        //Hide Reviews View
        reviewsTableView.alpha = 0
        // Show Profile View
        scrollView.alpha = 1
    }
    @objc private func reviewsButtonHasClicked() {
        profileButton.isHighlighted = false
        reviewsButton.isHighlighted = true
        reviewsButton.isSelected = true
        profileButton.isSelected = false
        //hideProfileView
        scrollView.alpha = 0
        //Show Reviews View
        reviewsTableView.alpha = 1
    }
    
    func configureScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ColorName.white.color.withAlphaComponent(0.75)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: reviewsButton.bottomAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
        scrollView.addSubview(scrollViewContainer)
        configureScrollViewContainer()
    }
    
    func configureScrollViewContainer(){
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            scrollViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
        ])
        scrollViewContainer.addSubview(speciality)
        configureSpeciality()
        scrollViewContainer.addSubview(secondBio)
        configureSecondBio()
        scrollViewContainer.addSubview(doctorAddress)
        configureDoctorAddress()
        scrollViewContainer.addSubview(sohowOnMapButton)
        self.bringSubviewToFront(sohowOnMapButton)
        configureShowOnMapButton()
        scrollViewContainer.addSubview(watingTime)
        configureWaitingTime()
        scrollViewContainer.addSubview(examinationFees)
        configureExaminationFees()
        scrollViewContainer.addSubview(doctorcompanies)
        configureDoctorCompanies()
    }

    private func configureSpeciality(){
        NSLayoutConstraint.activate([
            speciality.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            speciality.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            speciality.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor, constant: 6),
        ])
    }
    
    private func configureSecondBio() {
        NSLayoutConstraint.activate([
            secondBio.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            secondBio.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            secondBio.topAnchor.constraint(equalTo: speciality.bottomAnchor, constant: 6),
        ])
    }
    
    private func configureDoctorAddress() {
        NSLayoutConstraint.activate([
            doctorAddress.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            doctorAddress.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            doctorAddress.topAnchor.constraint(equalTo: secondBio.bottomAnchor, constant: 6),
        ])
    }
    
    private func configureShowOnMapButton(){
        let viewOnMapLabel = HospitalCellLabel(textAlignment: .left, fontSize: 13)
        viewOnMapLabel.setupContent(imageName: Asset.onMapIcon.name, text: L10n.viewOnMap)
        viewOnMapLabel.textColor = ColorName.richPurpleTwo.color
        sohowOnMapButton.addSubview(viewOnMapLabel)
        sohowOnMapButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sohowOnMapButton.topAnchor.constraint(equalTo: doctorAddress.bottomAnchor, constant: 6),
            sohowOnMapButton.heightAnchor.constraint(equalToConstant: 16),
            sohowOnMapButton.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20),
            sohowOnMapButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        sohowOnMapButton.addTarget(self, action: #selector(showOnMapPressed), for: .touchUpInside)
    }
    
    @objc func showOnMapPressed() {
        delegate?.showOnMapPressed(lng: doctorLng, lat: doctorLat)
    }
    
    private func configureWaitingTime() {
        NSLayoutConstraint.activate([
            watingTime.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            watingTime.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            watingTime.topAnchor.constraint(equalTo: sohowOnMapButton.bottomAnchor, constant: 6)
        ])
    }
    private func configureExaminationFees() {
        NSLayoutConstraint.activate([
            examinationFees.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            examinationFees.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            examinationFees.topAnchor.constraint(equalTo: watingTime.bottomAnchor, constant: 6)
        ])
    }
    private func configureDoctorCompanies() {
        doctorcompanies.numberOfLines = 4
        NSLayoutConstraint.activate([
            doctorcompanies.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            doctorcompanies.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            doctorcompanies.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor),
            doctorcompanies.topAnchor.constraint(equalTo: examinationFees.bottomAnchor, constant: 6)
        ])
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
