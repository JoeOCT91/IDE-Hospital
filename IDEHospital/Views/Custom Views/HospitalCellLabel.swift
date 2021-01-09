//
//  LabelWithIIcon.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 16/12/2020.
//

import UIKit

class HospitalCellLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat, font: UIFont? = UIFont(font: FontFamily.PTSans.regular, size: 12)) {
        super.init(frame: .zero)
        self.font = font
        self.font = self.font.withSize(fontSize)
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.setLineSpacing(lineSpacing: 3, lineHeightMultiple: 3)
        configure()
    }
    
    func setupContent(imageName: String, text: String, textColor: UIColor = ColorName.white.color){
        self.textColor = textColor
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        // Set bound to reposition
        let imageOffsetY: CGFloat = 0.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width , height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let paddingAttachment = NSTextAttachment()
        paddingAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 0)
        let attchmentPadding = NSAttributedString(attachment: paddingAttachment)
        
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        completeText.append(attchmentPadding)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        self.attributedText = completeText
    }
    
    private func configure(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
    }
    
}
