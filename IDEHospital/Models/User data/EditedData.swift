//
//  EditedData.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 13/01/2021.
//

import Foundation

class EditedData: Codable {
    
    let code: Int?
    let name: String?
    let email: String?
    let mobile: String?
    var oldPassword: String?
    var password: String?
    var confirmPassword: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case email
        case mobile
        case oldPassword = "old_password"
        case password
        case confirmPassword
        
    }

    init(name:String?, email: String?, mobile: String?, oldPass: String?, newPass: String?, confirmPass: String? ) {
        self.code = nil
        self.name = name
        self.email = email
        self.mobile = mobile
        self.oldPassword = oldPass
        self.password = newPass
        self.confirmPassword = confirmPass
    }
}
