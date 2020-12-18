//
//  AppointmentsVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

protocol AppointmentsVMProtocol: class {
    
}

class AppointmentsVM: AppointmentsVMProtocol {
    
    private weak var view: AppointmentsVCProtocol?
    
    init(view: AppointmentsVCProtocol) {
        self.view = view
    }
    
}
