//
//  APIManager.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation
import Alamofire

class APIManager {
    class func getCategoriesAPIRouter(categoryID:Int, completion: @escaping (Result<CategoriesResponse, Error>)-> ()){
        request(APIRouter.getCategory(categoryID)){ (response) in
        completion(response)
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
            }
            }.responseJSON { response in
                print(response)
        }
    }
}
