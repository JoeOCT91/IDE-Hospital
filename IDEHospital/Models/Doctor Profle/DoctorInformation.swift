//
//  DoctorInformation.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 04/01/2021.
//

import Foundation

struct DoctorInformation: Codable {
    
    let id, rating, reviewsCount: Int
    let specialty, name, bio, secondBio: String
    let address: String
    let lng, lat: Double
    let fees, waitingTime: Int
    let image: String
    let city, region: String
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
