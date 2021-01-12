//
//  IDEAHopitalTextField.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/19/20.
//

import Foundation
import UIKit
@IBDesignable
class IDEAHopitalTextField: UITextField  {
    
    // MARK:- Properties
    let padding = UIEdgeInsets(top: 0, left: 53, bottom: -10, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = ColorName.white.color
        self.font = UIFont(font: FontFamily.PTSans.bold, size: 15)
        self.backgroundColor = .clear
        self.leftViewMode = .always
        self.borderStyle = .none
        self.layoutIfNeeded()
    }
    
    func createBottomLine(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: self.frame.width, height: 3)
        bottomLine.backgroundColor = UIColor.white.cgColor
        super.layer.addSublayer(bottomLine)
    }
    
    func setup(leftImage: UIImage, placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 15)])
        let leftIcon = UIImageView(image: leftImage)
        self.leftView = leftIcon
    }
}


