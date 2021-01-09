//
//  String+Subscript.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/8/21.
//

import Foundation
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
