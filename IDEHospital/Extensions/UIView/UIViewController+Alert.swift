//
//  UIViewController+Alert.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

protocol PopUPsProtocol: AlertVcDelegate {
    func presentPopupOnMainThread(message: String, alertType: AlertType)
}

extension UIViewController: PopUPsProtocol {

    internal func presentPopupOnMainThread(message: String, alertType: AlertType) {
        
        let alertVC = AlertVC(message: message, alertType: alertType)
        alertVC.alertDelegate = self
        DispatchQueue.main.async { [self] in
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    @objc internal func okButtonPressed() {
        print("ok Pressed, override this function when you need")
    }
    
    func showAlert(title: String, message: String, okTitle: String = "OK", okHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showSuccessfulAlert(title: String, message: String, okTitle: String = "OK", okHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: goToHome))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func goToHome(alert:UIAlertAction) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
//    func presentAlertOnMainThread(message: String, alertType: AlertType = .withFaliure, delegate: AlertVcDelegate? = nil) {
//        let alertVC = AlertVC(message: message, alertType: alertType)
////        if alertTaype == 2 {
//            alertVC.alertDelegate = delegate
////        }
//        DispatchQueue.main.async { [self] in
//            alertVC.modalPresentationStyle = .overFullScreen
//            alertVC.modalTransitionStyle = .crossDissolve
//            self.present(alertVC, animated: true)
//        }
//    }
    
    func presentAlertOnMainThread(id:Int = 0, message: String, delegate:ConfirmationAlertDelgate){
        let alertVC = ConfirmationAlert(id: id, message: message)
        alertVC.delgate = delegate
        DispatchQueue.main.async { [self] in
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
