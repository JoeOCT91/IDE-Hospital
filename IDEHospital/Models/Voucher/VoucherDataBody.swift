//
//  VoucherDataBody.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/4/21.
//

import Foundation
struct VoucherDataBody:Codable {
    var doctor_id:Int
    var appointment:String
    var patient_name:String?
    var book_for_another:Bool
    var voucher:String?
}
