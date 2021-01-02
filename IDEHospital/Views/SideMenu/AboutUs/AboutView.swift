//
//  AboutView.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/30/20.
//

import UIKit

class AboutView: UIView {
    
    @IBOutlet weak var aboutUsTextView: UITextView!
    
    public func setUp() {
        self.setupBackground()
        aboutUsTextView.textColor = ColorName.white.color
    }
    
    func setAboutUs(termsAndConditions: NSAttributedString) {
        aboutUsTextView.attributedText = termsAndConditions
        aboutUsTextView.textColor = ColorName.white.color
    }
    
}


