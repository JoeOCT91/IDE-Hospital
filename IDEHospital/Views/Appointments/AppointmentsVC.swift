//
//  AppointmentsVC.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import UIKit
import MapKit
import CoreLocation

protocol AppointmentsVCProtocol: PaginationVCProtocol {
    func setCellImage(image: Data, indexPath: IndexPath)
    func reloadTableview()
}

class AppointmentsVC: UIViewController{
    
    @IBOutlet var appointmentsView: AppointmentsView!
    private var viewModel: AppointmentsVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentsView.setup()
        appointmentsView.setupTableView(delgate: self, dataSource: self)
        //viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getData()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.setViewControllerTitle(to: L10n.myAppointment)
        self.setupNavigationBar()
    }
    
    // Public Methods
    class func create() -> AppointmentsVC {
        let appointmentsVC: AppointmentsVC = UIViewController.create(storyboardName: Storyboards.appointments, identifier: ViewControllers.appointmentsVC)
        let viewModel = AppointmentsVM(view: appointmentsVC)
        appointmentsVC.viewModel = viewModel
        return appointmentsVC
    }
}

extension AppointmentsVC: AppointmentsVCProtocol {
    func hideLoader() {
        view.hideLoader()
    }
    func showLoader() {
        view.showLoader()
    }
    func reloadTableview(){
        appointmentsView.appointmentsTableView.reloadData()
    }
    func tableViewIsEmpty(message: String){
        appointmentsView.appointmentsTableView.setNoDataPlaceholder(message)
    }
    func hideEmptyTablePlaceHolder(){
        appointmentsView.appointmentsTableView.removeNoDataPlaceholder()
    }
    
}
extension AppointmentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: Cells.appointment, for: indexPath) as! AppoinmentCell
        cell.setupCellData(cellData: viewModel.getAppointmentData(indexPath: indexPath))
        cell.setupAppointmentDate(dateArr: viewModel.getAppointmentDate(indexPath: indexPath))
        viewModel.getDoctorImage(indexPath: indexPath)
        cell.delgate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    internal func setCellImage(image: Data, indexPath: IndexPath) {
        guard let cell = appointmentsView.appointmentsTableView.cellForRow(at: indexPath) as? AppoinmentCell else { return }
        cell.setDoctorImage(image: image)
        viewModel.scrollObserve(cellCount: indexPath.row)
    }
}

extension AppointmentsVC: ConfirmationAlertDelgate {
    func confirmPressed(id: Int) {
        viewModel.deleteEntry(id: id)
    }
}
extension AppointmentsVC: AppoinmentCellDelgate {
    func cancelAppointment(doctorID: Int) {
        self.presentAlertOnMainThread(id: doctorID, message: AlertMessages.appointmentCancel, delegate: self)
    }
    
    func openDoctorLocation(doctorName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "doctor \(doctorName) clinc"
        mapItem.openInMaps(launchOptions: options)
    }
}
