//
//  UnRegisteredBookingVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import UIKit
protocol UnRegisterdbookingVcProtocol {
    
}
class UnRegisteredBookingVC: UIViewController {
    
    @IBOutlet var unRegisterdBookingView: UnRegiserdBookingView!
    private var viewModel: UnRegisterdBookingViewModel!
    private var registerVoucherCheckBoxState: Bool = false
    private var registerAnotherPatientCheckBoxState: Bool = false
    private var loginVoucherCheckBoxState: Bool = false
    private var loginAnotherPatientCheckBoxState: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unRegisterdBookingView.setUp()
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
       registerVoucherCheckBoxState = self.unRegisterdBookingView.checkRegisterVoucherCheckBox(state: registerVoucherCheckBoxState)
        self.animateView()
    }
    
    @IBAction func lgoinVoucherCheckBoxButtonPressed(_ sender: Any) {
        loginVoucherCheckBoxState = self.unRegisterdBookingView.checkLoginVoucherCheckBox(state: loginVoucherCheckBoxState)
        self.animateView()
    }
    
    @IBAction func registerAnotherPatientCheckBoxButtonPressed(_ sender: Any) {
      registerAnotherPatientCheckBoxState = self.unRegisterdBookingView.checkRegisterAnotherPatientCheckBox(state: registerAnotherPatientCheckBoxState)
        self.animateView()
    }

    @IBAction func loginAnotherPatientButtonPressed(_ sender: Any) {
        loginAnotherPatientCheckBoxState = self.unRegisterdBookingView.checkLoginAnotherPatientCheckBox(state: loginAnotherPatientCheckBoxState)
        self.animateView()
    }
    
    
    @IBAction func signUpAndBookButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func loginAndBookButtonPressed(_ sender: Any) {
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: Any) {
        
    }
    
    
}
extension UnRegisteredBookingVC: UnRegisterdbookingVcProtocol{
    
}
