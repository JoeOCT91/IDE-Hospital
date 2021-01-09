//
//  FavoritesCell.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import UIKit

@objc protocol FavoritesCellDelgate: class {
    func viewDoctorProfile(doctorID : Int)
    func deleteFavorite(doctorID : Int)
}

class FavoritesCell: UITableViewCell {
    
    //Cell Delgate property
     weak var delgate: FavoritesCellDelgate?
    
    //Doctor image width based on screen width
    private var imageWidth: CGFloat {
        let widthRatio: CGFloat = UIScreen.main.bounds.width / 100
        let width: CGFloat = widthRatio * 20.08
        return width
    }
    private let shadowView = UIView(frame: .zero)
    //ContentView Sub Views
    private let containerView = UIView()
    private let sepratorView = UIView()
    // ContainerView Sub Views
    private let doctorRating = UIStackView()
    private lazy var doctorImage = DoctorImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth))
    //Labels Views
    private let doctorName = HospitalCellLabel(textAlignment: .left, fontSize: 15, font: UIFont(font: FontFamily.PTSans.bold, size: 15))
    private let doctorSpecialty = HospitalCellLabel(textAlignment: .left, fontSize: 15, font: UIFont(font: FontFamily.PTSans.bold, size: 15))
    private let watingTime = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let doctorAddress = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let examinationFees = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let secondBio = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let reviewsCount = HospitalCellLabel(textAlignment: .left, fontSize: 12, font: UIFont(font: FontFamily.PTSans.regular, size: 12))
    //Buttons Views
    private let viewProfileButton = HospitalButton(frame: .zero, tittle: "View Profile", color: ColorName.darkRoyalBlue)
    private let deleteButton = UIButton(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.selectedBackgroundView?.frame = CGRect.zero
    }
    //Public Methods
    func setupData(doctor: Doctor){
        setupCell()
        self.tag = doctor.id
        doctorName.text = doctor.name
        doctorSpecialty.text = doctor.specialty
        secondBio.setupContent(imageName: Asset.bioIcon.name, text: doctor.secondBio)
        doctorAddress.setupContent(imageName: Asset.pin.name, text: doctor.address)
        watingTime.setupContent(imageName: Asset.clock.name, text: "Waiting Time : \(doctor.waitingTime) minutes")
        examinationFees.setupContent(imageName: Asset.money3.name, text: "Examination Fees : \(doctor.fees) LE")
        reviewsCount.text = "\(doctor.reviewsCount) Review"
        setupRating(rating: doctor.rating)
    }
    
    func setdoctorImage(image: Data){
        self.doctorImage.image = UIImage(data: image)
    }
    // Private Methods
    private func setupCell(){
        configureSpretorView()
        self.backgroundColor = .clear
        configureConatinerView()
        configureDoctorImage()
        configureDoctorName()
        configureDoctorRating()
        configureReviewsCount()
        configureDoctorSpecialty()
        configureSecondBio()
        configureDoctorAddress()
        configureWaitingTime()
        configureExaminationFees()
        configureViewProfileButton()
        configureDeleteButton()
    }
    
    private func configureConatinerView() {
        //sub views
        contentView.addSubview(containerView)
        containerView.addSubview(doctorImage)
        containerView.addSubview(doctorName)
        containerView.addSubview(secondBio)
        containerView.addSubview(doctorRating)
        containerView.addSubview(reviewsCount)
        containerView.addSubview(doctorSpecialty)
        containerView.addSubview(doctorAddress)
        containerView.addSubview(watingTime)
        containerView.addSubview(examinationFees)
        containerView.addSubview(viewProfileButton)
        containerView.addSubview(deleteButton)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
        ])
        
    }
    
    private func setupRating(rating: Int) {
        let views = doctorRating.arrangedSubviews
        for i in 0 ..< min(5, rating) {
            let starImage = UIImageView(image: Asset.rateStar.image)
            doctorRating.removeArrangedSubview(views[i])
            doctorRating.insertArrangedSubview(starImage, at: i)
        }
    }
    
    private func configureDeleteButton(){
        deleteButton.setImage(Asset.deleteButton.image, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        deleteButton.addTarget(self, action: #selector(deletebutttonPressed), for: .touchUpInside)
    }
    @objc private func deletebutttonPressed(){
        delgate?.deleteFavorite(doctorID: self.tag)
    }
    
    private func configureDoctorImage(){
        doctorImage.backgroundColor = .white
        NSLayoutConstraint.activate([
            doctorImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            doctorImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            doctorImage.widthAnchor.constraint(equalToConstant: imageWidth),
            doctorImage.heightAnchor.constraint(equalTo: doctorImage.widthAnchor)
        ])
    }
    
    private func configureDoctorName(){
        NSLayoutConstraint.activate([
            doctorName.leadingAnchor.constraint(equalTo: doctorImage.trailingAnchor, constant: 15),
            doctorName.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  10),
        ])
    }
    
    private func configureDoctorRating(){
        doctorRating.axis = .horizontal
        doctorRating.spacing = 3
        doctorRating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doctorRating.topAnchor.constraint(equalTo: doctorName.bottomAnchor, constant: 5),
            doctorRating.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor),
        ])
        for _ in doctorRating.arrangedSubviews.count ..< 5 {
            let starImage = UIImageView(image: Asset.emptyStar.image)
            doctorRating.addArrangedSubview(starImage)
        }
    }
    
    private func configureReviewsCount(){
        NSLayoutConstraint.activate([
            reviewsCount.centerYAnchor.constraint(equalTo: doctorRating.centerYAnchor),
            reviewsCount.leadingAnchor.constraint(equalTo: doctorRating.trailingAnchor, constant: 10)
        ])
    }
    
    private func configureDoctorSpecialty() {
        NSLayoutConstraint.activate([
            doctorSpecialty.topAnchor.constraint(equalTo: doctorRating.bottomAnchor,constant: 5),
            doctorSpecialty.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor)
        ])
    }
    
    private func configureSecondBio(){
        NSLayoutConstraint.activate([
            secondBio.topAnchor.constraint(equalTo: doctorImage.bottomAnchor,constant: 21),
            secondBio.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            secondBio.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            secondBio.bottomAnchor.constraint(equalTo: doctorAddress.topAnchor, constant: -10)
        ])
    }
    
    private func configureDoctorAddress(){
        NSLayoutConstraint.activate([
            doctorAddress.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            doctorAddress.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            doctorAddress.bottomAnchor.constraint(equalTo: watingTime.topAnchor, constant: -10)
        ])
    }
    
    private func configureWaitingTime(){
        NSLayoutConstraint.activate([
            watingTime.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            watingTime.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            watingTime.bottomAnchor.constraint(equalTo: examinationFees.topAnchor, constant: -10)
        ])
    }
    
    private func configureExaminationFees(){
        NSLayoutConstraint.activate([
            examinationFees.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            examinationFees.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            examinationFees.bottomAnchor.constraint(equalTo: viewProfileButton.topAnchor, constant: -20)
        ])
    }
    
    private func configureViewProfileButton(){
        let ratio: CGFloat = UIScreen.main.bounds.width / 100
        let width: CGFloat = ratio * 26.5
        NSLayoutConstraint.activate([
            viewProfileButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            viewProfileButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            viewProfileButton.widthAnchor.constraint(equalToConstant: width)
        ])
        viewProfileButton.addTarget(self, action: #selector(viewDoctorProfilePressed), for: .touchUpInside)
    }
    @objc private func viewDoctorProfilePressed(){
        delgate?.viewDoctorProfile(doctorID: self.tag)
    }
    
    private func configureSpretorView(){
        contentView.addSubview(sepratorView)
        sepratorView.backgroundColor = ColorName.white.color
        sepratorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sepratorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sepratorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sepratorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sepratorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
