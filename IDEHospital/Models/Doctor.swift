//
//  File.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 14/12/2020.
//

import Foundation

struct Doctor: Codable {
    let id, rating, reviewsCount: Int
    let specialty: String?
    let name, bio, secondBio, address: String
    let lng, lat: Double
    let fees, waitingTime: Int
    let image: String
    let city: City
    let region: String
    let companies: [String]
    let isFavorited: Bool

    enum CodingKeys: String, CodingKey {
        case id, rating
        case reviewsCount = "reviews_count"
        case specialty, name, bio
        case secondBio = "second_bio"
        case address, lng, lat, fees
        case waitingTime = "waiting_time"
        case image, city, region, companies
        case isFavorited = "is_favorited"
    }
}

enum City: String, Codable {
    case alexandria = "Alexandria"
    case behira = "Behira"
    case cairo = "Cairo"
}
