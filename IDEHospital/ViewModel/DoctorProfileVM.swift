//
//  DoctorProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import Foundation
import SDWebImage

protocol DoctorProfileVMProtocol: class {
    func getData()
    func checkForAuth()
    func getPreviousDay()
    func getNextDay()
    func getDoctorReviews()
    func getDoctorInformation()
    func getDoctorAppointmentsDate()
    func getReviewsCount() -> Int
    func getReviewData(index: Int) -> Review
    func getDateAppointmentsCount() -> Int
    func favoritePresedPeroses(doctorID: Int)
    func prepareForBooking(indexPath: IndexPath)
    //func checkIfItselected(indexPath: IndexPath) -> Bool
    func perfromBookingAction(bookingInformation: (Int, String, Int) -> ())
    //func getCellData(indexPath: IndexPath, complation: (Bool, ColorName, String) -> ())
    func checkIfItselected(indexPath: IndexPath, withData: (Bool, ColorName, String) -> ()) -> Bool
}

class DoctorProfileVM: DoctorProfileVMProtocol {
    
    //View model
    private weak var view: DoctorProfileVCProtocol?
    
    private var doctorID: Int
    private var doctorName = String()
    private var appointmentTimestamp = Int()
    private var isFavorite = Bool() // This var sets by getDoctorInformation()
    private var dayIndex = 0
    private var doctorReviews = [Review]()
    private var doctorAppointments = [AppointmentDate]()
    private var selectedIndexPath = IndexPath()
    
    init(view: DoctorProfileVCProtocol, doctorID: Int) {
        self.view = view
        self.doctorID = doctorID
    }
    
    func getData() {
        getDoctorInformation()
        getDoctorAppointmentsDate()
        getDoctorReviews()
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
    
    //this function hide favorite icon from the view when the user is not authrized
    func checkForAuth() {
        if UserDefaultsManager.shared().token == nil {
            view?.favoriteVisability(isHidden: true)
        } else {
            view?.favoriteVisability(isHidden: false)
        }
    }
    
    //MArk:- Doctor appointments section
    internal func getDoctorAppointmentsDate() {
        APIManager.getAppointmentsDates(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let appointmentsDates):
                self.doctorAppointments = appointmentsDates.data
                let date = self.convertStamp(format: "EEEE,d MMMM yyy", timestamp: self.doctorAppointments[self.dayIndex].date)
                self.view?.setupAppointmentData(date: date)
                self.view?.reloadCollectionData()
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
        view?.scrollTobegin()
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
            view?.scrollTobegin()

            selectedIndexPath = IndexPath()
            view?.reloadCollectionData()
        }
    }
    
    // Add to favorite
    func favoritePresedPeroses(doctorID: Int){
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
    }
    
    //MARK:- Doctor reviews and information
    internal func getDoctorInformation(){
        APIManager.getDoctorInformation(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let doctorInformation):
                self.view?.setupDctorInformationData(doctorInformation: doctorInformation.data)
                if doctorInformation.data.isFavorited {
                    self.view?.isFavorite(imageName: Asset.redHeart.name)
                    self.isFavorite = doctorInformation.data.isFavorited
                }
                self.getDoctorImage(urlString: doctorInformation.data.image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func getDoctorReviews() {
        APIManager.getDoctorReviews(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.doctorReviews = result.data.items
                self.view?.reloadTableView()
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
    
    internal func getReviewsCount() -> Int {
        return doctorReviews.count
    }
    
    internal func getReviewData(index: Int) -> Review {
        return doctorReviews[index]
    }
    
}
