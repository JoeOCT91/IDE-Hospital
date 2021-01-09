//
//  String+ReplaceCharacter.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/8/21.
//

import Foundation
extension String {
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}
