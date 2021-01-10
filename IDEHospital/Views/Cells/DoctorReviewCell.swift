//
//  DoctorReviewCell.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 04/01/2021.
//

import UIKit

class DoctorReviewCell: UITableViewCell {
    
    private let shadowView = UIView(frame: .zero)
    //ContentView Sub Views
    private let containerView = UIView()
    private let sepratorView = UIView()
    // ContainerView Sub Views
    private let doctorRating = UIStackView()
    //Labels Views
    private let reviewBy = HospitalCellLabel(textAlignment: .left, fontSize: 12, font: UIFont(font: FontFamily.PTSans.bold, size: 12))
    private let reviewBody = HospitalCellLabel(textAlignment: .left, fontSize: 10, font: UIFont(font: FontFamily.PTSans.regular, size: 10))
    private let secondBio = HospitalCellLabel(textAlignment: .left, fontSize: 12)
    
    // Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.selectedBackgroundView?.frame = CGRect.zero
    }
    //Public Methods
    func setupData(doctorReview: Review){
        reviewBy.text = doctorReview.commentedBy
        reviewBody.text = doctorReview.comment
        setupRating(rating: doctorReview.rating)
    }

    // Private Methods
    private func setupCell(){
        self.backgroundColor = .clear
        contentView.addSubview(containerView)
        configureConatinerView()
        contentView.addSubview(reviewBy)
        configureReviewBy()
        contentView.addSubview(reviewBody)
        configureReviewBody()
        contentView.addSubview(doctorRating)
        configureDoctorRating()
        contentView.addSubview(sepratorView)
        configureSpretorView()
    }
    
    private func configureConatinerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
    
    private func setupRating(rating: Int) {
        let views = doctorRating.arrangedSubviews
        for i in 0 ..< min(5, max(0, rating)) {
            let starImage = UIImageView(image: Asset.rateStar.image)
            doctorRating.removeArrangedSubview(views[i])
            doctorRating.insertArrangedSubview(starImage, at: i)
        }
    }
    
    private func configureReviewBy(){
        reviewBy.textColor = ColorName.darkRoyalBlue.color
        NSLayoutConstraint.activate([
            reviewBy.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            reviewBy.topAnchor.constraint(equalTo: containerView.topAnchor),
        ])
    }
    
    private func configureReviewBody() {
        reviewBody.numberOfLines = 2
        reviewBody.textColor = UIColor.black
        NSLayoutConstraint.activate([
            reviewBody.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            reviewBody.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            reviewBody.topAnchor.constraint(equalTo: reviewBy.bottomAnchor, constant: 6),
            reviewBody.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func configureDoctorRating(){
        doctorRating.axis = .horizontal
        doctorRating.spacing = 3
        doctorRating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doctorRating.centerYAnchor.constraint(equalTo: reviewBy.centerYAnchor, constant: -2),
            doctorRating.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        for _ in doctorRating.arrangedSubviews.count ..< 5 {
            let starImage = UIImageView(image: Asset.emptyStar.image)
            doctorRating.addArrangedSubview(starImage)
        }
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
