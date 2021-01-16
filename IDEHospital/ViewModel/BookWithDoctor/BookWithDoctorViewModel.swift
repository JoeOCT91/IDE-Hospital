//
//  VoucherViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import Foundation
protocol BookWithDoctorViewModelProtocol {
    func reviewVoucherSwitch(isOn:Bool) -> Bool
    func reviewAnotherPersonSwitch(isOn:Bool) -> Bool
    func setVoucherAndPatiantName(patientName: String?, voucherCode: String?, bookForAnotherSwitch: Bool, voucherSwitch:Bool)
    func bookDoctorAppointmentRequest()
    func getDoctorID() -> Int
}
class BookWithDoctorViewModel {
    private weak var view:BookWithDoctorVcProtocol?
    private var doctorID:Int!
    private var appointmentTime:String!
    private var doctorName:String!
    private var patientName:String?
    private var voucherCode:String?
    private var bookForAnotherPatientSwitch:Bool = false
    
    init(view:BookWithDoctorVcProtocol, doctorID:Int, doctorName:String, appointmentTime:String) {
        self.view = view
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.appointmentTime = appointmentTime
    }
    
    // MARK:- Private Functions
    private func bookAppointmentWithDoctorAPI(body:VoucherDataBody){
        self.view?.showLoader()
        APIManager.bookAppoinmentWithDoctorAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                self.view?.presentPopupOnMainThread(message: error.localizedDescription, alertType: .withFaliure, delegate: nil)
            case .success(let result):
                if result.code == 202{
                    self.view?.presentPopupOnMainThread(message: L10n.successfulBooking, alertType: .withSuccess, delegate: self.view)
                }
                else if result.code == 401{
                    self.view?.presentPopupOnMainThread(message: result.message!, alertType: .withFaliure, delegate: nil)
                } else {
                    self.view?.presentPopupOnMainThread(message: result.message!, alertType: .withFaliure, delegate: nil)
                }
            }
            self.view?.hideLoader()
        }
    }
    
    private func convertTimestampToDate(timestamp: Double) -> String{
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE, d MMMM yyy, hh:mm at d"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private func extractDayFromDate(date:String) -> (String,String){
        var day:String = ""
        var filtredDate = ""
        for i in 0..<date.count{
            if date[date.index(date.startIndex, offsetBy: i)] == ","{
                day += "\(date[date.index(date.startIndex, offsetBy: i)])"
                break
            }
            day += "\(date[date.index(date.startIndex, offsetBy: i)])"
        }
        for i in day.count..<date.count{
            filtredDate += "\(date[date.index(date.startIndex, offsetBy: i)])"
        }
        print(filtredDate)
        return (day,filtredDate)
    }
}
extension BookWithDoctorViewModel:BookWithDoctorViewModelProtocol{
    func getDoctorID() -> Int {
        return self.doctorID
    }
    
    func bookDoctorAppointmentRequest() {
        let body = VoucherDataBody(doctor_id: doctorID, appointment: appointmentTime, patient_name: patientName, book_for_another: bookForAnotherPatientSwitch, voucher: voucherCode)
        print(body)
        self.bookAppointmentWithDoctorAPI(body: body)
    }
    
    func reviewAnotherPersonSwitch(isOn: Bool) -> Bool {
        if isOn{
            self.view?.changeAnotherPersonTextFieldState(constantValue: -28.5, alpha: 0)
            return false
        }
        else{
            self.view?.changeAnotherPersonTextFieldState(constantValue: 28.5, alpha: 1)
            return true
        }
    }
    
    func reviewVoucherSwitch(isOn: Bool) -> Bool {
        if isOn{
            self.view?.changeVoucherTextFieldState(constantValue: -25, alpha: 0)
            return false
        }
        else{
            self.view?.changeVoucherTextFieldState(constantValue: 25, alpha: 1)
            return true
        }
    }
    
    func setVoucherAndPatiantName(patientName: String?, voucherCode: String?, bookForAnotherSwitch: Bool, voucherSwitch:Bool) {
        guard UserDefaultsManager.shared().token != nil else {
            self.view?.presentPopupOnMainThread(message: L10n.loginFirstToAppointment, alertType: .withFaliure, delegate: nil)
            return
        }
        
        bookForAnotherPatientSwitch = bookForAnotherSwitch
        if voucherSwitch{
            if voucherCode?.count ?? 0 == 0 {
                self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterVoucher, alertType: .withFaliure, delegate: nil)
                return
            } else { self.voucherCode = voucherCode }
        } else { self.voucherCode = nil }
        
        if bookForAnotherPatientSwitch{
            if patientName?.count ?? 0 == 0 {
                self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterPatient, alertType: .withFaliure, delegate: nil)
                return
            }
            else{
                self.patientName = patientName
            }
        }
        else{
            self.patientName = nil
        }
        let timestamp = (appointmentTime! as NSString).doubleValue
        let bookDate =  self.convertTimestampToDate(timestamp: timestamp)
        let dateDetails = self.extractDayFromDate(date: bookDate)
        self.view?.goToConfirmationPopView(doctorName: doctorName, appointmentDate: dateDetails.1,appointmentDay: dateDetails.0)
    }
}
