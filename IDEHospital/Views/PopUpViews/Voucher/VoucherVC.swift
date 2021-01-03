//
//  VoucherVC.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import UIKit
protocol VoucherVcProtocol:class {
    
}
class VoucherVC: UIViewController {
    
    @IBOutlet var voucherView: VoucherView!
    private var viewModel:VoucherViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK:- Public Methods
    class func create() -> VoucherVC {
        let voucherVC: VoucherVC = UIViewController.create(storyboardName: Storyboards.popUpViews, identifier: ViewControllers.voucherVC)
        voucherVC.viewModel = VoucherViewModel(view: voucherVC)
        return voucherVC
    }
    
}
extension VoucherVC:VoucherVcProtocol{
    
}
