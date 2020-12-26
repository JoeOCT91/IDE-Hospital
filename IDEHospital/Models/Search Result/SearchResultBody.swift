//
//  SearchResultBody.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/23/20.
//

import Foundation
struct SearchResultBody {
    let main_category_id :Int
    var userToken:String?
    var specialty_id:Int?
    var city_id:Int?
    var region_id:Int?
    var company_id:Int?
    var name:String?
    var order_by:String?
    var page:Int = 1
    var per_page:Int?
}

