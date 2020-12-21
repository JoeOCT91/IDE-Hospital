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
    case login
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .getCategory ,.getCategories:
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
        default:
            return ""
        }
    }
    
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        case .getCategory, .getCategories:
            return nil
        case .nurseRequest(let body):
            return [ParameterKeys.name: body.name, ParameterKeys.email: body.email, ParameterKeys.mobile: body.mobile, ParameterKeys.message: body.message]
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
            break
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
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



