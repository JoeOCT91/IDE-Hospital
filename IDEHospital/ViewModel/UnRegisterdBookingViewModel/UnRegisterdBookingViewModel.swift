//
//  UnRegisterdBookingViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import Foundation
protocol UnRegisterdBookingViewModelProtocol {
    func checkVoucherCheckBoxState(state:Bool) -> Bool 
    func checkAnotherPatientCheckBoxState(state:Bool) -> Bool
    func checkLoginData(email: String?, password: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?)
    func checkRegisterData(name: String?, email: String?, password: String?, mobile: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?)
    func checkWhichPopUpViewPresented(isOnRegisterPopUpView: Bool)
}
class UnRegisterdBookingViewModel {
    
    private weak var view: UnRegisterdbookingVcProtocol!
    private var doctorID:Int!
    private var appointmentTime:String!
    private var doctorName:String!
    private var currentAnotherPatientName:String?
    private var currentVoucherCode:String?
    init(view:UnRegisterdbookingVcProtocol, doctorID: Int, doctorName: String, appointmentTime: String) {
        self.view = view
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.appointmentTime = appointmentTime
    }
    
    // MARK:- Private Functions
    private func bookingWithRegisterRequest(body: BookWithRegisterBodyData){
        self.view?.showLoader()
        APIManager.bookWithRegisterRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
            case .success(let result):
                if result.code == 201{
                    print(result.success)
                    UserDefaultsManager.shared().token = result.data?.access_token
                    self.view?.presentSuccessAlert(title: "", message: L10n.successfulBooking)
                }
                else if result.code == 422{
                    if result.errors?.email?[0].count ?? 0 > 0{
                        self.view?.presentErrorAlert(title: L10n.sorry, message: result.errors?.email?[0] ?? "")
                    }
                    else if result.errors?.voucher?[0].count ?? 0 > 0{
                        self.view?.presentErrorAlert(title: L10n.sorry, message: result.errors?.voucher?[0] ?? "")
                    }
                }
            }
            self.view?.hideLoader()
        }
    }
    private func bookingWithLoginRequest(body: BookWithLoginBodyData){
        self.view?.showLoader()
        APIManager.bookWithLoginRequestAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.presentErrorAlert(title: L10n.sorry, message: error.localizedDescription)
            case .success(let result):
                if result.code == 201{
                    print(result.success)
                    UserDefaultsManager.shared().token = result.data?.access_token
                    self.view?.presentSuccessAlert(title: "", message: L10n.successfulBooking)
                }
                else if result.code == 401{
                    self.view?.presentErrorAlert(title: L10n.sorry, message: result.message ?? "")
                }
                else{
                    self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.noVoucher)
                }
            }
            self.view?.hideLoader()
        }
    }
    private func checkVoucherCode(isUsingVoucher: Bool, voucherCode: String?) -> Bool{
        if isUsingVoucher{
            if voucherCode?.count ?? 0 == 0 {
                return false
            }
            else{
                self.currentVoucherCode = voucherCode
            }
        }
        else{
            self.currentVoucherCode = nil
        }
        return true
    }
    private func checkAnotherPatient(isBookingForAnotherPateint: Bool, anotherPatientName: String?)-> Bool{
        
        if isBookingForAnotherPateint{
            if anotherPatientName?.count ?? 0 == 0 {
                return false
            }
            else{
                self.currentAnotherPatientName = anotherPatientName
            }
        }
        else{
            self.currentAnotherPatientName = nil
        }
        return true
    }
}

extension UnRegisterdBookingViewModel: UnRegisterdBookingViewModelProtocol{
    func checkWhichPopUpViewPresented(isOnRegisterPopUpView: Bool) {
        if isOnRegisterPopUpView{
            self.view.sendRegisterData()
        }
        else{
            self.view.sendLoginData()
        }
    }
    
    func checkVoucherCheckBoxState(state:Bool) -> Bool {
        if state{
            self.view.changeVoucherCheckBoxState(alpha: 0, backgorundImage: Asset.emptyCheckbox.image, constant: -16)
            return false
        }
        else{
            self.view.changeVoucherCheckBoxState(alpha: 1, backgorundImage: Asset.filledCheckbox.image, constant: 16)
            return true
        }
    }
    
    func checkAnotherPatientCheckBoxState(state: Bool) -> Bool {
        if state{
            self.view.changeAnotherPatientCheckBoxState(alpha: 0, backgorundImage: Asset.emptyCheckbox.image)
            return false
        }
        else{
            self.view.changeAnotherPatientCheckBoxState(alpha: 1, backgorundImage: Asset.filledCheckbox.image)
            return true
        }
    }
    
    func checkLoginData(email: String?, password: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?) {
        
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterEmail)
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.invalidEMailFormat)
            return
        }
        guard !password!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterPassword)
            return
        }
        guard ValidatorManager.shared().isPasswordValid(password!) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.rightPasswordFormatDescription)
            return
        }
        
        guard checkVoucherCode(isUsingVoucher: usingVoucher, voucherCode: voucherCode)else{
            self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterVoucher)
            return
        }
        guard checkAnotherPatient(isBookingForAnotherPateint: bookForAnother, anotherPatientName: patientName) else{
            self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterPatient)
            return
        }
        
        let body = BookWithLoginBodyData(doctor_id: doctorID, appointment: appointmentTime, patient_name: currentAnotherPatientName, book_for_another: bookForAnother, voucher: currentVoucherCode, email: email, password: password)
        self.bookingWithLoginRequest(body: body)
    }
    
    
    func checkRegisterData(name: String?, email: String?, password: String?, mobile: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?) {
        
        guard !name!.isEmpty else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterName)
            return
        }
        guard name!.count >= 3 else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.nameFieldCountIsSmall)
            return
        }
        guard let email = email?.trimmed , !email.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterEmail)
            return
        }
        guard ValidatorManager.shared().isValidEmail(email) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.invalidEMailFormat)
            return
        }
        guard !mobile!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterPhoneNumber)
            return
        }
        guard ValidatorManager.shared().isPhoneNumberValid(phoneNumber: mobile!) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.rightPhoneNumberFormatDescription)
            return
        }
        guard !password!.isEmpty else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterPassword)
            return
        }
        guard ValidatorManager.shared().isPasswordValid(password!) else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.rightPasswordFormatDescription)
            return
        }
        
        guard checkVoucherCode(isUsingVoucher: usingVoucher, voucherCode: voucherCode)else{
            self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterVoucher)
            return
        }
        guard checkAnotherPatient(isBookingForAnotherPateint: bookForAnother, anotherPatientName: patientName) else{
            self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterPatient)
            return
        }
        
        let body = BookWithRegisterBodyData(doctor_id: doctorID, appointment: appointmentTime, patient_name: currentAnotherPatientName, book_for_another: bookForAnother, voucher: currentVoucherCode, name: name, email: email, mobile: mobile, password: password)
        self.bookingWithRegisterRequest(body: body)
    }
}
