//
//  CategoriesResponse.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/12/20.
//

import Foundation
struct CategoriesResponse:Codable {
   let success: Bool
   let code: Int
   let data: CategoriesData
}
