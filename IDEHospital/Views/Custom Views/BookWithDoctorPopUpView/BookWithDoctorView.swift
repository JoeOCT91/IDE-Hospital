//
//  BookWithDoctorView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/7/21.
//

import Foundation
import UIKit
class BookWithDoctorView:UIView{
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
    @IBOutlet weak var AnotherPersonTopYLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButtonTopYConstraint: NSLayoutConstraint!
    
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
        self.setUpTextFiled(textFiled: voucherTextField, textValue: nil, placeholder: L10n.enterCode)
        self.setUpTextFiled(textFiled: anotherPersonTextField, textValue: nil, placeholder: L10n.enterName)
        //Setup Switches
        setUpSwitch(switches: voucherSwitch)
        setUpSwitch(switches: nameSwitch)
        
        //SetUp Confirmation PopUp View
        ConfirmationPopUpView.layer.cornerRadius = 10
        ConfirmationPopUpView.layer.masksToBounds = true
        // SetUp Button
        self.setUpButton(button: dismissButton, backgroundImageName: Asset.dismiss.image)
        // SetUp Title Label
        self.setUpLabel(label: titleLabel, labelText: L10n.confirmYourAppointment , fontName: FontFamily.PTSans.bold, fontSize: 15, fontColor: ColorName.darkRoyalBlue.color)
        self.setUpLabel(label: detailsLabel, labelText: L10n.youAreAboutToBook , fontName: FontFamily.PTSans.regular, fontSize: 15, fontColor: UIColor.black)
        // SetUp Constraints
        AnotherPersonTopYLabelConstraint.constant = -25
        continueButtonTopYConstraint.constant = -28.5
        
    }
    func setAttributedMessage(mediumText:String, boldText: String, doctorName:String)-> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: String(format: "%@", mediumText), attributes: [.font: FontFamily.PTSans.regular.font(size: 15), .foregroundColor: UIColor.black])
        attributedString.append(NSMutableAttributedString(string: String(format: "%@", boldText), attributes: [.font: FontFamily.PTSans.bold.font(size: 15), .foregroundColor: UIColor.black]))
        attributedString.append(NSMutableAttributedString(string: String(format: "%@", "with "), attributes: [.font: FontFamily.PTSans.regular.font(size: 15), .foregroundColor: UIColor.black]))
        attributedString.append(NSMutableAttributedString(string: String(format: "%@","Doctor " + doctorName), attributes: [.font: FontFamily.PTSans.bold.font(size: 15), .foregroundColor: UIColor.black]))
        
        return attributedString
    }
}

extension BookWithDoctorView{
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
    
    private func setUpTextFiled(textFiled:UITextField,textValue:String?, placeholder:String) {
        textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: FontFamily.PTSans.regular.font(size: 15)])
        textFiled.text = textValue
        textFiled.layer.borderColor = ColorName.darkRoyalBlue.color.cgColor
        textFiled.layer.borderWidth = 2
        textFiled.layer.cornerRadius = 10
        textFiled.layer.masksToBounds = true
        textFiled.alpha = 0
    }
    private func setUpSwitch(switches:UISwitch){
        switches.tintColor = ColorName.darkRoyalBlue.color
        switches.onTintColor = UIColor.lightGray
        switches.backgroundColor = ColorName.darkRoyalBlue.color
        switches.layer.cornerRadius = 16
        switches.layer.masksToBounds = true
    }
    
    private func setUpButton(button:UIButton, backgroundImageName:UIImage){
        button.setBackgroundImage(backgroundImageName, for: .normal)
    }
    
}



