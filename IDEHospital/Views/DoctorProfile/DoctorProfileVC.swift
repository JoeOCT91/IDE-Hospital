//
//  DoctorProfileVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import UIKit
import CoreLocation
import MapKit


protocol DoctorProfileVCProtocol: class {
    func showLoader()
    func hideLoader()
    func reloadTableView()
    func favoriteVisability(isHidden: Bool)
    func setupAppointmentData(date: String)
    func setupDctorInformationData(doctorInformation: DoctorInformation)
    func setDoctorImage(image: Data)
    func reloadCollectionData()
    func setCellData(time: String, isBooked: Bool, backgroundColor: ColorName, indexPath: IndexPath)
    func isFavorite(imageName: String)
}

class DoctorProfileVC: UIViewController {
    
    // View model
    private var viewModel: DoctorProfileVMProtocol!
    // view
    @IBOutlet var doctorProfileView: DoctorProfileView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getData()
        viewModel.checkForAuth()
        setupBackWithPopup()
        setupNavigationBar()
    }
    
    private func viewsSetup(){
        doctorProfileView.delgate = self
        setViewControllerTitle(to: L10n.searchResult)
        doctorProfileView.setupBackground()
        doctorProfileView.setupTableView(delgate: self, dataSource: self)
        doctorProfileView.setupCollectioView(delgate: self, dataSource: self)
    }
    
    // Public Methods
    class func create(doctorID: Int) -> DoctorProfileVC {
        let doctorProfileVC: DoctorProfileVC = UIViewController.create(storyboardName: Storyboards.doctorProfile, identifier: ViewControllers.doctorProfileVC)
        let viewModel = DoctorProfileVM(view: doctorProfileVC, doctorID: doctorID)
        doctorProfileVC.viewModel = viewModel
        return doctorProfileVC
    }
}
//
extension DoctorProfileVC: DoctorProfileVCProtocol {
    func setCellData(time: String, isBooked: Bool, backgroundColor: ColorName, indexPath: IndexPath) {
        
    }
    
    func isFavorite(imageName: String) {
        doctorProfileView.isFavorite(imageName: imageName)
    }
    
    internal func showLoader() {
        view.showLoader()
    }
    
    internal func hideLoader() {
        view.hideLoader()
    }
    
    internal func reloadTableView() {
        doctorProfileView.reloadTableView()
    }
    
    internal func setupDctorInformationData(doctorInformation: DoctorInformation){
        doctorProfileView.setupDoctorData(doctorInformation: doctorInformation)
    }
    
    internal func setDoctorImage(image: Data){
        doctorProfileView.setupDoctorImage(image: image)
    }
    
    internal func reloadCollectionData() {
        doctorProfileView.reloadCollectionData()
    }
    
    internal func favoriteVisability(isHidden: Bool){
        doctorProfileView.favoriteVisability(isHidden: isHidden)
    }
    func setupAppointmentData(date: String){
        doctorProfileView.setupAppointmentData(date: date)
    }
    
}

extension DoctorProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getReviewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.doctorReviewCell, for: indexPath) as! DoctorReviewCell
        cell.setupData(doctorReview: viewModel.getReviewData(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }

}

extension DoctorProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDateAppointmentsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.appointmentDateCell, for: indexPath) as! AppointmentDateCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AppointmentDateCell else { return }
        viewModel.getCellData(indexPath: indexPath) { (isBooked, backgroundColor, title) in
            cell.setupCell(title: title, backgroundColor: backgroundColor, isBooked: isBooked)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath ) as! AppointmentDateCell
        cell.selected()
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath ) as? AppointmentDateCell else { return }
//        cell.deSelected()
//    }
    
//    func setCellData(time: String, isBooked: Bool, backgroundColor: ColorName, indexPath: IndexPath){
//        guard let cell = doctorProfileView.doctorTopView.appointemtsCollection.cellForItem(at: indexPath) as? AppointmentDateCell else { return }
//        print("cell for this index bath \(indexPath) is \(String(describing: cell)) ")
//
//        //cell.setupCell(title: time, backgroundColor: backgroundColor, isBooked: isBooked)
//        print(cell)
//    }
    
}



extension DoctorProfileVC: doctorProfileViewDelegate {
    
    func showOnMapPressed(lng: Double, lat: Double) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(lat, lng)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "doctor clinc Address"
        mapItem.openInMaps(launchOptions: options)
    }
    
    internal func bookpressed() {
        print("Booked")
    }
    
    internal func favoriteButtonPressed(doctorID: Int) {
        viewModel.favoritePresedPeroses(doctorID: doctorID)
    }
    
    internal func nextDayPressed(){
        viewModel.getNextDay()
    }
    
    internal func previousDayPressed(){
        viewModel.getPreviousDay()
    }
    
    func openDoctorLocation(doctorName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
 
    }
    
    
}
