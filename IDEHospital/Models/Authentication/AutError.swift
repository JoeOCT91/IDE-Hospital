//
//  AutError.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/28/20.
//

import Foundation
struct AuthError:Codable {
    let email: [String]?
    let voucher: [String]?
}
