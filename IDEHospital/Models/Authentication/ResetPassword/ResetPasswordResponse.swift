//
//  ResetPasswordResponse.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/28/20.
//

import Foundation
struct ResetPasswordResponse:Codable {
     let success:Bool?
     let code:Int?
     let errors: AuthError?
}
