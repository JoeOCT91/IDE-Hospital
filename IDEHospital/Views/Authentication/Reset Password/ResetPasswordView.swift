//
//  ResetPasswordView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/26/20.
//

import Foundation
import UIKit
class ResetPasswordView:UIView{
    
    @IBOutlet weak var emailTextField: IDEAHopitalTextField!
    @IBOutlet weak var setNewPasswordButton: UIButton!
    
    public func setUp() {
        self.layoutIfNeeded()
        // setBackGroundImage
        self.setupBackground()
        //Setup TextFiled
        setUpTextFiled(textFiled: emailTextField, textValue: "", placeholder: L10n.emailTextFieldPlaceholder, imageName: Asset.emailIcon.image, numbersPad: false , emailPad: true, isSecured: false)
        setUpButton(button: setNewPasswordButton, buttonTitle: L10n.setNewPassword, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
        
    }
}
extension ResetPasswordView{
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
