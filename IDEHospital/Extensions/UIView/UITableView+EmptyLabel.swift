//
//  File.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 02/01/2021.
//

import UIKit

extension UITableView {
    
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        // styling
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(font: FontFamily.PTSans.bold, size: 16)
        label.font = label.font.withSize(16)
        label.textColor = UIColor(named: ColorName.white)
        
        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
    
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
