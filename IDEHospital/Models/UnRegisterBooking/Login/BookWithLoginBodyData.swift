//
//  BookWithLoginBodyData.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/14/21.
//

import Foundation
struct BookWithLoginBodyData:Codable {
    var doctor_id:Int
    var appointment:String
    var patient_name:String?
    var book_for_another:Bool
    var voucher:String?
    let email:String
    let password:String?
}
