//
//  APIRouter.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 06/12/2020.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    //End Points names
    case getCategories
    case login
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .login, .getCategories:
            return .get
        default:
            return .post
        }
    }
    
    //MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        case .login:
            return nil
        default:
            return nil
        }
    }
    //MARK:- End points path
    private var path: String {
        switch self {
        case .login:
            return "Path"
        case .getCategories:
            return URLs.mainCategories
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        
        //Http Headers
        switch self {
        case  .login:
            break
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .login:
                return nil
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
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    

    
    private func encodeToJSON<T: Codable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            //let jsonString = String(data: jsonData, encoding: .utf8)!
            //print(jsonString)
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
