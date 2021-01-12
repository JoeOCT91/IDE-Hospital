//
//  ContactUsView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/29/20.
//

import Foundation
import UIKit
import KMPlaceholderTextView
class ContactUsView:UIView{
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var nameTextField: IDEAHopitalTextField!
    @IBOutlet weak var emailTextField: IDEAHopitalTextField!
    @IBOutlet weak var mobileTextField: IDEAHopitalTextField!
    @IBOutlet weak var detailsTextArea: KMPlaceholderTextView!
    @IBOutlet weak var contactUsButton: UIButton!
    
    public func setUp() {
        self.layoutIfNeeded()
        // setBackGroundImage
        self.setupBackground()
        //setLable
        self.setUpLabel(label: mainLabel, labelText: L10n.contactUsMainLabel , fontName: FontFamily.PTSans.regular, fontSize: 12, fontColor: .white)
        //Set TextFileds
        self.setUpTextFiled(textFiled: nameTextField, textValue: "", placeholder: L10n.nameTextFieldPlaceholder, imageName: Asset.nameIcon.image, numbersPad: false , emailPad: false)
        self.setUpTextFiled(textFiled: emailTextField, textValue: "", placeholder: L10n.emailTextFieldPlaceholder, imageName: Asset.emailIcon.image, numbersPad: false , emailPad: true)
        self.setUpTextFiled(textFiled: mobileTextField, textValue: "", placeholder: L10n.phoneTextFieldPlaceholder, imageName: Asset.phoneIcon.image, numbersPad: true , emailPad: false)
        // textView
        self.setUpTextArea(textView: detailsTextArea , textValue: "", placeholder: L10n.yourMessage)
        // Last Button in View
        setUpButton(button: contactUsButton, buttonTitle: L10n.send, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
    }
}
extension ContactUsView{
    
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        //label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = fontColor
       
    }
    
    private func setUpTextFiled(textFiled:IDEAHopitalTextField,textValue:String, placeholder:String, imageName:UIImage, numbersPad:Bool, emailPad:Bool) {
        self.layoutIfNeeded()
        textFiled.setup(leftImage: imageName, placeholder: placeholder)
        textFiled.text = textValue
        textFiled.createBottomLine()
        if numbersPad{
            textFiled.keyboardType = .phonePad
        }
        if emailPad{
            textFiled.keyboardType = .emailAddress
        }
    }
    
    private func setUpTextArea(textView:KMPlaceholderTextView,textValue:String,placeholder:String) {
        
        textView.text = textValue
        textView.placeholder = placeholder
        textView.font = UIFont(font: FontFamily.PTSans.bold, size: 15)
        textView.textColor = .white
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1.0;
        textView.layer.cornerRadius = 5.0;
        textView.backgroundColor = .clear
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
    }
    
    private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage, FontName:FontConvertible, fontSize:CGFloat){
        button.setBackgroundImage(backgroundImageName, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(font: FontName, size: fontSize)
    }
}
