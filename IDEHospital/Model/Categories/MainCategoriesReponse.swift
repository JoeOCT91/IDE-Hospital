//
//  File.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation

class MainCategoriesReponse: Codable {
    let success: Bool
    let code: Int
    let categories: [MainCategory]
    
    enum CodingKeys: String, CodingKey {
        case success, code
        case categories = "data"
    }
}

