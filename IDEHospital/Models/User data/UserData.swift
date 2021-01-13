//
//  UserData.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 13/01/2021.
//

import Foundation

class UserDataResponse: Codable {
    
    let success: Bool
    let userData: UserData
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case success
        case code
        case userData = "data"
    }
    
}

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
}
