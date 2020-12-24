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
    case getCategory(_ ID: Int)
    case nurseRequest(_ body:RequsetBodyData)
    case searchResultRequest(_ body:SearchResultBody)
    case login
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .getCategory ,.getCategories,.searchResultRequest:
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
        case .nurseRequest:
            return URLs.nurseRequest
        case .searchResultRequest(let body):
            return URLs.getCategories + "\(body.main_category_id)" + "/doctors"
        default:
            return ""
        }
    }
    
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        case .getCategory, .getCategories:
            return nil
        case .searchResultRequest(let body):
            return [ParameterKeys.page: body.page , ParameterKeys.per_page: body.per_page, ParameterKeys.specialty_id: body.specialty_id ?? "", ParameterKeys.city_id: body.city_id ?? "" ,ParameterKeys.region_id: body.region_id ?? "", ParameterKeys.name: body.name ?? "", ParameterKeys.company_id: body.company_id ?? "", ParameterKeys.order_by: body.order_by ?? "rating"]
        default:
            return nil
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {

        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        
        //Http Headers
        switch self {
        case  .getCategory, .getCategories:
            urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
        case .searchResultRequest(let body):
            urlRequest.setValue("Bearer " + (body.userToken ?? ""), forHTTPHeaderField: HeaderKeys.authorization)
            urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.accept)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case.nurseRequest(let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
          switch method {
          case .get, .delete:
            return URLEncoding.default
          default:
            return JSONEncoding.default
          }
        }()
        
        // Encoding
        //let encoding: ParameterEncoding = JSONEncoding.default
        
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



