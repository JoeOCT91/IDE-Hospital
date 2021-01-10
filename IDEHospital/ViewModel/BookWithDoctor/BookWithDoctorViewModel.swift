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
    func bookDoctorAppointmentRequest(voucher:String?, patientName:String?, bookForAnotherSwitch:Bool?)
    func getVoucherCode() -> String?
    func getPatientName() -> String?
}
class BookWithDoctorViewModel {
    private var view:BookWithDoctorVcProtocol?
    private var doctorID:Int!
    private var appointmentTime:String!
    private var doctorName:String!
    private var patientName:String?
    private var voucherCode:String?
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
                print(error.localizedDescription)
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
            case .success(let result):
                if result.code == 202{
                    print(result.success)
                    self.view?.presentSuccessAlert(title: "", message: L10n.successfulBooking)
                }
                else if result.code == 401{
                    
                    self.view?.presentErrorAlert(title: L10n.sorry, message: result.message ?? "")
                    
                }
                else{
                    
                    self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.noVoucher ?? "")
                    
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
    func getVoucherCode() -> String? {
        return self.voucherCode
    }
    
    func getPatientName() -> String? {
        return self.patientName
    }
    
    func bookDoctorAppointmentRequest(voucher: String?, patientName: String?, bookForAnotherSwitch: Bool?) {
        let body = VoucherDataBody(doctor_id: doctorID, appointment: appointmentTime, patient_name: patientName, book_for_another: bookForAnotherSwitch, voucher: voucher)
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
            self.view?.presentErrorAlert(title: "", message: L10n.loginFirst)
            return
        }
        if voucherSwitch{
            if voucherCode?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterVoucher)
                return
            }
        }
        else{
            self.voucherCode = nil
        }
        if bookForAnotherSwitch{
            if patientName?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterPatient)
                return
            }
        }
        else{
            self.patientName = nil
        }
        let timestamp = (appointmentTime! as NSString).doubleValue
        var bookDate =  self.convertTimestampToDate(timestamp: timestamp)
        let dateDetails = self.extractDayFromDate(date: bookDate)
        self.view?.goToConfirmationPopView(doctorName: doctorName, appointmentDate: dateDetails.1,appointmentDay: dateDetails.0)
    }
}
