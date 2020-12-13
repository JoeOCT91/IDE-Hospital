//
//  SearchView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/10/20.
//

import UIKit
class SearchView: UIView {

    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    
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
    
    // Main Function To SetUp the Rest of Functions
    public func setUp(){
        
        setUpImageView(imageView: mainBackgroundImageView, imageName: "Background_Image")
     // Main Two Labels in the Header
        setUpLabel(label: mainHeaderLabel, labelText: "IDEA EG HOSPITAL", FontName: "PTSans-Bold", fontSize: 40, fontColor: .white, latterSpacing: 0, changeLatterSpacing: false)
        setUpLabel(label: titleLabel, labelText: "IDEA EG HOSPITAL THE BEST CHOICE", FontName: "PTSans-Regular", fontSize: 20, fontColor: .white, latterSpacing: 0.60, changeLatterSpacing: true)
        
     // In First TextView
               setUpImageView(imageView: halfCircle1, imageName: "Half_Circle")
               setUpImageView(imageView: heartIcon, imageName: "Heart")
        setUpTextFiled(textFiled: textField1, textValue: "", placeholder: "Choose Specialists", imageName: "arrow", imageViewInTextFiled: arrow1, fontName: "PTSans-Regular", fontSize: 20)
        //setUpButton(button: buttonInTextField1, buttonTitle: "", backgroundImageName: "arrow")
        
        // In Second TextView
               setUpImageView(imageView: halfCircle2, imageName: "Half_Circle")
               setUpImageView(imageView: locationIcon1, imageName: "Location_Icon")
        setUpTextFiled(textFiled: textField2, textValue: "", placeholder: "Choose City", imageName: "arrow", imageViewInTextFiled: arrow2, fontName: "PTSans-Regular", fontSize: 20)
        
        // In Third TextView
               setUpImageView(imageView: HalfCircle3, imageName: "Half_Circle")
               setUpImageView(imageView: locationIcon2, imageName: "Location_Icon")
        setUpTextFiled(textFiled: textField3, textValue: "", placeholder: "Choose Region", imageName: "arrow", imageViewInTextFiled: arrow3, fontName: "PTSans-Regular", fontSize: 20)
        
        // In Fourth TextView
               setUpImageView(imageView: halfCircle4, imageName: "Half_Circle")
               setUpImageView(imageView: shildIcon, imageName: "Shild")
        setUpTextFiled(textFiled: textField4, textValue: "", placeholder: "Choose Companies", imageName: "arrow", imageViewInTextFiled: arrow4, fontName: "PTSans-Regular", fontSize: 20)
        
        // In Fifth TextView
               setUpImageView(imageView: halfCircle5, imageName: "Half_Circle")
               setUpImageView(imageView: doctorIcon, imageName: "doctor")
               setUpTextFiled(textFiled: textField5, textValue: "", placeholder: "Doctor Name", imageName: "", imageViewInTextFiled: UIImageView(), fontName: "PTSans-Regular", fontSize: 20)
        
        // Last Button In screen
        setUpButton(button: findDoctorButton, buttonTitle: "Find a doctor", backgroundImageName: "Button Bar", FontName: "PTSans-Bold", fontSize: 20)
    }
    
    
    private func setUpImageView(imageView:UIImageView, imageName:String) {
        imageView.contentMode = .scaleAspectFill
          imageView.image = UIImage(named: imageName)
      }
    
    private func setUpView(view:UIView, viewColor:UIColor) {
        view.backgroundColor = viewColor
    }
      
    private func setUpLabel(label:UILabel, labelText:String, FontName:String, fontSize:Int, fontColor:UIColor, latterSpacing:CGFloat, changeLatterSpacing:Bool) {
        label.font = UIFont(name: FontName, size: CGFloat(fontSize))
       
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = labelText
        label.textColor = fontColor
        if changeLatterSpacing{
          label.addCharacterSpacing(kernValue: Double(latterSpacing))
        }
      }
      
    private func setUpTextFiled(textFiled:UITextField,textValue:String, placeholder:String, imageName:String, imageViewInTextFiled:UIImageView, fontName:String, fontSize:CGFloat) {
        
        if imageName == "" {
             imageViewInTextFiled.image = UIImage()
        }
        else{
             imageViewInTextFiled.image = UIImage(named: imageName)
        }
       // textFiled.rightView = imageViewInTextFiled
        textFiled.rightViewMode = .always
        textFiled.text = textValue
        textFiled.font = UIFont(name: fontName, size: fontSize)
        //textFiled.textAlignment = .center
        textFiled.backgroundColor = .white
          //textFiled.isEnabled = false
        
        var myMutableStringTitle = NSMutableAttributedString()
        myMutableStringTitle = NSMutableAttributedString(string:placeholder, attributes: [NSAttributedString.Key.font:UIFont(name: fontName, size: fontSize) ?? 20]) // Font
        myMutableStringTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location:0,length:placeholder.count))    // Color
        textFiled.attributedPlaceholder = myMutableStringTitle
      }
    
      private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:String) {
         button.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
          button.setTitleColor(UIColor.white, for: .normal)
          button.setTitle(buttonTitle, for: .normal)
        
        
          //button.layer.cornerRadius = button.frame.height / 2
      }
    private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:String, FontName:String, fontSize:Int){
        button.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
                 button.setTitleColor(UIColor.white, for: .normal)
                 button.setTitle(buttonTitle, for: .normal)
                 button.titleLabel?.font = UIFont(name: FontName, size: CGFloat(fontSize))
           //button.layer.cornerRadius = button.frame.height / 2
         }
}
