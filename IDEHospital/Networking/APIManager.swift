//
//  APIManager.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation
import Alamofire

class APIManager {
    
    class func getCategories(complation: @escaping (Result<Categories, Error>) -> () ) {
        request(APIRouter.getCategories) { (response) in
            complation(response)
        }
    }
    class func downloadImageAsData(urlString: String, complation: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get).responseData { (response) in
            switch(response.result){
            case .success(let data):
                complation(.success(data))
            case .failure(let error):
                complation(.failure(error))
            }
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
