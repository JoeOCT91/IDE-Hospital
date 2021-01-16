//
//  BookWithRegisterResponse.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/14/21.
//

import Foundation
struct BookWithRegisterResponse:Codable {
    var success:Bool?
    var code:Int?
    let data:User?
    let errors: AuthError?
}
