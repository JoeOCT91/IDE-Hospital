//
//  VoucherViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import Foundation
protocol VoucherViewModelProtocol {
    func reviewVoucherSwitch(isOn:Bool) -> Bool
    func reviewAnotherPersonSwitch(isOn:Bool) -> Bool
    func setVoucherAndPatiantName(patientName: String?, voucherCode: String?, bookForAnotherSwitch: Bool, voucherSwitch:Bool)
    func bookDoctorAppointmentRequest(voucher:String?, patientName:String?, bookForAnotherSwitch:Bool?)
}
class VoucherViewModel {
    private var view:VoucherVcProtocol?
    private var doctorID:Int!
    private var appointmentTime:String!
    private var doctorName:String!
    init(view:VoucherVcProtocol, doctorID:Int, doctorName:String, appointmentTime:String) {
        self.view = view
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.appointmentTime = appointmentTime
    }
    
    // MARK:- Private Functions
    private func bookAppointmentWithDoctorAPI(body:VoucherDataBody){
        guard UserDefaultsManager.shared().token != nil else {
            self.view?.presentErrorAlert(title: "", message: L10n.loginFirst)
            return
        }
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
                    self.view?.closeCurrentView()
                }
                else{
                    self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.noVoucher ?? "")
                    self.view?.closeCurrentView()
                }
            }
            self.view?.hideLoader()
        }
    }
    
    private func convertTimestampToDate(timestamp: Double) -> String{
           let date = Date(timeIntervalSince1970: timestamp)
           let dateFormatter = DateFormatter()
           dateFormatter.timeZone = .current
           dateFormatter.dateFormat = "EEEE,d MMMM yyy//hh:mm at d"
           let dateString = dateFormatter.string(from: date)
           return dateString
       }
}
extension VoucherViewModel:VoucherViewModelProtocol{
    func bookDoctorAppointmentRequest(voucher: String?, patientName: String?, bookForAnotherSwitch: Bool?) {
        let body = VoucherDataBody(doctor_id: doctorID, appointment: appointmentTime, patient_name: patientName, book_for_another: bookForAnotherSwitch, voucher: voucher)
        self.bookAppointmentWithDoctorAPI(body: body)
    }
    
    func reviewAnotherPersonSwitch(isOn: Bool) -> Bool {
        if isOn{
            self.view?.changeAnotherPersonTextFieldState(enabled: false, alpha: 0.5)
            return false
        }
        else{
            self.view?.changeAnotherPersonTextFieldState(enabled: true, alpha: 1)
            return true
        }
    }
    
    func reviewVoucherSwitch(isOn: Bool) -> Bool {
        if isOn{
            self.view?.changeVoucherTextFieldState(enabled: false, alpha: 0.5)
            return false
        }
        else{
            self.view?.changeVoucherTextFieldState(enabled: true, alpha: 1)
            return true
        }
    }
    func setVoucherAndPatiantName(patientName: String?, voucherCode: String?, bookForAnotherSwitch: Bool, voucherSwitch:Bool) {
    
        if voucherSwitch{
            if voucherCode?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterVoucher)
                return
            }
        }
        if bookForAnotherSwitch{
            if patientName?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterPatient)
                return
            }
        }
        let timestamp = (appointmentTime! as NSString).doubleValue
        let bookDate =  self.convertTimestampToDate(timestamp: timestamp)
        self.view?.goToConfirmationPopView(doctorName: doctorName, appointmentDate: bookDate)
    }
}
