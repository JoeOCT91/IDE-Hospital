//
//  AppointmentsMainResponse.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

struct AppointmentsMainResponse: Codable {
    let data: AppointmentsResponse
    let code: Int
    let success: Bool
}
