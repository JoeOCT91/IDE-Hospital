//
//  DoctorProfleResponse.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 04/01/2021.
//

import Foundation

struct DoctorProfileMainResponse<Element: Codable>: Codable {
    let data: ResponseData<Element>
    let code: Int
    let success: Bool
}


struct ResponseData<Element: Codable>: Codable {
    let items: [Element]
    let total, page, perPage, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case items, total, page
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}


struct Review: Codable {
    let id, rating: Int
    let comment, commentedBy: String

    enum CodingKeys: String, CodingKey {
        case id, rating, comment
        case commentedBy = "commented_by"
    }
}
