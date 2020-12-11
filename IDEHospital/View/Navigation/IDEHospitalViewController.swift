//
//  IDEHospitalViewController.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 11/12/2020.
//

import UIKit

class IDEHospitalNavigation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func setViewControllerTitle(to title:String, fontColor: UIColor = .white) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 25))
        titleLabel.layer.backgroundColor = UIColor(named: ColorName.veryLightPink).cgColor
        titleLabel.font = UIFont(font: FontFamily.PTSans.bold, size: 20)
        titleLabel.font = titleLabel.font.withSize(20)
        
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = fontColor
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.barTintColor = UIColor(named: .veryLightPink)

      }
}
