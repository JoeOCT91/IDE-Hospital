//
//  DoctorTopView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

class DoctorTopView: UIView {
    
    private var imageWidth: CGFloat {
        let widthRatio: CGFloat = UIScreen.main.bounds.width / 100
        let width: CGFloat = widthRatio * 20.08
        return width
    }

    private let doctorInfo = UIView()
    private let doctorAppointments = UIView()
    private let doctorRating = UIStackView()
    private lazy var doctorImageView = DoctorImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth))
    private let doctorName = HospitalCellLabel(textAlignment: .left, fontSize: 15, font: UIFont(font: FontFamily.PTSans.bold, size: 15))
    
    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(){
        self.addSubview(doctorInfo)
        self.addSubview(doctorAppointments)
        configureDoctorInfoView()
    }
    private func configureDoctorInfoView(){
        doctorInfo.backgroundColor = .black
        doctorInfo.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.centerYAnchor, trailing: self.trailingAnchor)
        doctorInfo.addSubview(doctorImageView)
        ConfigureDoctorImage()
        doctorInfo.addSubview(doctorName)
        configureDoctorName()
        doctorInfo.addSubview(doctorRating)
        configureDoctorRating()
    }
    
    private func ConfigureDoctorImage(){
        doctorImageView.backgroundColor = .white
        NSLayoutConstraint.activate([
            doctorImageView.topAnchor.constraint(equalTo: doctorInfo.topAnchor, constant: 10),
            doctorImageView.leadingAnchor.constraint(equalTo: doctorInfo.leadingAnchor, constant: 25),
            doctorImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor)
        ])
    }
    
    private func configureDoctorName(){
        doctorName.backgroundColor = .blue
        doctorName.text = "Doctor Name test"
        NSLayoutConstraint.activate([
            doctorName.topAnchor.constraint(equalTo: doctorInfo.topAnchor, constant: 17),
            doctorName.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 15),
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
}
