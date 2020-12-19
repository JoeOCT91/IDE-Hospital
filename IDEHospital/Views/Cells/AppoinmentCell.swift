//
//  AppoinmentCell.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import UIKit

@objc protocol AppoinmentCellDelgate: class {
    func viewDoctorProfile(doctorID : Int)
    func deleteFavorite(doctorID : Int)
}

class AppoinmentCell: UITableViewCell {
    
    
    //Cell Delgate property
    weak var delgate: AppoinmentCellDelgate?
    
    //Doctor image width based on screen width
    private var imageWidth: CGFloat {
        let widthRatio: CGFloat = UIScreen.main.bounds.width / 100
        let width: CGFloat = widthRatio * 20.08
        return width
    }
    
    //ContentView Sub Views
    private let containerView = UIView()
    private let sepratorView = UIView()
    // ContainerView Sub Views
    private let doctorRating = UIStackView()
    private lazy var doctorImage = DoctorImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth))
    //Labels Views
    private let doctorName = HospitalCellLabel(textAlignment: .left, fontSize: 15, font: UIFont(font: FontFamily.PTSans.bold, size: 15))
    private let doctorBio = HospitalCellLabel(textAlignment: .left, fontSize: 10, font: UIFont(font: FontFamily.PTSans.regular, size: 10))
    
    private let appoinmentTime = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let appoinmentDate = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    
    private let secondBio = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    private let reviewsCount = HospitalCellLabel(textAlignment: .left, fontSize: 12, font: UIFont(font: FontFamily.PTSans.regular, size: 12))
    //Buttons Views
    private let viewProfileButton = HospitalButton(frame: .zero, tittle: "View Profile")
    private let deleteButton = UIButton(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellData(cellData: Appointment){
        setupCell()
        //self.tag = cellData.doctorID
        doctorName.text = cellData.doctor.name
        reviewsCount.text = "\(cellData.doctor.reviewsCount) Reviws"
        doctorBio.text = cellData.doctor.bio
        setupRating(rating: cellData.doctor.rating)
        appoinmentTime.text = "10 : 20 PM"
    }
    
    private func setupCell(){
        configureSpretorView()
        self.backgroundColor = .clear
        configureConatinerView()
        configureDoctorImage()
        configureDoctorName()
        configureDeleteButton()
        configureDoctorRating()
        configureReviewsCount()
        configureDoctorBio()
        configureTimeLebal()
    }
    
    func setdoctorImage(image: Data){
        self.doctorImage.image = UIImage(data: image)
    }
    
    private func configureConatinerView() {
        //sub views
        contentView.addSubview(containerView)
        containerView.addSubview(doctorName)
        containerView.addSubview(doctorImage)
        containerView.addSubview(deleteButton)
        containerView.addSubview(doctorRating)
        containerView.addSubview(reviewsCount)
        containerView.addSubview(doctorBio)
        containerView.addSubview(appoinmentTime)
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
        for i in 0 ..< rating {
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
            //doctorRating.bottomAnchor.constraint(equalTo: doctorBio.topAnchor),
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
    private func configureDoctorBio() {
        doctorBio.numberOfLines = 4
        NSLayoutConstraint.activate([
            doctorBio.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor),
            doctorBio.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            doctorBio.topAnchor.constraint(equalTo: doctorRating.bottomAnchor, constant: 16),
            //doctorBio.bottomAnchor.constraint(equalTo: appoinmentTime.topAnchor)
        ])
    }
    
    private func configureTimeLebal() {
        NSLayoutConstraint.activate([
            appoinmentTime.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            appoinmentTime.topAnchor.constraint(equalTo: doctorBio.bottomAnchor, constant: 5),
            appoinmentTime.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor),

        ])
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

