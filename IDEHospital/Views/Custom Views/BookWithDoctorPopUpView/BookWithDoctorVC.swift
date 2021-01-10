//
//  BookWithDoctorVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/7/21.
//

import UIKit
protocol BookWithDoctorVcProtocol:class {
    func changeVoucherTextFieldState(constantValue:CGFloat,alpha:CGFloat)
    func changeAnotherPersonTextFieldState(constantValue:CGFloat,alpha:CGFloat)
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
    func goToConfirmationPopView(doctorName:String, appointmentDate:String, appointmentDay:String)
}
class BookWithDoctorVC: UIViewController {
    
    @IBOutlet var bookWithDoctorView: BookWithDoctorView!
    var viewModel:BookWithDoctorViewModelProtocol!
    private var voucherSwitch:Bool = false
    private var anotherPersonSwitch:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookWithDoctorView.setUp()
    }
    // MARK:- Public Methods
    class func create(doctorID:Int ,doctorName:String, appointmentTime:String) -> BookWithDoctorVC {
        let bookWithDoctorVC = BookWithDoctorVC(nibName: ViewControllers.bookWithDoctorVC, bundle: nil)
        bookWithDoctorVC.viewModel = BookWithDoctorViewModel(view: bookWithDoctorVC, doctorID: doctorID, doctorName: doctorName, appointmentTime: appointmentTime)
        return bookWithDoctorVC
    }
    
    @IBAction func voucherSwitch(_ sender: UISwitch) {
        self.voucherSwitch = viewModel.reviewVoucherSwitch(isOn: sender.isOn)
    }
    
    @IBAction func anotherPersonSwitch(_ sender: UISwitch) {
        self.anotherPersonSwitch = viewModel.reviewAnotherPersonSwitch(isOn: sender.isOn)
    }
    
    @IBAction func hideVoucherPopUpViewButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
       self.presentAlertOnMainThread(id: 0, message: "Are you want to cancel the Appointment!", delegate: self)
    }
    @IBAction func continueButtonPressed(_ sender: Any) {
        viewModel.setVoucherAndPatiantName(patientName: bookWithDoctorView.anotherPersonTextField.text, voucherCode:
            bookWithDoctorView.voucherTextField.text, bookForAnotherSwitch: anotherPersonSwitch , voucherSwitch: voucherSwitch)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        viewModel.bookDoctorAppointmentRequest(voucher: viewModel.getVoucherCode(), patientName: viewModel.getPatientName(), bookForAnotherSwitch: anotherPersonSwitch)
    }
    //MARK:- Private Methods
    private func animateView(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.bookWithDoctorView.layoutIfNeeded()
        }, completion: nil)
    }
    private func dismissCurrretVC(){
        self.dismiss(animated: true)
    }
    
}
extension BookWithDoctorVC:BookWithDoctorVcProtocol{
    
    func goToConfirmationPopView(doctorName:String, appointmentDate:String, appointmentDay:String) {
        let attributedDate = bookWithDoctorView.setAttributedMessage(mediumText: L10n.youAreAboutToBook + appointmentDay, boldText: appointmentDate,doctorName: doctorName)
        bookWithDoctorView.detailsLabel.attributedText = attributedDate
        bookWithDoctorView.popUpView.alpha = 0
        bookWithDoctorView.hideVoucherPopUpViewButton.alpha = 0
        bookWithDoctorView.confirmationPopUpViewCenterXConstraint.constant = 0
        animateView()
    }
    
    func presentSuccessAlert(title: String, message: String) {
        self.presentAlertOnMainThread(message: message, alertTaype: 2, delegate: self)
    }
    func presentErrorAlert(title:String,message: String) {
        self.presentAlertOnMainThread(message: message, alertTaype: 1, delegate: nil)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func changeVoucherTextFieldState(constantValue:CGFloat, alpha: CGFloat) {
        bookWithDoctorView.voucherTextField.alpha = alpha
        bookWithDoctorView.AnotherPersonTopYLabelConstraint.constant = constantValue
        animateView()
    }
    
    func changeAnotherPersonTextFieldState(constantValue:CGFloat, alpha: CGFloat) {
        bookWithDoctorView.anotherPersonTextField.alpha = alpha
        bookWithDoctorView.continueButtonTopYConstraint.constant = constantValue
        animateView()
    }
}
extension BookWithDoctorVC:AlertVcDelegate{
    func okButtonPressed() {
     self.dismiss(animated: true)
      self.dismissCurrretVC()
    }
}
extension BookWithDoctorVC:ConfirmationAlertDelgate{
    func confirmPressed(id: Int) {
        self.dismiss(animated: true)
        self.dismissCurrretVC()
    }
}
