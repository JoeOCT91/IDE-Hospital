//
//  Cities.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/12/20.
//

import Foundation
struct Cities:Codable {
    let id: Int
    let name: String
    let regions: [Regions]
}
