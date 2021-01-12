//
//  HospitalButton.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 16/12/2020.
//

import UIKit

class HospitalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(frame: CGRect, tittle: String, color:ColorName) {
        super.init(frame: frame)
        self.setTitle(tittle, for: .normal)
        configure(color: color)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure(color:ColorName = ColorName.darkRoyalBlue){
        self.titleLabel?.font = UIFont(font: FontFamily.PTSans.bold, size: 12)
        self.titleLabel?.font = self.titleLabel?.font.withSize(12)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: color)
        self.layer.cornerRadius = 10
    }
}
