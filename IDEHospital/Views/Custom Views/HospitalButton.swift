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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, tittle: String) {
        super.init(frame: frame)
        self.setTitle(tittle, for: .normal)
        configure()
    }
    
    private func configure(){
        self.titleLabel?.font = UIFont(font: FontFamily.PTSans.bold, size: 12)
        self.titleLabel?.font = self.titleLabel?.font.withSize(12)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: ColorName.darkRoyalBlue)
        self.layer.cornerRadius = 12
    }
}
