//
//  VoucherViewModel.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import Foundation
protocol VoucherViewModelProtocol {
    
}
class VoucherViewModel {
    private var view:VoucherVcProtocol?
    
    init(view:VoucherVcProtocol) {
        self.view = view
    }
}
extension VoucherViewModel:VoucherViewModelProtocol{
    
}
