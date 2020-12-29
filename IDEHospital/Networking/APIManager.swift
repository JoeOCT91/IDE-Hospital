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
    
    class func getCategoriesAPIRouter(categoryID:Int, completion: @escaping (Result<CategoriesResponse, Error>)-> ()){
        request(APIRouter.getCategory(categoryID)){ (response) in
            completion(response)
        }
    }

    // nurseRequest
    class func sendNurseRequestAPI(body:RequsetBodyData ,completion: @escaping (Result<NurseResponse, Error>)-> ()){
        request(APIRouter.nurseRequest(body)){ (response) in
               completion(response)
           }
       }
    // search Result Request
    class func sendSearchResultRequestAPI(body:SearchResultBody ,completion: @escaping (Result<SearchResultResponse, Error>)-> ()){
        request(APIRouter.searchResultRequest(body)){ (response) in
                  completion(response)
              }
    }
    
    // add or delete doctor from favorite list Request
    class func addOrDeleteDoctorFromFavoriteListAPI(doctorID:Int ,completion: @escaping (Result<HeartResponse, Error>)-> ()){
        request(APIRouter.addOrDeleteDoctorFromFavoriteList(doctorID)){ (response) in
                    completion(response)
            }
      }

    class func getFavorites<Element>(page: Int, complation: @escaping (Result<BaseResponse<Element>, Error>) -> () ) {
        request(APIRouter.getFavories(page)) { (response) in
            complation(response)
        }
    }

    class func getAppointments(page: Int, complation: @escaping (Result<AppointmentsMainResponse, Error>) -> () ) {
        request(APIRouter.getAppointments(page)) { (response) in
            complation(response)
        }
    }
    
    class func removeAppointment(AppointmentID: Int, complation: @escaping (Result<DeleteResponse, Error>) -> () ) {
        request(APIRouter.removeAppointment(appointmentID: AppointmentID)) { (response) in
            complation(response)
        }
    }
    
    class func removeFavorite(doctorID: Int, complation: @escaping (Result<DeleteResponse, Error>) -> () ) {
        request(APIRouter.removeFavorite(doctorID: doctorID)) { (response) in
            complation(response)
        }
    }
    
    // Login Request
    class func sendLoginRequestAPI(body:AuthBodyData , completion:@escaping (Result<LoginResponse,Error>)-> ()){
        request(APIRouter.login(body)){ (response) in
               completion(response)
           }
       }
    // Register Request
    class func sendRegisterRequestAPI(body:AuthBodyData ,completion: @escaping (Result<SignUpResponse, Error>)-> ()){
        request(APIRouter.signUp(body)){ (response) in
               completion(response)
           }
       }
    
    // Reset Password Request
    class func sendResetPasswordRequestAPI(body:AuthBodyData ,completion: @escaping (Result<ResetPasswordResponse, Error>)-> ()){
        request(APIRouter.ResetPassword(body)){ (response) in
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
//                let str = String(data: response.data!, encoding: .utf8)
//                print(str)
            }
        }.responseJSON { response in
            //print(response)
        }
    }
}

