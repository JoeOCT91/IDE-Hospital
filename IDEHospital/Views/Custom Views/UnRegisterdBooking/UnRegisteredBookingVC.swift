//
//  UnRegisteredBookingVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import UIKit
protocol UnRegisterdbookingVcProtocol: PopUPsProtocol {
    func changeVoucherCheckBoxState(alpha: CGFloat, backgorundImage: UIImage, constant: CGFloat)
    func changeAnotherPatientCheckBoxState(alpha: CGFloat, backgorundImage: UIImage)
    func showLoader()
    func hideLoader()
    func sendRegisterData()
    func sendLoginData()
    func openRegisterPopUpView()
    func openLoginPopUpView()
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
        self.hideKeyboardWhenTappedAround()
    }
    
    override func okButtonPressed() {
        self.delegate?.reloadData()
        self.dismiss(animated: true)
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
    // Responsible for animating the view after changing top value constraint
    private func animateView(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.unRegisterdBookingView.layoutIfNeeded()
        }, completion: nil)
    }
    // To Reset Voucher and Another Patient Bool Values to False after switching between Register and Login PopUpViews
    private func makeCheckBoxValuesOnInitialState(){
        voucherCheckBoxState = false
        anotherPatientCheckBoxState = false
    }
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        self.viewModel.decideWhichPopUpViewToOpen(isOnRegisterView: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.viewModel.decideWhichPopUpViewToOpen(isOnRegisterView: false)
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.presentAlertOnMainThread(message: L10n.youWantCancelAppoinment, delegate: self)
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
        termsAndConditionsVC.setupBackWithDismiss()
        let navigation = UINavigationController(rootViewController: termsAndConditionsVC)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}
extension UnRegisteredBookingVC: UnRegisterdbookingVcProtocol{
    func openRegisterPopUpView() {
        self.unRegisterdBookingView.changeToRegisterViewPopUpState()
        isOnRegisterView = true
        makeCheckBoxValuesOnInitialState()
        self.animateView()
    }
    
    func openLoginPopUpView() {
        self.unRegisterdBookingView.changeToLoginViewPopUpState()
        isOnRegisterView = false
        makeCheckBoxValuesOnInitialState()
        self.animateView()
    }
    
    func sendRegisterData() {
        self.viewModel.validateBookingData(name: unRegisterdBookingView.nameTextField.text, email: unRegisterdBookingView.emailTextField.text, password: unRegisterdBookingView.passwordTextField.text, mobile: unRegisterdBookingView.mobileTextField.text, bookForAnother: anotherPatientCheckBoxState, patientName: unRegisterdBookingView.anotherPatientTextField.text, usingVoucher: voucherCheckBoxState, voucherCode: unRegisterdBookingView.voucherTextField.text, isOnRegisterPopUpView: true)
    }
    
    func sendLoginData() {
        self.viewModel.validateBookingData(name: nil, email: unRegisterdBookingView.emailTextField.text, password: unRegisterdBookingView.passwordTextField.text, mobile: nil, bookForAnother: anotherPatientCheckBoxState, patientName: unRegisterdBookingView.anotherPatientTextField.text, usingVoucher: voucherCheckBoxState, voucherCode: unRegisterdBookingView.voucherTextField.text, isOnRegisterPopUpView: false)
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
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
}

extension UnRegisteredBookingVC: ConfirmationAlertDelgate {
    func confirmPressed(id: Int) {
        self.dismiss(animated: true){
            self.delegate?.reloadData()
            self.dismiss(animated: true)
        }
    }
}
