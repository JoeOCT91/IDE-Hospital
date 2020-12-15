//
//  Data.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/12/20.
//

import Foundation
struct CategoriesData:Codable {
    let specialties:[Specialties]
    let cities:[Cities]
    let companies:[Companies]
    
}
