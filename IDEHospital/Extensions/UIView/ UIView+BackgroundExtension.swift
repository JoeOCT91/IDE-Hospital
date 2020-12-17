//
//  HideStatusBar.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/17/20.
//

import Foundation
import UIKit
extension UIView {
  func setupBackground() {
    let background = UIImageView(image: Asset.backgroundImage.image)
    background.contentMode = .scaleAspectFill
    background.frame = self.bounds
    addSubview(background)
    self.sendSubviewToBack(background)
  }
}
