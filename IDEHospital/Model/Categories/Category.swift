//
//  Category.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import Foundation

class Category: Codable {
    let id: Int
    let name: String
    let image: String
    let color: String
    var imageAsData: Data?
}
