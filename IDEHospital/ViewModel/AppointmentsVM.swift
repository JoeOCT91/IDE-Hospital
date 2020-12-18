//
//  AppointmentsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

protocol AppointmentsVMProtocol: class {
    func getAppointments()
}

class AppointmentsVM: AppointmentsVMProtocol {
    
    private weak var view: AppointmentsVCProtocol?
    
    var appointmentsList = [Appointment]()
    //Pagination
    var page = 1
    var hasMorePages = true
    
    init(view: AppointmentsVCProtocol) {
        self.view = view
    }
    
    func getAppointments(){
        APIManager.getAppointments(page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let appoinmentsData):
                self.appointmentsList = appoinmentsData.data.appointments
                print(self.appointmentsList.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
