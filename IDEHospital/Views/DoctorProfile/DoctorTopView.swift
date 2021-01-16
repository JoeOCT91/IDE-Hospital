//
//  DoctorTopView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit

class DoctorTopView: UIView {
    
    weak var delegate: doctorProfileViewDelegate?
    
    private var doctorID =  Int()
    
    private var imageWidth: CGFloat {
        let widthRatio: CGFloat = UIScreen.main.bounds.width / 100
        let width: CGFloat = widthRatio * 20.08
        return width
    }
    //Doctor information views
    private let doctorInfo = UIView()
    private let doctorAppointments = UIView()
    private let doctorRating = UIStackView()
    private lazy var doctorImageView = DoctorImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth))
    private let doctorName = HospitalCellLabel(textAlignment: .left, fontSize: 15, font: UIFont(font: FontFamily.PTSans.bold, size: 15))
    private let doctorBio = HospitalCellLabel(textAlignment: .left, fontSize: 10)
    private let favoriteButton = UIButton()
    private let tapToReviewButton = UIButton()
    
    //Appointments dates views
    private let appointmentsNavigation = UIView()
    private let appointmentDate = UILabel()
    private let leftButton = UIButton()
    private let rightutton = UIButton()
    private let bookNowButton = HospitalButton()
    var appointemtsCollection: UICollectionView!
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public Methods
    func setupData(doctorInformation: DoctorInformation) {
        doctorName.text = doctorInformation.name
        doctorBio.text = doctorInformation.bio
        setupRating(rating: doctorInformation.rating)
        doctorID = doctorInformation.id
    }
    
    func favoriteVisability(isHidden: Bool){
        favoriteButton.isHidden = isHidden
    }
    
    func setDoctorImage(image: Data){
        doctorImageView.image = UIImage(data: image)
    }
    
    func setupAppointmentData(date: String){
        appointmentDate.text = date
    }
    
    func isFavorite(imageName: String){
        favoriteButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
    func enableBookButton(){
        bookNowButton.isEnabled = true
        bookNowButton.backgroundColor = ColorName.darkRoyalBlue.color
    }
    func disableBookButton(){
        bookNowButton.isEnabled = true
        bookNowButton.backgroundColor = ColorName.warmGrey.color
    }
    
    func scrollTobegining(){
        appointemtsCollection.setContentOffset(.zero, animated: true)
    }
    
    
    func setupCollectioView(delgate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        appointemtsCollection.register(AppointmentDateCell.self, forCellWithReuseIdentifier: Cells.appointmentDateCell)
        appointemtsCollection.delegate = delgate
        appointemtsCollection.dataSource = dataSource
    }
    
    func reloadCollectionData() {
        appointemtsCollection.reloadData()
    }
    
    func configureViews(){
        self.addSubview(doctorInfo)
        configureDoctorInfoView()
        self.addSubview(doctorAppointments)
        configureDoctorAppointments()
    }
    
    private func configureDoctorInfoView(){
        doctorInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doctorInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            doctorInfo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            doctorInfo.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
        doctorInfo.addSubview(doctorImageView)
        ConfigureDoctorImage()
        doctorInfo.addSubview(doctorRating)
        configureDoctorRating()
        doctorInfo.addSubview(doctorName)
        configureDoctorName()
        doctorInfo.addSubview(favoriteButton)
        configureFavoriteButton()
        doctorInfo.addSubview(doctorBio)
        configureDoctorBio()
        doctorInfo.addSubview(tapToReviewButton)
        configureTapToReviewButton()
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
        doctorName.text = "Dr."
        NSLayoutConstraint.activate([
            doctorName.bottomAnchor.constraint(equalTo: doctorRating.topAnchor, constant: -8),
            doctorName.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 15),
        ])
    }
    
    private func configureFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(favorieButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setBackgroundImage(Asset.emptyHeart.image, for: .normal)
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: doctorName.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
        ])
    }
    
    @objc private func favorieButtonPressed() {
        delegate?.favoriteButtonPressed(doctorID: doctorID)
    }
    
    private func configureDoctorRating(){
        doctorRating.axis = .horizontal
        doctorRating.spacing = 3
        doctorRating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doctorRating.centerYAnchor.constraint(equalTo: doctorImageView.centerYAnchor),
            doctorRating.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 15),
        ])
        for _ in doctorRating.arrangedSubviews.count ..< 5 {
            let starImage = UIImageView(image: Asset.emptyStar.image)
            doctorRating.addArrangedSubview(starImage)
        }
    }
    private func configureTapToReviewButton() {
        tapToReviewButton.translatesAutoresizingMaskIntoConstraints = false
        tapToReviewButton.addTarget(self, action: #selector(taToReviewPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            tapToReviewButton.leadingAnchor.constraint(equalTo: doctorRating.trailingAnchor, constant: 10),
            tapToReviewButton.centerYAnchor.constraint(equalTo: doctorRating.centerYAnchor, constant: 4),
        ])
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(font: FontFamily.PTSans.bold, size: 10)?.withSize(10) as Any,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle : 1]

        let attributedString = NSMutableAttributedString(string:L10n.tabReview, attributes: attributes)
        tapToReviewButton.setAttributedTitle(attributedString, for: .normal)
    }
    @objc private func taToReviewPressed(){
        delegate?.tapToReviewPressed(doctorID: doctorID)
    }
    
    private func setupRating(rating: Int) {
        let views = doctorRating.arrangedSubviews
        for i in 0 ..< min(rating, 5) {
            let starImage = UIImageView(image: Asset.rateStar.image)
            doctorRating.removeArrangedSubview(views[i])
            doctorRating.insertArrangedSubview(starImage, at: i)
        }
    }
    
    private func configureDoctorBio(){
        doctorBio.numberOfLines = 4
        NSLayoutConstraint.activate([
            doctorBio.topAnchor.constraint(equalTo: doctorRating.bottomAnchor, constant: 6),
            doctorBio.bottomAnchor.constraint(equalTo: doctorInfo.bottomAnchor, constant: -10),
            doctorBio.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor),
            doctorBio.trailingAnchor.constraint(equalTo: doctorInfo.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureDoctorAppointments() {
        doctorAppointments.anchor(top: doctorInfo.bottomAnchor , leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,
                                  padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        configureAppointemtsCollection()
        doctorAppointments.addSubview(appointmentsNavigation)
        configureAppointmentsNavigation()
        doctorAppointments.addSubview(bookNowButton)
        configureBookNowButton()
        configureAppointemtsCollection()
    }
    
    private func configureBookNowButton() {
        bookNowButton.isEnabled = false
        bookNowButton.backgroundColor = ColorName.warmGrey.color
        bookNowButton.setTitle(L10n.book, for: .normal)
        bookNowButton.addTarget(self, action: #selector(bookPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            bookNowButton.topAnchor.constraint(equalTo: appointemtsCollection.bottomAnchor, constant: 0 ),
            bookNowButton.heightAnchor.constraint(equalToConstant: 25),
            bookNowButton.widthAnchor.constraint(equalToConstant: 100),
            bookNowButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc private func bookPressed() {
        delegate?.bookpressed()
    }
    
    //MARK:- Appointments dates navigation
    private func configureAppointmentsNavigation(){
        appointmentsNavigation.translatesAutoresizingMaskIntoConstraints = false
        appointmentsNavigation.backgroundColor = ColorName.darkRoyalBlue.color
        NSLayoutConstraint.activate([
            appointmentsNavigation.topAnchor.constraint(equalTo: doctorAppointments.topAnchor),
            appointmentsNavigation.leadingAnchor.constraint(equalTo: doctorAppointments.leadingAnchor),
            appointmentsNavigation.trailingAnchor.constraint(equalTo: doctorAppointments.trailingAnchor),
            appointmentsNavigation.heightAnchor.constraint(equalToConstant: 30)
        ])
        self.addSubview(leftButton)
        bringSubviewToFront(leftButton)
        configureLeftButton()
        appointmentsNavigation.addSubview(appointmentDate)
        configureAppointmentDate()
        self.addSubview(rightutton)
        configureRightButton()
    }
    
    private func configureAppointmentDate(){
        appointmentDate.translatesAutoresizingMaskIntoConstraints = false
        appointmentDate.textColor = .white
        appointmentDate.font = UIFont(name: FontFamily.PTSans.bold.name, size: 12)
        appointmentDate.font = appointmentDate.font.withSize(12)
        NSLayoutConstraint.activate([
            appointmentDate.centerYAnchor.constraint(equalTo: appointmentsNavigation.centerYAnchor),
            appointmentDate.centerXAnchor.constraint(equalTo: appointmentsNavigation.centerXAnchor)
        ])
    }
    
    private func configureRightButton(){
        rightutton.addTarget(self, action: #selector(nextDayPressed), for: .touchUpInside)
        rightutton.translatesAutoresizingMaskIntoConstraints = false
        rightutton.setBackgroundImage(Asset.dateNext.image, for: .normal)
        NSLayoutConstraint.activate([
            rightutton.trailingAnchor.constraint(equalTo: appointmentsNavigation.trailingAnchor,constant: -25),
            rightutton.centerYAnchor.constraint(equalTo: appointmentsNavigation.centerYAnchor),
        ])
    }
    
    @objc private func nextDayPressed(){
        delegate?.nextDayPressed()
    }
    
    private func configureLeftButton(){
        leftButton.addTarget(self, action: #selector(prevoiousDayPressed), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.setBackgroundImage(Asset.dateBack.image, for: .normal)
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: appointmentsNavigation.leadingAnchor,constant: 25),
            leftButton.centerYAnchor.constraint(equalTo: appointmentsNavigation.centerYAnchor),
        ])
    }
    
    @objc private func prevoiousDayPressed(){
        delegate?.previousDayPressed()
    }
    
    //MARK:- Appointments collection View configurations
    private func configureAppointemtsCollection() {
        appointemtsCollection = UICollectionView(frame: .zero, collectionViewLayout: creatTwoColumnFlowLayout())
        doctorAppointments.addSubview(appointemtsCollection)
        appointemtsCollection.backgroundColor = .clear
        appointemtsCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appointemtsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            appointemtsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            appointemtsCollection.centerYAnchor.constraint(equalTo: doctorAppointments.centerYAnchor),
            appointemtsCollection.heightAnchor.constraint(equalToConstant: 70),
        ])
        appointemtsCollection.showsHorizontalScrollIndicator = false
        appointemtsCollection.allowsMultipleSelection = false
    }
    
    private func creatTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width
        let padding: CGFloat = 15
        let avilableWidth = width - (padding * 3)
        let itemwidth = avilableWidth / 3
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 10, right: padding)
        flowlayout.itemSize = CGSize(width: itemwidth, height: 25)
        flowlayout.scrollDirection = .horizontal
        return flowlayout
    }
}

