//
//  UnRegisteredBookingVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import UIKit
protocol UnRegisterdbookingVcProtocol:class {
    func changeVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat)
    func changeAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage)
    func presentSuccessAlert(title:String, message:String)
    func presentErrorAlert(title:String,message: String)
    func showLoader()
    func hideLoader()
    func sendRegisterData()
    func sendLoginData()
}
class UnRegisteredBookingVC: UIViewController {
    internal weak var delegate: BookWithDoctorVCDelegate?
    @IBOutlet weak var unRegisterdBookingView: UnRegiserdBookingView!
    private var viewModel: UnRegisterdBookingViewModel!
    private var voucherCheckBoxState: Bool = false
    private var anotherPatientCheckBoxState: Bool = false
    private var isOnRegisterView: Bool = true
    
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
    private func changeToRegisterViewPopUpState(){
        self.unRegisterdBookingView.changeNameTextFieldState(alpha: 1)
        self.unRegisterdBookingView.changeMobileTextFieldState(alpha: 1)
        self.unRegisterdBookingView.changeEmailTextfiledLocation(constant: 25)
        self.unRegisterdBookingView.changePasswordTextFieldLocation(constant: 25)
        self.unRegisterdBookingView.changeRegisterButtonDesign(buttonBackgroundColor: ColorName.white.color, buttonTextColor: ColorName.darkRoyalBlue.color)
        self.unRegisterdBookingView.changeLoginButtonDesign(buttonBackgroundColor: UIColor.clear, buttonTextColor: ColorName.white.color)
        self.unRegisterdBookingView.changeCloseButtonBacgroundImage(buttonBackGroundImage: Asset.whiteCloseButton.image)
        self.unRegisterdBookingView.changeBookingButtonTitle(title: L10n.signUpAndBook)
        self.unRegisterdBookingView.makeRegisterPopViewOnInitalState()
        voucherCheckBoxState = false
        anotherPatientCheckBoxState = false
        isOnRegisterView = true
        self.animateView()
    }
    private func changeToLoginViewPopUpState(){
        self.unRegisterdBookingView.changeNameTextFieldState(alpha: 0)
        self.unRegisterdBookingView.changeMobileTextFieldState(alpha: 0)
        self.unRegisterdBookingView.changeEmailTextfiledLocation(constant: 25)
        self.unRegisterdBookingView.changePasswordTextFieldLocation(constant: -30)
        self.unRegisterdBookingView.changeRegisterButtonDesign(buttonBackgroundColor: UIColor.clear, buttonTextColor: ColorName.white.color)
        self.unRegisterdBookingView.changeLoginButtonDesign(buttonBackgroundColor: ColorName.white.color, buttonTextColor: ColorName.darkRoyalBlue.color)
        self.unRegisterdBookingView.changeCloseButtonBacgroundImage(buttonBackGroundImage: Asset.dismiss.image)
        self.unRegisterdBookingView.changeBookingButtonTitle(title: L10n.loginAndBook)
        self.unRegisterdBookingView.makeLoginPopViewOnInitalState()
        voucherCheckBoxState = false
        anotherPatientCheckBoxState = false
        isOnRegisterView = false
        self.animateView()
    }
    private func dismissCurrretVC(){
        delegate?.reloadData()
        self.dismiss(animated: true)
    }
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        self.changeToRegisterViewPopUpState()
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.changeToLoginViewPopUpState()
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.presentAlertOnMainThread(id: 0, message: "Are you want to cancel the Appointment!", delegate: self)
    }
    
    @IBAction func voucherCheckBoxButtonPressed(_ sender: Any) {
        voucherCheckBoxState = self.viewModel.checkVoucherCheckBoxState(state: voucherCheckBoxState)
        self.animateView()
    }
    
    @IBAction func anotherPatientCheckBoxButtonPressed(_ sender: Any) {
        anotherPatientCheckBoxState = self.viewModel.checkAnotherPatientCheckBoxState(state: anotherPatientCheckBoxState)
        self.animateView()
    }
    
    @IBAction func bookingWithAuthButtonPressed(_ sender: Any) {
        self.viewModel.checkWhichPopUpViewPresented(isOnRegisterPopUpView: isOnRegisterView)
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: Any) {
        let termsAndConditionsVC = TermsAndConditionsVC.create()
        termsAndConditionsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
    }
}
extension UnRegisteredBookingVC: UnRegisterdbookingVcProtocol{
    func sendRegisterData() {
        self.viewModel.checkRegisterData(name: unRegisterdBookingView.nameTextField.text, email: unRegisterdBookingView.emailTextField.text, password: unRegisterdBookingView.passwordTextField.text, mobile: unRegisterdBookingView.mobileTextField.text, bookForAnother: anotherPatientCheckBoxState, patientName: unRegisterdBookingView.anotherPatientTextField.text, usingVoucher: voucherCheckBoxState, voucherCode: unRegisterdBookingView.voucherTextField.text)
    }
    
    func sendLoginData() {
        self.viewModel.checkLoginData(email: unRegisterdBookingView.emailTextField.text, password: unRegisterdBookingView.passwordTextField.text, bookForAnother: anotherPatientCheckBoxState, patientName: unRegisterdBookingView.anotherPatientTextField.text, usingVoucher: voucherCheckBoxState, voucherCode: unRegisterdBookingView.voucherTextField.text)
    }
    
    func changeVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat) {
        self.unRegisterdBookingView.voucherCheckBox.setBackgroundImage(backgorundImage, for: .normal)
        self.unRegisterdBookingView.voucherTextField.alpha = alpha
        self.unRegisterdBookingView.registerVoucherLineView.alpha = alpha
        self.unRegisterdBookingView.anotherPatientTopConstraint.constant = constant
        self.animateView()
    }
    
    func changeAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage) {
        self.unRegisterdBookingView.anotherPatientCheckBox.setBackgroundImage(backgorundImage, for: .normal)
        self.unRegisterdBookingView.anotherPatientTextField.alpha = alpha
        self.unRegisterdBookingView.registerPatientLineView.alpha = alpha
        self.animateView()
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
