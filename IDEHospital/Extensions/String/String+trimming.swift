//
//  String+trimming.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
