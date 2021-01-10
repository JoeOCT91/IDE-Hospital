//
//  AppointmentsResponse.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/01/2021.
//

import Foundation

// MARK: - Welcome
struct MainResponse<Elment: Codable>: Codable {
    let success: Bool
    let code: Int
    let data: Elment
}

// MARK: - Datum
struct AppointmentDate: Codable {
    let date: Int
    let times: [AppointmentTime]
}

// MARK: - Time
struct AppointmentTime: Codable {
    let time: Int
    let booked: Bool
}
