//
//  UnRegisterdBookingView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/13/21.
//

import Foundation
import UIKit
class UnRegiserdBookingView: UIView {
    
    // MARK:- Main View
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewBackgroundImage: UIImageView!
    // Buttons Section
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    // TextFields Section
    @IBOutlet weak var nameTextField: IDEAHopitalTextField!
    @IBOutlet weak var nameTextFieldLineView: UIView!
    @IBOutlet weak var emailTextField: IDEAHopitalTextField!
    @IBOutlet weak var mobileTextField: IDEAHopitalTextField!
    @IBOutlet weak var mobileTextFieldLineView: UIView!
    @IBOutlet weak var passwordTextField: IDEAHopitalTextField!
    // Voucher Section
    @IBOutlet weak var voucherCheckBox: UIButton!
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var voucherTextField: IDEAHopitalTextField!
    @IBOutlet weak var registerVoucherLineView: UIView!
    // Another Patient Section
    @IBOutlet weak var anotherPatientCheckBox: UIButton!
    @IBOutlet weak var anotherPatientLabel: UILabel!
    @IBOutlet weak var anotherPatientTextField: IDEAHopitalTextField!
    @IBOutlet weak var registerPatientLineView: UIView!
    // SignUp & Book Button
    @IBOutlet weak var signUpAndBookButton: UIButton!
    // Terms And Conditions Section
    @IBOutlet weak var termsLabel: UILabel!
    // Top Constraints For Animation
    @IBOutlet weak var emailTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var voucherSectionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var anotherPatientTopConstraint: NSLayoutConstraint!
    
    private var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    func setUp() {
        self.layoutIfNeeded()
        // SetUp Main View
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainViewBackgroundImage.image = Asset.blackBackground.image
        // SetUp Main View Buttons
        self.setUpButton(button:registerButton, buttonTitle:L10n.register, backgorundColor: ColorName.white.color, FontName:FontFamily.PTSans.bold, fontSize:20, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpButton(button:loginButton, buttonTitle:L10n.loginButton, backgorundColor: UIColor.clear, FontName:FontFamily.PTSans.bold, fontSize:20, fontColor: ColorName.white.color)
        self.setUpButton(button: closeButton, backgroundImageName: Asset.whiteCloseButton.image)
        
        //MARK:- SetUp Register View
        
        // setup TextFields
        self.setUpTextFiled(textFiled: nameTextField, textValue: "", placeholder: L10n.nameTextFieldPlaceholder, imageName: Asset.nameIcon.image, numbersPad: false , emailPad: false, isSecured: false)
        self.setUpTextFiled(textFiled: emailTextField, textValue: "", placeholder: L10n.emailTextFieldPlaceholder, imageName: Asset.emailIcon.image, numbersPad: false , emailPad: true, isSecured: false)
        self.setUpTextFiled(textFiled: mobileTextField, textValue: "", placeholder: L10n.phoneTextFieldPlaceholder, imageName: Asset.phoneIcon.image, numbersPad: true , emailPad: false, isSecured: false)
        self.setUpTextFiled(textFiled: passwordTextField, textValue: "", placeholder: L10n.choosePasswordPlaceholder, imageName: Asset.passwordIcon.image, numbersPad: false , emailPad: false, isSecured: true)
        //Setup Voucher Section
        self.setUpButton(button: voucherCheckBox, backgroundImageName: Asset.emptyCheckbox.image)
        self.setUpLabel(label: voucherLabel, labelText: L10n.iHaveVoucherCode, fontName: FontFamily.PTSans.bold, fontSize: 12, fontColor: ColorName.white.color)
        self.setUpTextFiled(textFiled: voucherTextField, textValue: "", placeholder: L10n.enterCode, padding: padding, fontSize: 12)
        //Setup Another Patient Section
        self.setUpButton(button: anotherPatientCheckBox, backgroundImageName: Asset.emptyCheckbox.image)
        self.setUpLabel(label: anotherPatientLabel, labelText: L10n.bookForAnotherPatient, fontName: FontFamily.PTSans.bold, fontSize: 12, fontColor: ColorName.white.color)
        self.setUpTextFiled(textFiled: anotherPatientTextField, textValue: "", placeholder: L10n.enterName, padding: padding, fontSize: 12)
        //SetUp SignUp & Book Button
        setUpButton(button: signUpAndBookButton, buttonTitle: L10n.signUpAndBook, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
        //setup Terms And Conditions Section
        self.setUpLabel(label: termsLabel, labelText: L10n.instructions , fontName: FontFamily.PTSans.regular, fontSize: 10.5, fontColor: .white)
        
    }
    //MARK:- Responsible for Show Register PopUp View
    func changeToRegisterViewPopUpState(){
        changeNameTextFieldState(alpha: 1)
        changeMobileTextFieldState(alpha: 1)
        changeEmailTextfiledLocation(constant: 25)
        changePasswordTextFieldLocation(constant: 25)
        changeRegisterButtonDesign(buttonBackgroundColor: ColorName.white.color, buttonTextColor: ColorName.darkRoyalBlue.color)
        changeLoginButtonDesign(buttonBackgroundColor: UIColor.clear, buttonTextColor: ColorName.white.color)
        changeCloseButtonBacgroundImage(buttonBackGroundImage: Asset.whiteCloseButton.image)
        changeBookingButtonTitle(title: L10n.signUpAndBook)
        makeRegisterPopViewOnInitalState()
    }
    //MARK:- Responsible for Show Login PopUp View
    func changeToLoginViewPopUpState(){
        changeNameTextFieldState(alpha: 0)
        changeMobileTextFieldState(alpha: 0)
        changeEmailTextfiledLocation(constant: 25)
        changePasswordTextFieldLocation(constant: -30)
        changeRegisterButtonDesign(buttonBackgroundColor: UIColor.clear, buttonTextColor: ColorName.white.color)
        changeLoginButtonDesign(buttonBackgroundColor: ColorName.white.color, buttonTextColor: ColorName.darkRoyalBlue.color)
        changeCloseButtonBacgroundImage(buttonBackGroundImage: Asset.dismiss.image)
        changeBookingButtonTitle(title: L10n.loginAndBook)
        makeLoginPopViewOnInitalState()
    }
    //MARK:- To Change Name TextField Alpha After Switching Between Login and Register PopUpViews
    func changeNameTextFieldState(alpha: CGFloat){
        nameTextField.alpha = alpha
        nameTextFieldLineView.alpha = alpha
    }
    //MARK:- To Change Mobile TextField Alpha After Switching Between Login and Register PopUpViews
    func changeMobileTextFieldState(alpha: CGFloat){
        mobileTextField.alpha = alpha
        mobileTextFieldLineView.alpha = alpha
    }
    //MARK:- To Change Email Top Value Constraint After Switching Between Login and Register PopUpViews
    func changeEmailTextfiledLocation(constant: CGFloat) {
        emailTextFieldTopConstraint.constant = constant
    }
    //MARK:- To Change Password Top Value Constraint After Switching Between Login and Register PopUpViews
    func changePasswordTextFieldLocation(constant: CGFloat) {
        passwordTextFieldTopConstraint.constant = constant
    }
    //MARK:- To Change Register Button Color After Switching Between Login and Register PopUpViews
    func changeRegisterButtonDesign(buttonBackgroundColor: UIColor, buttonTextColor: UIColor){
        registerButton.backgroundColor = buttonBackgroundColor
        registerButton.setTitleColor(buttonTextColor, for: .normal)
    }
    //MARK:- To Change Login Button Color After Switching Between Login and Register PopUpViews
    func changeLoginButtonDesign(buttonBackgroundColor: UIColor, buttonTextColor: UIColor){
        loginButton.backgroundColor = buttonBackgroundColor
        loginButton.setTitleColor(buttonTextColor, for: .normal)
    }
    //MARK:- To Change Close Button Color After Switching Between Login and Register PopUpViews
    func changeCloseButtonBacgroundImage(buttonBackGroundImage:UIImage) {
        closeButton.setBackgroundImage(buttonBackGroundImage, for: .normal)
    }
    //MARK:- To Change Booking Button Title After Switching Between Login and Register PopUpViews
    func changeBookingButtonTitle(title: String){
        signUpAndBookButton.setTitle(title, for: .normal)
    }
    //MARK:- To Reset All TextFields Text Values After Switching Between Login and Register PopUpViews
    func makeRegisterPopViewOnInitalState(){
        nameTextField.text = ""
        emailTextField.text = ""
        mobileTextField.text = ""
        passwordTextField.text = ""
        makeCheckBoxesOnInitialSate()
    }
    //MARK:- To Reset All TextFields Text Values After Switching Between Login and Register PopUpViews
    func makeLoginPopViewOnInitalState(){
        emailTextField.text = ""
        passwordTextField.text = ""
        makeCheckBoxesOnInitialSate()
    }
    //MARK:- To Reset All Check Boxes To it's Inial State After Switching Between Login and Register PopUpViews
    func makeCheckBoxesOnInitialSate(){
        voucherTextField.text = ""
        anotherPatientTextField.text = ""
        voucherCheckBox.setBackgroundImage(Asset.emptyCheckbox.image, for: .normal)
        anotherPatientCheckBox.setBackgroundImage(Asset.emptyCheckbox.image, for: .normal)
        voucherTextField.alpha = 0
        registerVoucherLineView.alpha = 0
        anotherPatientTopConstraint.constant = -16
        anotherPatientTextField.alpha = 0
        registerPatientLineView.alpha = 0
    }
    
}
extension UnRegiserdBookingView{
    // MARK:- Private Functions
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        //label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = fontColor
    }
    private func setUpTextFiled(textFiled:IDEAHopitalTextField,textValue:String, placeholder:String, imageName:UIImage, numbersPad:Bool, emailPad:Bool, isSecured:Bool) {
        self.layoutIfNeeded()
        textFiled.setup(leftImage: imageName, placeholder: placeholder)
        textFiled.text = textValue
        textFiled.isSecureTextEntry = isSecured
        if numbersPad{
            textFiled.keyboardType = .phonePad
        }
        if emailPad{
            textFiled.keyboardType = .emailAddress
        }
    }
    private func setUpTextFiled(textFiled:IDEAHopitalTextField,textValue:String, placeholder:String, padding:UIEdgeInsets, fontSize:CGFloat) {
        self.layoutIfNeeded()
        textFiled.padding = padding
        textFiled.setup(placeholder: placeholder,fontSize: fontSize)
        textFiled.text = textValue
        textFiled.font = UIFont(font: FontFamily.PTSans.bold, size: fontSize)
    }
    private func setUpButton(button:UIButton, backgroundImageName:UIImage){
        button.setBackgroundImage(backgroundImageName, for: .normal)
    }
    private func setUpButton(button:UIButton, buttonTitle:String, backgorundColor:UIColor, FontName:FontConvertible, fontSize:CGFloat, fontColor: UIColor){
        button.backgroundColor = backgorundColor
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(font: FontName, size: fontSize)
        button.setTitleColor(fontColor, for: .normal)
    }
    private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage, FontName:FontConvertible, fontSize:CGFloat){
        button.setBackgroundImage(backgroundImageName, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(font: FontName, size: fontSize)
    }
    
}
