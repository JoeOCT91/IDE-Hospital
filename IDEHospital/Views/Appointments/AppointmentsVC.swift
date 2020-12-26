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
        
        
        UserDefaultsManager.shared().token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMWE4OTQ3YTEwMTM0ODIyM2ZjZDYyYzg0OGFkZDdlMmZmYzhiMzllZDAwMjdiODU4MzE3M2RiMjA2YmM0MmYzMjUyMjQzYmNkNjQ2YzUwZmYiLCJpYXQiOjE2MDQ0OTMzNDMsIm5iZiI6MTYwNDQ5MzM0MywiZXhwIjoxNjM2MDI5MzQzLCJzdWIiOiI0NSIsInNjb3BlcyI6W119.iYhEyw4yRfd5UNhmzR9F2xzhIYZktHEKT_vKXaaiBgEGx1bQ-oyiEq0nC5dYrJGCirPK86J4MNg-yHidl1wpLEeRUE-YROerT5irXwJkEP9dWVsosIItvMdG0msv4w7G4m3wZVSpaVaaJk2y-6KqZ1BphmuDieNqx4xQqHW1Y8NAu3Dh09lMX6xzMKZwu8kB_MEzv7G10b8n5VwktV31eu8MrBDJhZmwriP2MVM8NVKIgbCdAq3o-xThbqmG479ViS1O3ijJ047ZjkkduZsQuh92NHhrkj2wj5UBpjlYEjLlcKwFvFJcQFA5A0B_ackIJLQktDfw9DGFLLOGEzoi2nVj8tINCG9TbI4-5Y-G8h8kMJCzxybNl1UA-LsMoonM3rY3smQdentBVyM53FYkAbgy9yqAl7Od6A-3D2baEZncCHHq2sZe8eUdS_X07qrOEj1Ip-pc5kLwzwD6vM5y8ptFG_sWmszJo1rNOV6ZoacKD0p_KZU21c9DPjei4VP5Y6y_tilEDxLKfK3wCD_80fmhKjAR5BVpRqHmlWnA1laGx0hGxthXHeg6-5URONR4h0Yiw-ZhzxehIrRmG6vDsofg9jeqSbO4WnTTysCd21xhK1gEvj67DgwwY4Tq_iaZDgRQvKzjRDJpGMysFOS6f4MfbQDAwms7X3EyxmfJk_I"
        appointmentsView.setup()
        self.setupNavigationBar()
        self.setViewControllerTitle(to: L10n.myAppointment, fontColor: .white)
       self.setUpButtonsInNavigationBar()
        appointmentsView.setupTableView(delgate: self, dataSource: self)
        viewModel.getData()
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
        let alertVC = ConfirmationAlert(id: doctorID, message: AlertMessages.appointmentCancel)
        alertVC.delgate = self
        presentAlertOnMainThread(alertVC: alertVC)
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