//
//  SearchView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/10/20.
//

import UIKit
class SearchView: UIView {
    // In ViewController
    @IBOutlet weak var mainHeaderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    // In First TextView
    @IBOutlet weak var halfCircle1: UIImageView!
    @IBOutlet weak var heartIcon: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var arrow1: UIImageView!
    // In Second TextView
    @IBOutlet weak var halfCircle2: UIImageView!
    @IBOutlet weak var locationIcon1: UIImageView!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var arrow2: UIImageView!
    // In Third TextView
    @IBOutlet weak var HalfCircle3: UIImageView!
    @IBOutlet weak var locationIcon2: UIImageView!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var arrow3: UIImageView!
    // In Fourth TextView
    @IBOutlet weak var halfCircle4: UIImageView!
    @IBOutlet weak var shildIcon: UIImageView!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var arrow4: UIImageView!
    // In Fifth TextView
    @IBOutlet weak var halfCircle5: UIImageView!
    @IBOutlet weak var doctorIcon: UIImageView!
    @IBOutlet weak var textField5: UITextField!
    //Find a Doctor Button
    @IBOutlet weak var findDoctorButton: UIButton!
    // Picker
    var pickerView = UIPickerView()
    // Main Function To SetUp the Rest of Functions
    public func setUp(){
        // setBackGroundImage
        self.setupBackground()
        // Main Two Labels in the Header
        setUpLabel(label: mainHeaderLabel, labelText: L10n.ideaHospital, fontName: FontFamily.PTSans.bold, fontSize: 40, fontColor: .white, latterSpacing: 0, changeLatterSpacing: false)
        setUpLabel(label: titleLabel, labelText: L10n.ideaEgHospitalTheBestChoice, fontName: FontFamily.PTSans.regular, fontSize: 20, fontColor: .white, latterSpacing: 0.60, changeLatterSpacing: true)
        
        // In First TextView
        setUpImageView(imageView: halfCircle1, imageName: Asset.halfCircle.image)
        setUpImageView(imageView: heartIcon, imageName: Asset.heart.image)
        setUpTextFiled(textFiled: textField1, textValue: "", placeholder: L10n.chooseSpecialists, imageName: Asset.arrow.image, imageViewInTextFiled: arrow1, fontName: FontFamily.PTSans.regular, fontSize: 20, tag: 1)
        
        // In Second TextView
        setUpImageView(imageView: halfCircle2, imageName: Asset.halfCircle.image)
        setUpImageView(imageView: locationIcon1, imageName: Asset.locationIcon.image)
        setUpTextFiled(textFiled: textField2, textValue: "", placeholder: L10n.chooseCity, imageName: Asset.arrow.image, imageViewInTextFiled: arrow2, fontName: FontFamily.PTSans.regular, fontSize: 20, tag: 2)
        
        // In Third TextView
        setUpImageView(imageView: HalfCircle3, imageName: Asset.halfCircle.image)
        setUpImageView(imageView: locationIcon2, imageName: Asset.locationIcon.image)
        setUpTextFiled(textFiled: textField3, textValue: "", placeholder: L10n.chooseRegion, imageName: Asset.arrow.image, imageViewInTextFiled: arrow3, fontName: FontFamily.PTSans.regular, fontSize: 20, tag: 3)
        
        // In Fourth TextView
        setUpImageView(imageView: halfCircle4, imageName: Asset.halfCircle.image)
        setUpImageView(imageView: shildIcon, imageName: Asset.shild.image)
        setUpTextFiled(textFiled: textField4, textValue: "", placeholder: L10n.chooseCompanies, imageName: Asset.arrow.image, imageViewInTextFiled: arrow4, fontName: FontFamily.PTSans.regular, fontSize: 20, tag: 4)
        
        // In Fifth TextView
        setUpImageView(imageView: halfCircle5, imageName: Asset.halfCircle.image)
        setUpImageView(imageView: doctorIcon, imageName:Asset.doctor.image)
        setUpTextFiled(textFiled: textField5, textValue: "", placeholder: L10n.doctorName, imageName: UIImage(), imageViewInTextFiled: UIImageView(), fontName: FontFamily.PTSans.regular, fontSize: 20, tag: 0)
        
        // Last Button In screen
        setUpButton(button: findDoctorButton, buttonTitle: L10n.findDoctor, backgroundImageName: Asset.buttonBar.image, FontName: FontFamily.PTSans.bold, fontSize: 20)
    }
}
extension SearchView{
    private func setUpImageView(imageView:UIImageView, imageName:UIImage) {
        imageView.contentMode = .scaleAspectFill
        imageView.image = imageName
        imageView.frame = UIScreen.main.bounds
    }
    
    private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor, latterSpacing:CGFloat, changeLatterSpacing:Bool) {
        label.font = UIFont(font: fontName, size: fontSize)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = fontColor
        if changeLatterSpacing{
            label.addCharacterSpacing(kernValue: Double(latterSpacing))
        }
    }
    
    private func setUpTextFiled(textFiled:UITextField,textValue:String, placeholder:String, imageName:UIImage, imageViewInTextFiled:UIImageView, fontName:FontConvertible, fontSize:CGFloat, tag:Int) {
        
        if imageName == UIImage() {
            imageViewInTextFiled.image = UIImage()
        }
        else{
            imageViewInTextFiled.image = imageName
        }
        // textFiled.rightView = imageViewInTextFiled
        textFiled.rightViewMode = .always
        textFiled.text = textValue
        textFiled.font = UIFont(font: fontName, size: fontSize)
        //textFiled.textAlignment = .center
        textFiled.backgroundColor = .white
        //textFiled.isEnabled = false
        textFiled.tag = tag
        if tag >= 1{
            textFiled.inputView = pickerView
        }
        
        var myMutableStringTitle = NSMutableAttributedString()
        myMutableStringTitle = NSMutableAttributedString(string:placeholder, attributes: [NSAttributedString.Key.font:UIFont(font: fontName, size: fontSize) ?? 20]) // Font
        myMutableStringTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location:0,length:placeholder.count))    // Color
        textFiled.attributedPlaceholder = myMutableStringTitle
        textFiled.backgroundColor = ColorName.white.color.withAlphaComponent(0.75)
    }
    
    private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage) {
        button.setBackgroundImage(backgroundImageName, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
    }
    private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage, FontName:FontConvertible, fontSize:CGFloat){
        button.setBackgroundImage(backgroundImageName, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(font: FontName, size: fontSize)
    }
}
