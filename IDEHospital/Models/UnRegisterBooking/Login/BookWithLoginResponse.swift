//
//  BookWithLoginResponse.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/14/21.
//

import Foundation
struct BookWithLoginResponse:Codable {
    var success:Bool?
    var code:Int?
    var message:String?
    let data:User?
}
