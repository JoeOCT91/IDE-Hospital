//
//  UnRegisterdBookingViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import Foundation
protocol UnRegisterdBookingViewModelProtocol {
    
    func checkRegisterVoucherCheckBox(state:Bool) -> Bool 
    func checkRegisterAnotherPatientCheckBox(state:Bool) -> Bool
    func checkLoginVoucherCheckBox(state:Bool) -> Bool
    func checkLoginAnotherPatientCheckBox(state:Bool) -> Bool
    func bookWithLoginRequest(email: String?, password: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?)
    func bookWithRegisterRequest(name: String?, email: String?, password: String?, mobile: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?)
}
class UnRegisterdBookingViewModel {
    
    private var view: UnRegisterdbookingVcProtocol!
    private var doctorID:Int!
    private var appointmentTime:String!
    private var doctorName:String!
    private var registerPatientName:String?
    private var registerVoucherCode:String?
    private var loginPatientName:String?
    private var loginVoucherCode:String?
    init(view:UnRegisterdbookingVcProtocol, doctorID: Int, doctorName: String, appointmentTime: String) {
        self.view = view
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.appointmentTime = appointmentTime
    }
}
extension UnRegisterdBookingViewModel: UnRegisterdBookingViewModelProtocol{
    func bookWithLoginRequest(email: String?, password: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?) {
        
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
        if usingVoucher{
            if voucherCode?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterVoucher)
                return
            }
            else{
                self.loginVoucherCode = voucherCode
            }
        }
        else{
            self.loginVoucherCode = nil
        }
        if bookForAnother{
            if patientName?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterPatient)
                return
            }
            else{
                self.loginPatientName = patientName
            }
        }
        else{
            self.loginPatientName = nil
        }
        
        print("Good Login")
    }
    
    func bookWithRegisterRequest(name: String?, email: String?, password: String?, mobile: String?, bookForAnother: Bool, patientName: String?, usingVoucher: Bool, voucherCode: String?) {
        
        guard !name!.isEmpty else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterName)
            return
        }
        guard name!.count > 3 else{
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
        
        if usingVoucher{
            if voucherCode?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterVoucher)
                return
            }
            else{
                self.registerVoucherCode = voucherCode
            }
        }
        else{
            self.registerVoucherCode = nil
        }
        if bookForAnother{
            if patientName?.count ?? 0 == 0 {
                self.view?.presentErrorAlert(title: "", message: L10n.pleaseEnterPatient)
                return
            }
            else{
                self.registerPatientName = patientName
            }
        }
        else{
            self.registerPatientName = nil
        }
        
        print("Good Register")
    }
    
    func checkRegisterVoucherCheckBox(state:Bool) -> Bool {
        if state{
            self.view.changeRegisterVoucherCheckBoxState(alpha: 0, backgorundImage: Asset.emptyCheckbox.image, constant: -16)
            return false
        }
        else{
            self.view.changeRegisterVoucherCheckBoxState(alpha: 1, backgorundImage: Asset.filledCheckbox.image, constant: 16)
            return true
        }
    }
    func checkRegisterAnotherPatientCheckBox(state:Bool) -> Bool {
        if state{
            self.view.changeRegisterAnotherPatientCheckBoxState(alpha: 0, backgorundImage: Asset.emptyCheckbox.image)
            return false
        }
        else{
            self.view.changeRegisterAnotherPatientCheckBoxState(alpha: 1, backgorundImage: Asset.filledCheckbox.image)
            return true
        }
    }
    func checkLoginVoucherCheckBox(state:Bool) -> Bool {
        if state{
            self.view.changeLoginVoucherCheckBoxState(alpha: 0, backgorundImage: Asset.emptyCheckbox.image, constant: -16.5)
            return false
        }
        else{
            self.view.changeLoginVoucherCheckBoxState(alpha: 1, backgorundImage: Asset.filledCheckbox.image, constant: 16.5)
            return true
        }
    }
    func checkLoginAnotherPatientCheckBox(state:Bool) -> Bool {
        if state{
            self.view.changeLoginAnotherPatientCheckBoxState(alpha: 0, backgorundImage: Asset.emptyCheckbox.image)
            return false
        }
        else{
            self.view.changeLoginAnotherPatientCheckBoxState(alpha: 1, backgorundImage: Asset.filledCheckbox.image)
            return true
        }
    }
}
