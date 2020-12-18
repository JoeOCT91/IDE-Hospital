//
//  APIManager.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation
import Alamofire

class APIManager {
    
    
    class func getCategories(complation: @escaping (Result<MainCategoriesReponse, Error>) -> () ) {
        request(APIRouter.getCategories) { (response) in
            complation(response)
        }
    }    
    
    class func getCategoriesAPIRouter(categoryID:Int, completion: @escaping (Result<CategoriesResponse, Error>)-> ()){
        request(APIRouter.getCategory(categoryID)){ (response) in
            completion(response)
        }
    }
    
    class func getFavorites(page: Int, complation: @escaping (Result<FavoritesResponse, Error>) -> () ) {
        request(APIRouter.getFavories(page)) { (response) in
            complation(response)
        }
    }
    class func getAppointments(page: Int, complation: @escaping (Result<AppointmentsMainResponse, Error>) -> () ) {
        request(APIRouter.getAppointments(page)) { (response) in
            complation(response)
        }
    }
    
}
extension APIManager{
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            //let ster = String(data: response.data!, encoding: .utf8)
            }
        }.responseJSON { response in
            print(response)
        }
    }
}

