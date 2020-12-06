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
    case login
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .login:
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
        //urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
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
    
    
    
}
