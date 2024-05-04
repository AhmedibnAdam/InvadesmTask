//
//  NetworkLayer.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//
import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case failure(Error)
}
// Define custom error type
enum NetworkError: Error {
    case noData
    case noConnection
}

class RetryHandler: RequestInterceptor {
    let maxRetry = 3
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        request.retryCount < maxRetry ?  completion(.retry) : completion(.doNotRetry)
    }
}

class NetworkLayer {
    
    //MARK: - variables
    private init() {}
    static let instance = NetworkLayer()
    
    
    
    func fetchData<T: Codable>(method: HTTPMethod, url: String, parameters: Parameters, headers: HTTPHeaders?, completion: @escaping (Result<T>) -> ()) {
        
        checkReachability() ?  remoteFetch(method: method, url: url, parameters: parameters, headers: headers, completion: completion) : localFetch(completion: completion)
        
        
    }
    
    private func localFetch<T: Codable>(completion: @escaping (Result<T>) -> ()){
        guard let retrivedData = RealmManager.shared.getObjectOf(type: RealmList.self).last else {return}
        var listingModels = [ListingModel]()
        for realmObject in retrivedData.list {
            let listingModel = convertRealmListingToModel(realmListing: realmObject)
            listingModels.append(listingModel)
        }
        completion(.success(listingModels as! T))
    }
    
    func convertRealmListingToModel(realmListing: RealmListingModel) -> ListingModel {
        return ListingModel(alphaTwoCode: realmListing.alphaTwoCode,
                            name: realmListing.name,
                            country: realmListing.country,
                            domains: Array(realmListing.domains),
                            webPages: Array(realmListing.webPages),
                            stateProvince: realmListing.stateProvince)
    }
    
    private func remoteFetch<T: Codable>(method: HTTPMethod, url: String, parameters: Parameters, headers: HTTPHeaders?, completion: @escaping (Result<T>) -> ()) {
        //MARK: -  headers
        let finalHeaders: HTTPHeaders? = headers
        
        //MARK: -  method
        var encoder: ParameterEncoding!
        switch method {
        case .get:
            encoder = URLEncoding.default
        default:
            encoder = JSONEncoding.prettyPrinted
        }
        
        //MARK: - request
        AF.request(url, method: method, parameters: parameters, encoding: encoder, headers: finalHeaders, interceptor: RetryHandler()).responseData { response in
            switch response.result {
                // success request
            case .success( _):
                guard let data = response.data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let myModel = try JSONDecoder().decode(T.self, from: data)
                    
                    completion(.success(myModel))
                } catch {
                    completion(.failure(error))
                }
                
                // failure request
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkLayer{
    func checkReachability() -> Bool {
        let reachabilityManager = NetworkReachabilityManager(host: "http://universities.hipolabs.com") // Change the host as needed
        return reachabilityManager?.isReachable ?? false
    }
}
