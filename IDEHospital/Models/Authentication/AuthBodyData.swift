//
//  SignUpBodyData.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/28/20.
//

import Foundation
struct AuthBodyData:Codable {
    let name:String?
    let email:String
    let mobile:String?
    let password:String?
}
