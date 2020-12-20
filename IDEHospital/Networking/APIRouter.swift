////
////  APIRouter.swift
////  IDEHospital
////
////  Created by Yousef Mohamed on 06/12/2020.
////
//
//import Foundation
//import Alamofire
//
//enum APIRouter:URLRequestConvertible {
//    //End Points names
//
//    case getCategories
//    case getCategory(_ ID: Int)
//    case login
//
//    //Mark:- HTTP Methods
//    private var method: HTTPMethod {
//        switch self {
//        case .getCategory ,.getCategories:
//            return .get
//        default:
//            return .post
//        }
//    }
//
//    //MARK:- End points path
//    private var path: String {
//        switch self {
//        case .getCategory(let categoryID):
//            return URLs.getCategories + "\(categoryID)" + "/doctors_query_parameters"
//        case .getCategories:
//            return URLs.getCategories
//        default:
//            return ""
//        }
//    }
//
//
//    //MARK:- Parameters
//    private var parameters: Parameters? {
//        switch self {
//        case .getCategory, .getCategories:
//            return nil
//        default:
//            return nil
//        }
//    }
//
//
//    func asURLRequest() throws -> URLRequest {
//
//        let url = try URLs.base.asURL()
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//
//        //httpMethod
//        urlRequest.httpMethod = method.rawValue
//
//        //Http Headers
//        switch self {
//        case  .getCategory, .getCategories:
//            urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
//            break
//        default:
//            break
//        }
//        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
//
//        // HTTP Body
//        let httpBody: Data? = {
//            switch self {
//            default:
//                return nil
//            }
//        }()
//
//        urlRequest.httpBody = httpBody
//
//        // Encoding
//        let encoding: ParameterEncoding = JSONEncoding.default
//
//        //print(try encoding.encode(urlRequest, with: parameters))
//        return try encoding.encode(urlRequest, with: parameters)
//    }
//}
//
//extension APIRouter {
//    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
//        do {
//            let anyEncodable = AnyEncodable(body)
//            let jsonData = try JSONEncoder().encode(anyEncodable)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonString)
//            return jsonData
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
//
//// type-erasing wrapper
//struct AnyEncodable: Encodable {
//    private let _encode: (Encoder) throws -> Void
//
//    public init<T: Encodable>(_ wrapped: T) {
//        _encode = wrapped.encode
//    }
//
//    func encode(to encoder: Encoder) throws {
//        try _encode(encoder)
//    }
//}
//
//
//
//
//  APIRouter.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    //End Points names
    
    case getCategories
    case getFavories(_ page: Int)
    case getAppointments(_ page: Int)
    case removeFavorite(doctorID: Int)

    case getCategory(_ ID: Int)
    case login
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .login, .getCategories, .getFavories, .getCategory, .getAppointments:
            return .get
        default:
            return .post
        }
    }
    
    //MARK:- End points path
    private var path: String {
        switch self {
        case .getCategory(let categoryID):
            return URLs.getCategories + "\(categoryID)" + "/doctors_query_parameters"
        case .getCategories:
            return URLs.getCategories
        case .getFavories:
            return URLs.favorites
        case .getAppointments:
            return URLs.appoitments
        case .removeFavorite(let doctorID):
            return URLs.favorites + "/\(doctorID)/add_remove"
        default:
            return ""
        }
    }
    private var query: URLQueryItem? {
        switch self {
        case .getFavories(let page):
            return URLQueryItem(name: "page", value: String(page))
        case .getAppointments(let page):
            return URLQueryItem(name: "page", value: String(page))
        default:
            return nil
        }
    }
    
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        case .getCategory, .getCategories, .getFavories, .getAppointments:
            return nil
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        // var url = try  //URLs.base.asURL()
        var urlComponents = URLComponents(string: URLs.base + path)!
        if let query = query {
            urlComponents.queryItems = [query]
        }
        let url =  try urlComponents.asURL()
        var urlRequest = URLRequest(url: url)

        
        // urlComponents.queryItems = [query!]
        // var url = URLComponents(string: <#T##String#>)
        // url.appendPathComponent(path)
        // url.url
        //var urlRequest = URLRequest(url: url.appendingPathComponent(path))
                
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        print(urlRequest)
        //Http Headers
        switch self {
        case  .getCategory, .getCategories:
            urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
            break
        case .getFavories, .getAppointments:
            urlRequest.setValue(UserDefaultsManager.shared().token, forHTTPHeaderField: HeaderKeys.authorization)
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = JSONEncoding.default
        
        //print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}



