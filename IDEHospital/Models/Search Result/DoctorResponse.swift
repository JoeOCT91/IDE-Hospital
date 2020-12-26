//
//  ItemsInCell.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/23/20.
//

import Foundation
struct DoctorResponse:Codable  {
    let id:Int
    let rating:Double
    let reviews_count:Int
    let name:String
    let bio:String
    let second_bio:String
    let specialty:String
    let address:String
    let fees:Int
    let waiting_time:Int
    let image:String
    let city:String
    let region:String
    var is_favorited:Bool
    let companies:[String]
    
}
