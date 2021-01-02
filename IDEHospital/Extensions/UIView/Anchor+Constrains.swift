//
//  Anchor+Constrains.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        guard let top = top,
              let leading = leading,
              let bottom = bottom,
              let trailing = trailing
        else { return }
        
        self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
