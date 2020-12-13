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
        }
    }
}
