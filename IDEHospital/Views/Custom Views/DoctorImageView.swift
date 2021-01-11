//
//  DoctorImageView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 16/12/2020.
//

import UIKit

class DoctorImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.init(named: ColorName.darkRoyalBlue).cgColor
        self.layer.cornerRadius =  self.bounds.width / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
    }
    



}
