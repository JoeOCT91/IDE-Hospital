//
//  Appointment.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 18/12/2020.
//

import Foundation

class Appointment: Codable {

    let id, appointment: Int
    let patientName: String
    let bookForAnother: Bool
    let doctor: Doctor
    let voucher: Bool

    enum CodingKeys: String, CodingKey {
        case id, appointment
        case patientName = "patient_name"
        case bookForAnother = "book_for_another"
        case doctor, voucher
    }
}
