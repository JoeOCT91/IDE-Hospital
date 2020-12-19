//
//  AppointmentsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

protocol AppointmentsVMProtocol: ViewModelWithPaginatioProtocol {
    func getAppointmentData(indexPath: IndexPath) -> Appointment
}

class AppointmentsVM<T: AppointmentsVCProtocol>: ViewModelWithPagination<T>, AppointmentsVMProtocol {
    
    init(view: T){
        super.init()
        self.view = view
        child = self
    }
    
    func getData(){
        APIManager.getAppointments(page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let appoinmentsData):
                self.dataList.append(contentsOf: appoinmentsData.data.appointments)
                self.page += 1
                self.isHasMorePages(pagesCount: appoinmentsData.data.page)
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
