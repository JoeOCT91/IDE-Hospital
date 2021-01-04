//
//  DoctorInformation.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 04/01/2021.
//

import Foundation

struct DoctorInformationResponse: Codable {
    let success: Bool
    let data: DoctorInformation
    let code: Int
}

struct DoctorInformation: Codable {
    let id, rating, reviewsCount: Int
    let name, bio, secondBio, specialty: String
    let address, lng, lat: String
    let fees, waitingTime: Int
    let image, city, region: String
    let isFavorited: Bool
    let companies: [String]

    enum CodingKeys: String, CodingKey {
        case id, rating
        case reviewsCount = "reviews_count"
        case name, bio
        case secondBio = "second_bio"
        case specialty, address, lng, lat, fees
        case waitingTime = "waiting_time"
        case image, city, region
        case isFavorited = "is_favorited"
        case companies
    }
}
