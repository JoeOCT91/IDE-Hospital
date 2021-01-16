//
//  DoctorProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import Foundation
import SDWebImage

protocol DoctorProfileVMProtocol: ViewModelWithPaginatioProtocol {
    func getAllData()
    func checkForAuth() -> Bool
    func getPreviousDay()
    func getNextDay()
    func getDoctorInformation()
    func getDoctorAppointmentsDate()
    func getReviewData(index: Int) -> Review
    func getDateAppointmentsCount() -> Int
    func favoritePresedProcess(doctorID: Int)
    func prepareForBooking(indexPath: IndexPath)
    func perfromBookingAction(bookingInformation: (Int, String, Int) -> ())
    func checkIfItselected(indexPath: IndexPath, withData: (Bool, ColorName, String) -> ()) -> Bool
    func checkUserToken(doctorID: Int, doctorName: String, appointmentTime:Int)
}

class DoctorProfileVM<T: DoctorProfileVCProtocol>: ViewModelWithPagination<T>, DoctorProfileVMProtocol{

    //View model proprety is in the parent class
    //view proprety in the parent class
    
    private var doctorID: Int
    private var doctorName = String()
    private var appointmentTimestamp = Int()
    private var isFavorite = Bool() // This var sets by getDoctorInformation()
    private var dayIndex = 0
    private var doctorAppointments = [AppointmentDate]()
    private var selectedIndexPath = IndexPath()
    
    init(view: T, doctorID: Int) {
        self.doctorID = doctorID
        super.init()
        self.view = view
        self.child = self
    }
    
    func getAllData() {
        getDoctorInformation()
        getDoctorAppointmentsDate()
        getData()
    }
    
    //This function to prepare view model to perform booking when book button preesed
    internal func  prepareForBooking(indexPath: IndexPath) {
        view?.enableBookButton()
        selectedIndexPath = indexPath
        appointmentTimestamp = doctorAppointments[dayIndex].times[indexPath.row].time
    }
    
    internal func checkIfItselected(indexPath: IndexPath, withData: (Bool, ColorName, String) -> ()) -> Bool {
        let isSelcetd = indexPath == selectedIndexPath ? true : false
        getCellData(indexPath: indexPath) { (isBooked, backgroundColor, doctorname) in
            let colorName = isSelcetd ? ColorName.darkRoyalBlue : backgroundColor
            withData(isBooked, colorName, doctorname)
        }
        return isSelcetd
    }
    //Appointment collection view cell Data
    private func getCellData(indexPath: IndexPath, complation: (Bool, ColorName, String) -> ()){
        let timestamp  = doctorAppointments[dayIndex].times[indexPath.row].time
        let dateFormat = "hh:mm at d"
        let dateString = convertStamp(format: dateFormat, timestamp: timestamp)
        let isBooked = doctorAppointments[dayIndex].times[indexPath.row].booked ? true : false
        let colorName = isBooked ?  ColorName.warmGrey : ColorName.niceBlue
        complation(isBooked, colorName, dateString)
    }
    
    internal func perfromBookingAction(bookingInformation: (Int, String, Int) -> ()) {
        bookingInformation(doctorID, doctorName, appointmentTimestamp)
    }
    
    func checkUserToken(doctorID: Int, doctorName: String, appointmentTime:Int) {
        if checkForAuth() {
            self.view?.openVoucherPopUpView(doctorID: doctorID, doctorName: doctorName, appointmentTime: appointmentTime)
        } else {
            self.view?.openBookingWithAuthPopUpView(doctorID: doctorID, doctorName: doctorName, appointmentTime: appointmentTime)
        }
    }
    
    //this function hide favorite icon from the view when the user is not authrized
    internal func checkForAuth() -> Bool {
        if UserDefaultsManager.shared().token == nil {
            return false
        } else {
            return true
        }
    }
    
    
    //MArk:- Doctor appointments section
    internal func getDoctorAppointmentsDate() {
        APIManager.getAppointmentsDates(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let appointmentsDates):
                if appointmentsDates.success != nil , let data = appointmentsDates.data {
                    self.doctorAppointments = data
                    self.selectedIndexPath = IndexPath()
                    let date = self.convertStamp(format: "EEEE,d MMMM yyy", timestamp: self.doctorAppointments[self.dayIndex].date)
                    self.view?.setupAppointmentData(date: date)
                    self.view?.reloadCollectionData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func convertStamp(format: String, timestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func getDateAppointmentsCount() -> Int{
        if doctorAppointments.isEmpty {
            return 0
        } else {
            return doctorAppointments[dayIndex].times.count
        }
    }
    
    // get next day appointments list and set date label
    func getNextDay(){
        dayIndex += 1
        if dayIndex == doctorAppointments.count { dayIndex -= 1 }
        let date = convertStamp(format: "EEEE,d MMMM yyy", timestamp: doctorAppointments[dayIndex].date)
        view?.setupAppointmentData(date: date)
        view?.disableBookButton()
        selectedIndexPath = IndexPath()
        view?.reloadCollectionData()
    }
    
    // get Pervious day appointments list and set date label
    func getPreviousDay(){
        if dayIndex == 0 { return }
        if dayIndex > 0 {
            dayIndex -= 1
            let date = convertStamp(format: "EEEE,d MMMM yyy", timestamp: doctorAppointments[dayIndex].date)
            view?.disableBookButton()
            view?.setupAppointmentData(date: date)
            selectedIndexPath = IndexPath()
            view?.reloadCollectionData()
        }
    }
    
    // Add to favorite
    func favoritePresedProcess(doctorID: Int){
        if checkForAuth() {
            view?.showLoader()
            APIManager.addOrDeleteDoctorFromFavoriteListAPI(doctorID: doctorID) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    if self.isFavorite {
                        self.view?.isFavorite(imageName: Asset.emptyHeart.name)
                        self.isFavorite = false
                    } else {
                        self.view?.isFavorite(imageName: Asset.redHeart.name)
                        self.isFavorite = true
                    }
                    self.view?.hideLoader()
                case .failure(let error):
                    print(error)
                }
            }
        }  else {
            view?.presentPopupOnMainThread(message: L10n.loginFirst, alertType: .withFaliure, delegate: nil)
        }
    }
    
    //MARK:- Doctor Profile
    internal func getDoctorInformation(){
        APIManager.getDoctorInformation(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let doctorInformation):
                if doctorInformation.success != nil, let data = doctorInformation.data {
                    self.view?.setupDctorInformationData(doctorInformation: data)
                    self.doctorName = data.name
                    if data.isFavorited {
                        self.view?.isFavorite(imageName: Asset.redHeart.name)
                        self.isFavorite = data.isFavorited
                    }
                    self.getDoctorImage(urlString: data.image)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func getDoctorImage(urlString: String){
        guard let url = URL(string: urlString) else { return }
        SDWebImageDownloader().downloadImage(with: url) { [weak self] (image, data, error, bool) in
            guard let self = self else { return }
            guard let data = data else { return }
            SDWebImageCacheSerializer().cacheData(with: image!, originalData: data, imageURL: url)
            self.view?.setDoctorImage(image: data)
        }
    }
    
    //MARK:- Reviews function
    internal func getData() {
        APIManager.getDoctorReviews(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.dataList.append(contentsOf: result.data.items)
                self.isHasMorePages(pagesCount: result.data.totalPages)
                if self.dataList.isEmpty { self.view?.tableViewIsEmpty(message: L10n.noReviews) }
                self.page += 1
                self.view?.reloadTableview()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func getReviewData(index: Int) -> Review {
        return dataList[index] as! Review
    }
    
}
