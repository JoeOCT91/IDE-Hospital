//
//  File.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/30/20.
//

import Foundation
struct AboutResponse:Codable {
    let success:Bool?
    let data:AboutData?
    let code:Int?
}

struct AboutData:Codable {
    let about_us:String?
}
