//
//  SignInView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
import UIKit
class SignInView:UIView{
    
// TextFileds
    @IBOutlet weak var emailTextField: IDEAHopitalTextField!
    @IBOutlet weak var passwordTextField: IDEAHopitalTextField!
// Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var dontHavePasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
     public func setUp() {
       self.layoutIfNeeded()
// setBackGroundImage
       self.setupBackground()
        //Setup TextFileds
        self.setUpTextFiled(textFiled: emailTextField, textValue: "", placeholder: L10n.emailTextFieldPlaceholder, imageName: Asset.emailIcon.image, numbersPad: false , emailPad: true, isSecured: false)
        self.setUpTextFiled(textFiled: passwordTextField, textValue: "", placeholder: L10n.enterPasswordPlaceholder, imageName: Asset.passwordIcon.image, numbersPad: false , emailPad: false, isSecured: true)
        // Setup SignUp Button
        setUpButton(button: loginButton, buttonTitle: L10n.loginButton, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
        setUpButton(button: forgotPasswordButton, buttonTitle: L10n.forgot, backgroundImageName: UIImage(), FontName: FontFamily.PTSans.bold, fontSize: 15)
        setUpButton(button: dontHavePasswordButton, buttonTitle: L10n.donTHavePassword, backgroundImageName: UIImage(), FontName: FontFamily.PTSans.regular, fontSize: 12)
        setUpButton(button: signUpButton, buttonTitle: L10n.signUpButton, backgroundImageName: Asset.greyButtonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
          }
            
        private func setUpTextFiled(textFiled:IDEAHopitalTextField,textValue:String, placeholder:String, imageName:UIImage, numbersPad:Bool, emailPad:Bool, isSecured:Bool) {
              self.layoutIfNeeded()
              textFiled.setup(leftImage: imageName, placeholder: placeholder)
              textFiled.text = textValue
              textFiled.createBottomLine()
              textFiled.isSecureTextEntry = isSecured
              if numbersPad{
                  textFiled.keyboardType = .phonePad
              }
              if emailPad{
                  textFiled.keyboardType = .emailAddress
              }
            }

          private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage, FontName:FontConvertible, fontSize:CGFloat){
              button.setBackgroundImage(backgroundImageName, for: .normal)
              button.setTitleColor(UIColor.white, for: .normal)
              button.setTitle(buttonTitle, for: .normal)
              button.titleLabel?.font = UIFont(font: FontName, size: fontSize)
             }
}
