//
//  DoctorProfileVM.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 03/01/2021.
//

import Foundation

protocol DoctorProfileVMProtocol: class {
    func getDoctorReviews()
    func getReviewsCount() -> Int
    func getReviewData(index: Int) -> Review
}

class DoctorProfileVM: DoctorProfileVMProtocol {
    
    //View model
    private weak var view: DoctorProfileVCProtocol?
    
    var doctorID: Int
    var doctorReviews = [Review]()
    
    init(view: DoctorProfileVCProtocol, doctorID: Int) {
        self.view = view
        self.doctorID = doctorID
    }
    
    internal func getDoctorReviews() {
        APIManager.getDoctorReviews(doctorID: doctorID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.doctorReviews = result.data.items
                self.view?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    internal func getReviewsCount() -> Int {
        return doctorReviews.count
    }
     
    internal func getReviewData(index: Int) -> Review {
        return doctorReviews[index]
    }
    
}
