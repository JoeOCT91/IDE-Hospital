//
//  SearchResultResponse.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/23/20.
//

import Foundation
struct SearchResultResponse:Codable {
    let success:Bool
    let code:Int
    let data:SearchResultData
}
