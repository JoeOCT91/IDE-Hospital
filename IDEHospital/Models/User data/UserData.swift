//
//  UserData.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 13/01/2021.
//

import Foundation

class UserData: Codable {
    let email: String
    let name: String
    let mobile: String
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case mobile
        case accessToken = "access_token"
    }
    
    init(email: String, name: String, mobile: String) {
        self.name = name
        self.email = email
        self.mobile = mobile
        self.accessToken = nil
    }
}
