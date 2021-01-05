//
//  VoucherView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
class VoucherView: UIView {
    // Voucher PopUpView
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var yesSw1: UILabel!
    @IBOutlet weak var noSw1: UILabel!
    @IBOutlet weak var voucherTextField: UITextField!
    @IBOutlet weak var anotherPersonLabel: UILabel!
    @IBOutlet weak var yesSw2: UILabel!
    @IBOutlet weak var noSw2: UILabel!
    @IBOutlet weak var anotherPersonTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var voucherSwitch: UISwitch!
    @IBOutlet weak var nameSwitch: UISwitch!
    @IBOutlet weak var hideVoucherPopUpViewButton: UIButton!
    // Confirmation PopUpView
    @IBOutlet weak var ConfirmationPopUpView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var confirmButton: HospitalButton!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var confirmationPopUpViewCenterXConstraint: NSLayoutConstraint!
    
    func setUp() {
        // SetUp VoucherPopUp View
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        self.layoutIfNeeded()
        //setup Labels
        self.setUpLabel(label: voucherLabel, labelText: L10n.doYouHaveVoucher , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: yesSw1, labelText: L10n.yes , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: noSw1, labelText: L10n.no , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor:ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: anotherPersonLabel, labelText: L10n.anotherPerson , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: yesSw2, labelText: L10n.yes , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: noSw2, labelText: L10n.no , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor:ColorName.darkRoyalBlue.color)
        //Setup TextFileds
        self.setUpTextFiled(textFiled: voucherTextField, textValue: "", placeholder: L10n.enterCode)
        self.setUpTextFiled(textFiled: anotherPersonTextField, textValue: "", placeholder: L10n.enterName)
        //Setup Switches
        setUpSwitch(switches: voucherSwitch,onTintColor:ColorName.darkRoyalBlue.color,backGroundColor:ColorName.darkRoyalBlue.color)
        setUpSwitch(switches: nameSwitch,onTintColor:ColorName.darkRoyalBlue.color,backGroundColor:ColorName.darkRoyalBlue.color)
        
        //SetUp Confirmation PopUp View
        ConfirmationPopUpView.layer.cornerRadius = 10
        ConfirmationPopUpView.layer.masksToBounds = true
        // SetUp Button
        self.setUpButton(button: dismissButton, backgroundImageName: Asset.dismiss.image)
        // SetUp Title Label
        self.setUpLabel(label: titleLabel, labelText: L10n.confirmYourAppointment , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: detailsLabel, labelText: L10n.youAreAboutToBook , fontName: FontFamily.PTSans.regular, fontSize: 15, fontColor: UIColor.black)
    }
}

extension VoucherView{
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = fontColor
    }
//    private func setAttributedMessage(mediumText: String, boldText: String)-> NSAttributedString{
//        let attributedString = NSMutableAttributedString(string: String(format: "%@", mediumText), attributes: [.font: FontFamily.PTSans.regular.font(size: 15), .foregroundColor: UIColor.black])
//        attributedString.append(NSMutableAttributedString(string: String(format: "%@", boldText), attributes: [.font: FontFamily.PTSans.bold.font(size: 15), .foregroundColor: UIColor.black]))
//      return attributedString
//    }
    private func setUpTextFiled(textFiled:UITextField,textValue:String, placeholder:String) {
        textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: FontFamily.PTSans.regular.font(size: 15)])
        textFiled.text = textValue
        textFiled.layer.borderColor = ColorName.darkRoyalBlue.color.cgColor
        textFiled.layer.borderWidth = 2
        textFiled.layer.cornerRadius = 10
        textFiled.layer.masksToBounds = true
        textFiled.alpha = 0.5
        textFiled.isEnabled = false
    }
    private func setUpSwitch(switches:UISwitch,onTintColor:UIColor,backGroundColor:UIColor){
        switches.layer.cornerRadius = 16
        switches.layer.masksToBounds = true
        switches.onTintColor = onTintColor
        switches.backgroundColor = backGroundColor
    }
    
    private func setUpButton(button:UIButton, backgroundImageName:UIImage){
        button.setBackgroundImage(backgroundImageName, for: .normal)
    }
    
}



