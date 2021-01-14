//
//  UnRegisteredBookingVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import UIKit
protocol UnRegisterdbookingVcProtocol {
    func changeRegisterVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat)
    func changeRegisterAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage)
    func changeLoginVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat)
    func changeLoginAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage)
    
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
}
class UnRegisteredBookingVC: UIViewController {
    internal weak var delegate: BookWithDoctorVCDelegate?
    @IBOutlet var unRegisterdBookingView: UnRegiserdBookingView!
    private var viewModel: UnRegisterdBookingViewModel!
    private var registerVoucherCheckBoxState: Bool = false
    private var registerAnotherPatientCheckBoxState: Bool = false
    private var loginVoucherCheckBoxState: Bool = false
    private var loginAnotherPatientCheckBoxState: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unRegisterdBookingView.setUp()
        self.setupNavigationBar(backgroundColor: UIColor.clear)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationBar(backgroundColor: UIColor.clear)
    }
    
    // MARK:- Public Methods
    class func create(doctorID:Int ,doctorName:String, appointmentTime:String) -> UnRegisteredBookingVC {
        let unRegisterdBookingVc = UnRegisteredBookingVC(nibName: ViewControllers.unRegisterdBookingVC, bundle: nil)
        unRegisterdBookingVc.viewModel = UnRegisterdBookingViewModel(view: unRegisterdBookingVc, doctorID: doctorID, doctorName: doctorName, appointmentTime: appointmentTime)
        return unRegisterdBookingVc
    }
    // MARK:- Private Methods
    private func animateView(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.unRegisterdBookingView.layoutIfNeeded()
        }, completion: nil)
    }
    private func dismissCurrretVC(){
        delegate?.reloadData()
        self.dismiss(animated: true)
    }
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        self.unRegisterdBookingView.changeRegisterViewState(algha: 1)
        self.unRegisterdBookingView.changeLoginViewState(alpha: 0)
        self.unRegisterdBookingView.changeRegisterButtonDesign(buttonBackgroundColor: ColorName.white.color, buttonTextColor: ColorName.darkRoyalBlue.color)
        self.unRegisterdBookingView.changeLoginButtonDesign(buttonBackgroundColor: UIColor.clear, buttonTextColor: ColorName.white.color)
        self.unRegisterdBookingView.changeCloseButtonBacgroundImage(buttonBackGroundImage: Asset.whiteCloseButton.image)
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.unRegisterdBookingView.changeRegisterViewState(algha: 0)
        self.unRegisterdBookingView.changeLoginViewState(alpha: 1)
        self.unRegisterdBookingView.changeRegisterButtonDesign(buttonBackgroundColor: UIColor.clear, buttonTextColor: ColorName.white.color)
        self.unRegisterdBookingView.changeLoginButtonDesign(buttonBackgroundColor: ColorName.white.color, buttonTextColor: ColorName.darkRoyalBlue.color)
        self.unRegisterdBookingView.changeCloseButtonBacgroundImage(buttonBackGroundImage: Asset.dismiss.image)
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func registerVoucherCheckBoxButtonPressed(_ sender: Any) {
        registerVoucherCheckBoxState = self.viewModel.checkRegisterVoucherCheckBox(state: registerVoucherCheckBoxState)
        self.animateView()
    }
    
    @IBAction func lgoinVoucherCheckBoxButtonPressed(_ sender: Any) {
        loginVoucherCheckBoxState = self.viewModel.checkLoginVoucherCheckBox(state: loginVoucherCheckBoxState)
        self.animateView()
    }
    
    @IBAction func registerAnotherPatientCheckBoxButtonPressed(_ sender: Any) {
        registerAnotherPatientCheckBoxState = self.viewModel.checkRegisterAnotherPatientCheckBox(state: registerAnotherPatientCheckBoxState)
        self.animateView()
    }
    
    @IBAction func loginAnotherPatientButtonPressed(_ sender: Any) {
        loginAnotherPatientCheckBoxState = self.viewModel.checkLoginAnotherPatientCheckBox(state: loginAnotherPatientCheckBoxState)
        self.animateView()
    }
    
    @IBAction func signUpAndBookButtonPressed(_ sender: Any) {
        self.viewModel.bookWithRegisterRequest(name: unRegisterdBookingView.nameTextField.text, email: unRegisterdBookingView.emailTextField.text, password: unRegisterdBookingView.passwordTextField.text, mobile: unRegisterdBookingView.mobileTextField.text, bookForAnother: registerAnotherPatientCheckBoxState, patientName: unRegisterdBookingView.anotherPatientTextField.text, usingVoucher: registerVoucherCheckBoxState, voucherCode: unRegisterdBookingView.voucherTextField.text)
    }
    
    @IBAction func loginAndBookButtonPressed(_ sender: Any) {
        self.viewModel.bookWithLoginRequest(email: unRegisterdBookingView.loginEmailTextField.text, password: unRegisterdBookingView.loginPasswordTextField.text, bookForAnother: loginAnotherPatientCheckBoxState, patientName: unRegisterdBookingView.loginAnotherPatientTextField.text, usingVoucher: loginVoucherCheckBoxState, voucherCode: unRegisterdBookingView.loginVoucherTextField.text)
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: Any) {
        let termsAndConditionsVC = TermsAndConditionsVC.create()
        termsAndConditionsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
    }
}
extension UnRegisteredBookingVC: UnRegisterdbookingVcProtocol{
    
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
    
    func changeRegisterVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat) {
        self.unRegisterdBookingView.voucherCheckBox.setBackgroundImage(backgorundImage, for: .normal)
        self.unRegisterdBookingView.voucherTextField.alpha = alpha
        self.unRegisterdBookingView.registerVoucherLineView.alpha = alpha
        self.unRegisterdBookingView.anotherPatientTopConstraint.constant = constant
    }
    
    func changeRegisterAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage) {
        self.unRegisterdBookingView.anotherPatientCheckBox.setBackgroundImage(backgorundImage, for: .normal)
        self.unRegisterdBookingView.anotherPatientTextField.alpha = alpha
        self.unRegisterdBookingView.registerPatientLineView.alpha = alpha
    }
    
    func changeLoginVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat) {
        self.unRegisterdBookingView.loginVoucherCheckBox.setBackgroundImage(backgorundImage, for: .normal)
        self.unRegisterdBookingView.loginVoucherTextField.alpha = alpha
        self.unRegisterdBookingView.loginVoucherLineView.alpha = alpha
        self.unRegisterdBookingView.loginAnotherPatientTopConstraint.constant = constant
    }
    
    func changeLoginAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage) {
        self.unRegisterdBookingView.loginAnotherPatientCheckBox.setBackgroundImage(backgorundImage, for: .normal)
        self.unRegisterdBookingView.loginAnotherPatientTextField.alpha = alpha
        self.unRegisterdBookingView.loginPatientLineView.alpha = alpha
    }
    
}
extension UnRegisteredBookingVC:AlertVcDelegate{
    func okButtonPressed() {
        self.dismiss(animated: true)
        self.dismissCurrretVC()
    }
}
extension UnRegisteredBookingVC:ConfirmationAlertDelgate{
    func confirmPressed(id: Int) {
        self.dismiss(animated: true)
        self.dismissCurrretVC()
    }
}
