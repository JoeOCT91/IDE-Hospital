//
//  SearchResultData.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/23/20.
//

import Foundation
struct SearchResultData:Codable  {
    let total:Int
    let page:Int
    let per_page:Int
    let total_pages:Int
    let items:[DoctorResponse]
}
