//
//  TermsAndConditions.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 30/12/2020.
//

import Foundation

// MARK: - TermsAndConditionsBody
struct TermsAndConditions: Codable {
    
    let termsAndConditions: String

    enum CodingKeys: String, CodingKey {
        case termsAndConditions = "terms_and_conditions"
    }
}
