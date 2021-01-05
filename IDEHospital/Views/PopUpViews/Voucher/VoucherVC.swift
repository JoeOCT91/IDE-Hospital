//
//  VoucherVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
protocol VoucherVcProtocol:class {
    func changeVoucherTextFieldState(enabled:Bool,alpha:CGFloat)
    func changeAnotherPersonTextFieldState(enabled:Bool,alpha:CGFloat)
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
    func goToConfirmationPopView(doctorName:String, appointmentDate:String)
    func closeCurrentView()
}
class VoucherVC: UIViewController {
    
    @IBOutlet var voucherView: VoucherView!
    private var viewModel:VoucherViewModelProtocol!
    private var voucherSwitch:Bool = false
    private var anotherPersonSwitch:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        voucherView.setUp()
    }
    // MARK:- Public Methods
    class func create(doctorID:Int ,doctorName:String, appointmentTime:String) -> VoucherVC {
        let voucherVC: VoucherVC = UIViewController.create(storyboardName: Storyboards.popUpViews, identifier: ViewControllers.voucherVC)
        voucherVC.viewModel = VoucherViewModel(view: voucherVC, doctorID: doctorID, doctorName: doctorName, appointmentTime: appointmentTime)
        return voucherVC
    }
    
    @IBAction func voucherSwitch(_ sender: UISwitch) {
        self.voucherSwitch = viewModel.reviewVoucherSwitch(isOn: sender.isOn)
    }
    
    @IBAction func anotherPersonSwitch(_ sender: UISwitch) {
        self.anotherPersonSwitch = viewModel.reviewAnotherPersonSwitch(isOn: sender.isOn)
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func continueButtonPressed(_ sender: Any) {
        viewModel.setVoucherAndPatiantName(patientName: voucherView.anotherPersonTextField.text, voucherCode:
            voucherView.voucherTextField.text, bookForAnotherSwitch: anotherPersonSwitch , voucherSwitch: voucherSwitch)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        viewModel.bookDoctorAppointmentRequest(voucher: voucherView.voucherTextField.text, patientName: voucherView.anotherPersonTextField.text, bookForAnotherSwitch: anotherPersonSwitch)
    }
}
extension VoucherVC:VoucherVcProtocol{
    func closeCurrentView() {
        self.view.window?.rootViewController?.dismiss(animated: false)
    }

    func goToConfirmationPopView(doctorName: String, appointmentDate: String) {
        voucherView.detailsLabel.text! += appointmentDate + "with Doctor" + doctorName
        voucherView.popUpView.alpha = 0
        voucherView.confirmationPopUpViewCenterXConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.voucherView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func presentSuccessAlert(title: String, message: String) {
        let alertVC = AlertVC(message: message,alertTaype: 2)
        alertVC.alertDelegate = self
        presentAlertOnMainThread(alertVC: alertVC)
    }
    func presentErrorAlert(title:String,message: String) {
        let alertVC = AlertVC(message: message,alertTaype: 1)
        presentAlertOnMainThread(alertVC: alertVC)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func changeVoucherTextFieldState(enabled: Bool, alpha: CGFloat) {
        voucherView.voucherTextField.alpha = alpha
        voucherView.voucherTextField.isEnabled = enabled
    }
    
    func changeAnotherPersonTextFieldState(enabled: Bool, alpha: CGFloat) {
        voucherView.anotherPersonTextField.alpha = alpha
        voucherView.anotherPersonTextField.isEnabled = enabled
    }
}
extension VoucherVC:AlertVcDelegate{
    func okButtonPressed() {
         self.view.window?.rootViewController?.dismiss(animated: false)
    }
}
