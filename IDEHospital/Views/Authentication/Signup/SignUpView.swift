//
//  SignUpView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
import UIKit
class SignUpView:UIView{
    
    // TextFields
    @IBOutlet weak var nameTextField: IDEAHopitalTextField!
    @IBOutlet weak var emailTextField: IDEAHopitalTextField!
    @IBOutlet weak var mobileTextField: IDEAHopitalTextField!
    @IBOutlet weak var choosePasswordTextfield: IDEAHopitalTextField!
    @IBOutlet weak var confirmPasswordTextField: IDEAHopitalTextField!
    // SignUp Button
    @IBOutlet weak var signUpButton: UIButton!
    // Labels
    @IBOutlet weak var byClickingLabel: UILabel!
    
    public func setUp() {
        self.layoutIfNeeded()
        // setBackGroundImage
        self.setupBackground()
        //Setup TextFileds
        self.setUpTextFiled(textFiled: nameTextField, textValue: "", placeholder: L10n.nameTextFieldPlaceholder, imageName: Asset.nameIcon.image, numbersPad: false , emailPad: false, isSecured: false)
        self.setUpTextFiled(textFiled: emailTextField, textValue: "", placeholder: L10n.emailTextFieldPlaceholder, imageName: Asset.emailIcon.image, numbersPad: false , emailPad: true, isSecured: false)
        self.setUpTextFiled(textFiled: mobileTextField, textValue: "", placeholder: L10n.phoneTextFieldPlaceholder, imageName: Asset.phoneIcon.image, numbersPad: true , emailPad: false, isSecured: false)
        self.setUpTextFiled(textFiled: choosePasswordTextfield, textValue: "", placeholder: L10n.choosePasswordPlaceholder, imageName: Asset.passwordIcon.image, numbersPad: false , emailPad: false, isSecured: true)
        self.setUpTextFiled(textFiled: confirmPasswordTextField, textValue: "", placeholder: L10n.confirmPasswordPlaceholder, imageName: Asset.passwordIcon.image, numbersPad: false , emailPad: false, isSecured: true)
        // Setup SignUp Button
        setUpButton(button: signUpButton, buttonTitle: L10n.signUpButton, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
        //setup Lables
        self.setUpLabel(label: byClickingLabel, labelText: L10n.instructions , fontName: FontFamily.PTSans.regular, fontSize: 12, fontColor: .white, changeLatterSpacing: true, latterSpacing:0.60)
    }
    
}
extension SignUpView{
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor, changeLatterSpacing:Bool,latterSpacing:Double) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = fontColor
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
