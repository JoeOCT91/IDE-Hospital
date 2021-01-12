//
//  RatingBodyData.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 1/3/21.
//

import Foundation
struct RatingBodyData:Codable {
    var doctor_id:Int
    var rating:Int?
    var comment:String?
}
