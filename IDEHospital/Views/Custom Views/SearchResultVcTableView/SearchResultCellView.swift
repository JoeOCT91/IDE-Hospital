//
//  SearchResultCellView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/23/20.
//

import Foundation
import UIKit
class SearchResultCellView:UIView {
    
    
      //MARK:- Public Functions
      func setupView() {
      
      }
      
       //MARK:- Private Functions
      
      private func setUpImageView(imageView:UIImageView, imageName:UIImage) {
               imageView.contentMode = .scaleAspectFill
               imageView.image = imageName
               imageView.frame = UIScreen.main.bounds
           }
        
         private func setUpLabel(label:UILabel, labelText:String, fontName:FontConvertible, fontSize:CGFloat, fontColor:UIColor) {
                label.font = UIFont(font: fontName, size: fontSize)
                label.textAlignment = .center
                label.text = labelText
                label.textColor = fontColor
           }
              
            private func setUpTextFiled(textFiled:UITextField,textValue:String, placeholder:String, imageName:UIImage, imageViewInTextFiled:UIImageView, fontName:FontConvertible, fontSize:CGFloat, tag:Int) {
                
                if imageName == UIImage() {
                     imageViewInTextFiled.image = UIImage()
                }
                else{
                     imageViewInTextFiled.image = imageName
                }
                textFiled.backgroundColor = .clear
                textFiled.borderStyle = .none
                textFiled.text = textValue
                textFiled.font = UIFont(font: fontName, size: fontSize)
                textFiled.textColor = .white
                textFiled.tag = tag
              }
      
            private func setUpButton(button:UIButton, buttonTitle:String, backgroundImageName:UIImage) {
              button.setBackgroundImage(backgroundImageName, for: .normal)
              button.setTitleColor(UIColor.white, for: .normal)
              button.setTitle(buttonTitle, for: .normal)
            }
      
}
