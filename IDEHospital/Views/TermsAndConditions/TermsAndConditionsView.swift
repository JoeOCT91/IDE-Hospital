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
    }
    
    func setTermsAndConditions(termsAndConditions: NSAttributedString) {
        termsAndConditionsLabel.textColor = ColorName.white.color
        termsAndConditionsLabel.attributedText = termsAndConditions
    }

}
