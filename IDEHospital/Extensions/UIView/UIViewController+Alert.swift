//
//  UIViewController+Alert.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import UIKit

extension UIViewController {
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
    
    func presentAlertOnMainThread(message: String = "Default message", alertTaype:Int = 1,delegate:AlertVcDelegate?){
        let alertVC = AlertVC(message: message,alertTaype: alertTaype)
        if alertTaype == 2{
            alertVC.alertDelegate = delegate
        }
        DispatchQueue.main.async { [self] in
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }
    
    func presentAlertOnMainThread(id:Int, message: String,delegate:ConfirmationAlertDelgate){
        let alertVC = ConfirmationAlert(id: id, message: message)
        alertVC.delgate = delegate
        DispatchQueue.main.async { [self] in
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }
}
