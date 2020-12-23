//
//  AppointmentsResponse.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

struct AppointmentsResponse: Codable {
    let appointments: [Appointment]
    let total, page, perPage, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case appointments = "items"
        case total, page
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}
