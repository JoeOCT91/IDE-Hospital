//
//  BookWithRegisterBodyData.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/14/21.
//

import Foundation
struct BookWithRegisterBodyData:Codable {
    var doctor_id:Int
    var appointment:String
    var patient_name:String?
    var book_for_another:Bool
    var voucher:String?
    let name:String?
    let email:String
    let mobile:String?
    let password:String?
}
