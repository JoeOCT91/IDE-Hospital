//
//  RatingView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
import Cosmos
class RatingView: UIView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitReviewButton: UIButton!
    public func setUp() {
        self.layoutIfNeeded()
        // setBackGroundImage
        self.setupBackground()
        // Setup Header Label
        setUpLabel(label: headerLabel, labelText: L10n.pleaseRateDoctor, fontName: FontFamily.PTSans.bold, fontSize: 14, fontColor: .white)
        //Setup TextFiled
        setUpTextFiled(textFiled: commentTextField, textValue: "", placeholder: L10n.commentPlaceHolder)
        //Setup Button
        ratingView.rating = 0
        setUpButton(button: submitReviewButton, buttonTitle: L10n.submitReview, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
    }
}
extension RatingView{
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
        textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 12)])
        textFiled.text = textValue
        textFiled.font = UIFont(font: FontFamily.PTSans.bold, size: 12)
        textFiled.textColor = .white
        textFiled.backgroundColor = .clear
        textFiled.borderStyle = .none
    }
    
    private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage, FontName:FontConvertible, fontSize:CGFloat){
        button.setBackgroundImage(backgroundImageName, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(font: FontName, size: fontSize)
    }
}
