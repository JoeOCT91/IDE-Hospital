//
//  TermsAndConditions.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 30/12/2020.
//

import Foundation

// MARK: - TermsAndCondition
struct TermsAndCondition: Codable {
    let success: Bool
    let data: TermsAndConditionsBody
    let code: Int
}

// MARK: - TermsAndConditionsBody
struct TermsAndConditionsBody: Codable {
    
    let termsAndConditions: String

    enum CodingKeys: String, CodingKey {
        case termsAndConditions = "terms_and_conditions"
    }
}
