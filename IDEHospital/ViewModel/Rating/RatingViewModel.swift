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
            self.view?.presentErrorAlert(title: "", message: L10n.loginFirst)
            return
        }
        print("view Model DoctorID" + " \(doctorID)")
        self.view?.showLoader()
        APIManager.addDoctorRatingAPI(body: body){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                if response.code == 202{
                    print(response.success)
                    self.view?.presentSuccessAlert(title: "", message: L10n.successRatingAlert)
                }
                else{
                    self.view?.presentErrorAlert(title: "", message: response.message!)
                }
            }
        }
        self.view?.hideLoader()
    }
}
extension RatingViewModel:RatingViewModelProtocol{
    func addDoctorRating(rating: Int?, comment: String?) {
        guard !comment!.isEmpty else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.pleaseEnterComment)
            return
        }
        guard comment!.count > 3 else{
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.commentFieldCountIsSmall)
            return
        }
        guard rating ?? 0 > 0 else {
            self.view?.presentErrorAlert(title: L10n.sorry, message: L10n.noRatings)
            return
        }
        let body = RatingBodyData(doctor_id: doctorID!, rating: rating, comment: comment)
        self.callAddDoctorRating(body: body)
    }
}

