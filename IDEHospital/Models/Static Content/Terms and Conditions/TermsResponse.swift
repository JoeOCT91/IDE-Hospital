//
//  File.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/30/20.
//

import Foundation
struct TermsResponse:Codable {
    let success:Bool?
    let data:TermsData?
    let code:Int?
}
