//
//  DoctorProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import Foundation

protocol DoctorProfileVMProtocol: class {
    func getDoctorReviews()
}

class DoctorProfileVM: DoctorProfileVMProtocol {
    
    //View model
    private weak var view: DoctorProfileVCProtocol?
    
    var doctorID: Int
    
    init(view: DoctorProfileVCProtocol, doctorID: Int) {
        self.view = view
        self.doctorID = doctorID
    }
    
    internal func getDoctorReviews() {
        APIManager.getDoctorReviews(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
