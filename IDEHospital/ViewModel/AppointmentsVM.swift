//
//  AppointmentsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

protocol AppointmentsVMProtocol: ViewModelWithPaginatioProtocol {
    func getAppointments()
    func getAppointmentData(indexPath: IndexPath) -> Appointment
}

class AppointmentsVM<T: AppointmentsVCProtocol>: ViewModelWithPagination<T>, AppointmentsVMProtocol {

    //private weak var view: AppointmentsVCProtocol?
    
    //override var dataList: [AnyEncodable] = [Appointment]()
    //Pagination
    //var page = 1
    //var hasMorePages = true
    
    init(view: T){
        super.init()
        self.view = view
    }
    
    func getAppointments(){
        APIManager.getAppointments(page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let appoinmentsData):
                self.dataList = appoinmentsData.data.appointments
                self.view?.reloadTableview()
                print(self.dataList.count)
            case .failure(let error):
                print(error)
            }
        }
    }

    
    func getAppointmentData(indexPath: IndexPath) -> Appointment{
        return self.dataList[indexPath.row] as! Appointment
    }
    
}
