//
//  UnRegisterdBookingViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import Foundation
protocol UnRegisterdBookingViewModelProtocol {
    
}
class UnRegisterdBookingViewModel {
    
    private var view: UnRegisterdbookingVcProtocol!
    private var doctorID:Int!
    private var appointmentTime:String!
    private var doctorName:String!
    private var patientName:String?
    private var voucherCode:String?
    private var bookForAnotherPatientSwitch:Bool = false
    init(view:UnRegisterdbookingVcProtocol, doctorID: Int, doctorName: String, appointmentTime: String) {
        self.view = view
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.appointmentTime = appointmentTime
    }
}
extension UnRegisterdBookingViewModel: UnRegisterdBookingViewModelProtocol{
    
}
