//
//  Favorites.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import Foundation

// MARK: - Welcome
struct FavoritesResponse: Codable {
    let data: DataClass
    let code: Int
    let success: Bool
}

// MARK: - DataClass
struct DataClass: Codable {
    let items: [Doctor]
    let total, page, perPage, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case items, total, page
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}



enum City: String, Codable {
    case alexandria = "Alexandria"
    case behira = "Behira"
    case cairo = "Cairo"
}
