//
//  RatingViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import Foundation
protocol RatingViewModelProtocol {
    func addDoctorRating(rating:Int?, comment:String?)
}
class RatingViewModel {
    private var view:RatingVcProtocol?
    private var doctorID:Int?
    init(view:RatingVcProtocol,doctorID:Int) {
        self.view = view
        self.doctorID = doctorID
    }
    
    // Private Functions
    // MARK:- Add Doctor Rating
    func callAddDoctorRating(body: RatingBodyData) {
        guard UserDefaultsManager.shared().token != nil else {
            self.view?.presentPopupOnMainThread(message: L10n.loginFirst, alertType: .withFaliure, delegate: nil)
            return
        }
        print("view Model DoctorID" + " \(String(describing: doctorID))")
        self.view?.showLoader()
        APIManager.addDoctorRatingAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                if response.code == 202 {
                    self.view?.presentPopupOnMainThread(message:  L10n.successRatingAlert, alertType: .withSuccess, delegate: self.view)
                } else {
                    self.view?.presentPopupOnMainThread(message: response.message!, alertType: .withFaliure, delegate: nil)
                }
            }
        }
        self.view?.hideLoader()
    }
}

extension RatingViewModel:RatingViewModelProtocol{
    func addDoctorRating(rating: Int?, comment: String?) {
        guard !comment!.isEmpty else{
            self.view?.presentPopupOnMainThread(message: L10n.pleaseEnterComment, alertType: .withFaliure, delegate: nil)
            return
        }
        guard comment!.count > 3 else{
            self.view?.presentPopupOnMainThread(message: L10n.commentFieldCountIsSmall, alertType: .withFaliure, delegate: nil)
            return
        }
        guard rating ?? 0 > 0 else {
            self.view?.presentPopupOnMainThread(message: L10n.noRatings, alertType: .withFaliure, delegate: nil)
            return
        }
        let body = RatingBodyData(doctor_id: doctorID!, rating: rating, comment: comment)
        self.callAddDoctorRating(body: body)
    }
}

