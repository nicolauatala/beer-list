//
//  APIRepository.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension APIManager {
    enum RouterBeers: URLRequestConvertible{
        
        case getBeers(page:Int)
        //case getRepositoryPullRequest(owner: String, repositoryName: String)
        
        var path: (method: HTTPMethod, url: String){
            switch self {
            case .getBeers:
                return (.get, "beers")
//            case .getRepositoryPullRequest(let owner, let repositoryName):
//                return (.get, "/repos/\(owner)/\(repositoryName)/pulls")
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = URL(string: APIManager.baseURL)!
            var urlRequest = URLRequest(url: url.appendingPathComponent(path.url))
            urlRequest.httpMethod = path.method.rawValue
            
            switch self {
            case .getBeers(let pageNumber):
                return try Alamofire.URLEncoding.default.encode(urlRequest, with: ["per_page" : 10, "page": pageNumber])
                
//            case .getRepositoryPullRequest:
//                return try Alamofire.JSONEncoding.default.encode(urlRequest)
            }
        }
    }
    
    static func getRepositories(type: String, page: Int, success: @escaping ([Beer]) -> Void, failure: @escaping (NSError) -> Void) -> Request{
        return request(urlRequestConvertible: RouterBeers.getBeers(page: page), JSONKey: "items", success: success, failure: failure)
    }
    
//    static func getPullRequest(owner: String, repositoryName: String, success: @escaping ([Beer]) -> Void, failure: @escaping (NSError) -> Void) -> Request{
//
//        return request(urlRequestConvertible: RouterBeers.getRepositoryPullRequest(owner: owner, repositoryName: repositoryName), JSONKey: "", success: success, failure: failure)
//    }
}

extension APIManager {
    
    private static func request<T:Mappable>(urlRequestConvertible:URLRequestConvertible,JSONKey: String, success:@escaping (T) -> Void, failure:@escaping (NSError) -> Void) -> Request{
        return self.request(urlRequestConvertible: urlRequestConvertible, type: T.self, JSONKey: JSONKey, success: { (any) -> Void in
            if let object = any as? T{
                success(object)
            }else{
                failure(NSError(domain: APIManager.baseURL, code: Constants.errorCode.nonRetryCode.rawValue, userInfo: [NSLocalizedDescriptionKey: "Error on parsing: \(any)"]))
            }
        }, failure: failure)
    }
    
    private static func request<T:Mappable>(urlRequestConvertible:URLRequestConvertible, JSONKey: String, success:@escaping ([T]) -> Void, failure:@escaping (NSError) -> Void) -> Request{
        return self.request(urlRequestConvertible: urlRequestConvertible, isArray: true, type: T.self, JSONKey: JSONKey, success: { (any) -> Void in
            if let objects = any as? [T] {
                success(objects)
            } else {
                failure(NSError(domain: APIManager.baseURL, code: Constants.errorCode.nonRetryCode.rawValue, userInfo: [NSLocalizedDescriptionKey: "Error on parsing: \(any)"]))
            }
        }, failure: failure)
    }
    
    private static func request<T:Mappable>(urlRequestConvertible:URLRequestConvertible, isArray:Bool = false, type:T.Type, JSONKey: String, success:@escaping (Any) -> Void, failure:@escaping (NSError) -> Void) -> Request{
        return Alamofire.request(urlRequestConvertible).validate().responseJSON(options: JSONSerialization.ReadingOptions.mutableContainers) { (response) -> Void in
            
            switch response.result {
            case .success(let resultJSON):
                
                let mappableObject:Any?
                if isArray{
                    if !JSONKey.isEmpty {
                        let data = resultJSON as! NSDictionary
                        mappableObject = Mapper<T>().mapArray(JSONArray: data[JSONKey] as! [[String : Any]])
                    } else {
                        mappableObject = Mapper<T>().mapArray(JSONObject: resultJSON)
                    }
                } else {
                    mappableObject = Mapper<T>().map(JSONObject: resultJSON)
                }
                
                if let mappableObject = mappableObject {
                    success(mappableObject)
                } else {
                    if response.response != nil{
                        failure(NSError(domain: APIManager.baseURL, code: Constants.errorCode.nonRetryCode.rawValue, userInfo: [NSLocalizedDescriptionKey: "Error on parsing: \(resultJSON)"]))
                    }
                }
                
            case .failure(let error):
                if let alamoResponse = response.response {
                    if alamoResponse.statusCode != 404 {
                        failure(NSError(domain: APIManager.baseURL, code: alamoResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]))
                    }
                } else {
                    failure(error as NSError)
                }
            }
        }
    }
}
