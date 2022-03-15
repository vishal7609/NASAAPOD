//
//  HomeAPI.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

enum HomeAPI {
    case apod
    case downloadImage(url: String)
}

extension HomeAPI: EndPointType {
    
    var baseURL: URL {
        switch self {
        case .apod:
            guard let url = URL(string: NetworkConstant.baseURL) else {
                fatalError("baseURL could not be configured.")
            }
            return url
        case .downloadImage(let imageUrl):
            guard let url = URL(string: imageUrl) else {
                fatalError("baseURL could not be configured.")
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .apod: return PathConstant.apodPath
        case .downloadImage: return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .apod :
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkConstant.nasaAPIKey])
        case .downloadImage:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
