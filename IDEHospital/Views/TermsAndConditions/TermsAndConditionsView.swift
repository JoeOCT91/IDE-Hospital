//
//  TermsAndConditionsView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 30/12/2020.
//

import UIKit

class TermsAndConditionsView: UIView {

    @IBOutlet weak var termsAndConditionsLabel: UITextView!
    
    func setup(){
        self.setupBackground()
        termsAndConditionsLabel.textColor = ColorName.white.color
    }
    
    func setTermsAndConditions(termsAndConditions: NSAttributedString) {
        termsAndConditionsLabel.attributedText = termsAndConditions
        termsAndConditionsLabel.textColor = ColorName.white.color
    }

}
