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
       case getCategory(_ categoryID:Int)
       
       //Mark:- HTTP Methods
       private var method: HTTPMethod {
           switch self {
           case .getCategory:
               return .get
           default:
               return .post
           }
       }
       
       //MARK:- Parameters
       private var parameters: Parameters? {
           switch self {
           case .getCategory:
               return nil
           default:
               return nil
           }
       }
       //MARK:- End points path
       private var path: String {
           switch self {
           case .getCategory(let categoryID):
               return URLs.getCategories+"\(categoryID)"+"/doctors_query_parameters"
       }
    }
      
    func asURLRequest() throws -> URLRequest {
          let url = try path.asURL()
             var urlRequest = URLRequest(url: url)
        
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        
        //Http Headers
        switch self {
        case  .getCategory:
            urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
            break
        default:
            break
        }
        //urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
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
        
        print(try encoding.encode(urlRequest, with: parameters))
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


