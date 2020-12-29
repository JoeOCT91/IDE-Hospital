//
//  LoginResponse.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/28/20.
//

import Foundation
struct LoginResponse:Codable {
    let success:Bool?
    let code:Int?
    let data:User?
    let message:String?
}
