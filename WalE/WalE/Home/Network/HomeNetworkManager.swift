//
//  HomeNetworkManager.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

class HomeNetworkManager {
    
    var router: NetworkRouter
    
    init(router: NetworkRouter) {
        self.router = router
    }
    
    func getAstronomyPictures(completion: @escaping(_ apodModel: ApodModel?, _ error: String?) -> Void) {
        router.request(HomeAPI.apod) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = NetworkManager.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let res = Parser.decodeResponse(ApodModel.self, from: responseData)
                    if let res = res.0  {
                        completion(res, nil)
                    } else {
                        completion(nil, NetworkResponse.noData.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping(_ imageData: Data?, _ errorString: String?) -> Void) {
        router.request(HomeAPI.downloadImage(url: url)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = NetworkManager.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    completion(responseData, nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
