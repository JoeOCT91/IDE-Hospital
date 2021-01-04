//
//  VoucherView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
class VoucherView: UIView {
    
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var yesSw1: UILabel!
    @IBOutlet weak var noSw1: UILabel!
    @IBOutlet weak var voucherTextField: UITextField!
    @IBOutlet weak var anotherPersonLabel: UILabel!
    @IBOutlet weak var yesSw2: UILabel!
    @IBOutlet weak var noSw2: UILabel!
    @IBOutlet weak var anotherPersonTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    func setUp() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
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
    }

}

extension VoucherView{
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = fontColor
    }
    
    private func setUpTextFiled(textFiled:UITextField,textValue:String, placeholder:String) {
        textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: FontFamily.PTSans.regular.font(size: 15)])
        textFiled.text = textValue
    }

}



