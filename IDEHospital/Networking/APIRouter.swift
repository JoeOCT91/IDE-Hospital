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
    case removeAppointment(appointmentID: Int)
    case getCategory(_ ID: Int)
    case nurseRequest(_ body:RequsetBodyData)
    case contacutUsRequest(_ body:RequsetBodyData)
    case searchResultRequest(_ body:SearchResultBody)
    case addOrDeleteDoctorFromFavoriteList(_ doctorID:Int)
    case login(_ body:AuthBodyData)
    case signUp(_ body:AuthBodyData)
    case ResetPassword(_ body:AuthBodyData)
    case logout
    case termsAndConditions
    case getAbout
    case doctorReviews(_ doctorID: Int)
    case doctorInformation(_ doctorID: Int)
    case doctorAppointments(_ doctorID: Int)
    case addRating(_ body:RatingBodyData)
    case bookAppointment(_ body:VoucherDataBody)
    case getUserData
    case editUserData(_ body: EditedData)
    case bookWithRegister(_ body:BookWithRegisterBodyData)
    case bookWithLogin(_ body:BookWithLoginBodyData)
    
    //Mark:- HTTP Methods
    private var method: HTTPMethod {
        switch self {
        case .getCategories, .getFavories, .getCategory, .getAppointments, .getAbout, .searchResultRequest:
            return .get
        case .termsAndConditions, .doctorReviews, .doctorInformation, .doctorAppointments, .getUserData:
            return .get
        case .removeAppointment:
            return .delete
        case .editUserData:
            return .patch
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
        case .getFavories:
            return URLs.favorites
        case .getAppointments:
            return URLs.appoitments
        case .removeFavorite(let doctorID):
            return URLs.favorites + "/\(doctorID)/add_remove"
        case .removeAppointment(let appointmentID):
            return URLs.appoitments + "/\(appointmentID)"
        case .addOrDeleteDoctorFromFavoriteList(let id):
            return URLs.favorites + "/\(id)" + "/add_remove"
        case .login:
            return URLs.login
        case .signUp:
            return URLs.register
        case .ResetPassword:
            return URLs.forgetPassword
        case .logout:
            return URLs.logout
        case .termsAndConditions:
            return URLs.termsAndConditions
        case .contacutUsRequest:
            return URLs.contactUs
        case .getAbout:
            return URLs.about
        case .doctorReviews(let doctorID):
            return URLs.doctors + "\(doctorID)/reviews"
        case .doctorInformation(let doctorID):
            return URLs.doctors + "\((doctorID))"
        case .doctorAppointments(let doctorID):
            return URLs.doctors + "\(doctorID)/appointments"
        case .addRating(let body):
            return URLs.doctors + "\(body.doctor_id)/reviews"
        case .bookAppointment:
            return URLs.appoitments
        case .getUserData, .editUserData:
            return URLs.user
        case .bookWithRegister:
            return URLs.bookWithRegister
        case .bookWithLogin:
            return URLs.bookWithLogin
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
        case .searchResultRequest(let body):
            return [ParameterKeys.page: body.page , ParameterKeys.per_page: body.per_page ?? 15, ParameterKeys.specialty_id: body.specialty_id ?? "", ParameterKeys.city_id: body.city_id ?? "" ,ParameterKeys.region_id: body.region_id ?? "", ParameterKeys.name: body.name ?? "", ParameterKeys.company_id: body.company_id ?? "", ParameterKeys.order_by: body.order_by ?? "rating"]
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlComponents = URLComponents(string: URLs.base + path)!
        if let query = query {
            urlComponents.queryItems = [query]
        }
        let url =  try urlComponents.asURL()
        var urlRequest = URLRequest(url: url)
        //Set request Method
        urlRequest.httpMethod = method.rawValue
        //Http Headers
        switch self {
        case .getFavories, .getAppointments, .removeFavorite, .removeAppointment,.searchResultRequest(_),.addOrDeleteDoctorFromFavoriteList, .logout, .doctorReviews, .doctorInformation, .addRating,.bookAppointment:
            urlRequest.setValue(UserDefaultsManager.shared().token, forHTTPHeaderField: HeaderKeys.authorization)
        case .getUserData, .editUserData:
            urlRequest.setValue(UserDefaultsManager.shared().token, forHTTPHeaderField: HeaderKeys.authorization)
        default:
            break
        }
        
        urlRequest.setValue("Accept-Language", forHTTPHeaderField: "en")
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.accept)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case.nurseRequest(let body):
                return encodeToJSON(body)
            case.login(let body):
                return encodeToJSON(body)
            case.signUp(let body):
                return encodeToJSON(body)
            case.ResetPassword(let body):
                return encodeToJSON(body)
            case .contacutUsRequest(let body):
                return encodeToJSON(body)
            case .addRating(let body):
                return encodeToJSON(body)
            case .bookAppointment(let body):
                return encodeToJSON(body)
            case .editUserData(let body):
                return encodeToJSON(body)
            case .bookWithRegister(let body):
                return encodeToJSON(body)
            case .bookWithLogin(let body):
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



