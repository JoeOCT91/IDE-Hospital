//
//  AppointmentsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation
import SDWebImage

protocol AppointmentsVMProtocol: ViewModelWithPaginatioProtocol {
    func getAppointmentData(indexPath: IndexPath) -> Appointment
    func getDoctorImage(indexPath: IndexPath)
    func getAppointmentDate(indexPath: IndexPath) -> [String]
    func deleteEntry(id: Int)
}

class AppointmentsVM<T: AppointmentsVCProtocol>: ViewModelWithPagination<T>, AppointmentsVMProtocol {
    
    init(view: T){
        super.init()
        self.view = view
        child = self
    }
    
    internal func getAppointmentDate(indexPath: IndexPath) -> [String]{
        let timestamp = Double((dataList[indexPath.row] as! Appointment).appointment)
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE,d MMMM yyy//hh:mm at d"
        let dateString = dateFormatter.string(from: date)
        let dateArr = dateString.components(separatedBy: "//")
        return dateArr
    }
    
    func hasNoDataToPresent(){
        view?.tableViewIsEmpty(message: L10n.youHaveNoAppointemts)
    }
    
    func removeEmptyDataPlaceholder(){
        if !dataList.isEmpty {
            view?.hideEmptyTablePlaceHolder()
        }
        else{
            hasNoDataToPresent()
        }
    }
    
    func getData(){
        if UserDefaultsManager.shared().token != nil {
            view?.showLoader()
            APIManager.getAppointments(page: page) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let appoinmentsData):
                    self.dataList.append(contentsOf: appoinmentsData.data.appointments)
                    self.page += 1
                    self.isHasMorePages(pagesCount: appoinmentsData.data.page)
                    self.removeEmptyDataPlaceholder()
                    self.view?.reloadTableview()
                    self.view?.hideLoader()
                    
                case .failure(let error):
                    self.view?.hideLoader()
                    print(error)
                }
            }
        } else {
            view?.tableViewIsEmpty(message: L10n.loginToShowYourData)
        }
    }
    
    func getDoctorImage(indexPath: IndexPath){
        guard let urlString = (dataList[indexPath.row] as? Appointment )?.doctor.image else { return }
        guard let url = URL(string: urlString) else { return }
        SDWebImageDownloader().downloadImage(with: url) { [weak self] (image, data, error, bool) in
            guard let self = self else { return }
            guard let data = data else { return }
            SDWebImageCacheSerializer().cacheData(with: image!, originalData: data, imageURL: url)
            self.view?.setCellImage(image: data, indexPath: indexPath)
        }
    }
    
    func getAppointmentData(indexPath: IndexPath) -> Appointment{
        return self.dataList[indexPath.row] as! Appointment
    }
    
    func deleteEntry(id: Int){
        
        APIManager.removeAppointment(AppointmentID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.clearData()
                self.getData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
