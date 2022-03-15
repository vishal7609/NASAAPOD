//
//  NetworkManager.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

// Decieds the network environment
enum NetworkEnvironment {
    case qa
    case production
    case staging
}

/// Checks for response
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

/// Deices the Api results
enum Result<String>{
    case success
    case failure(String)
}

/// Manages all network realted issues
struct NetworkManager {
    
    /// Change which type of netwok environment
    static let environment : NetworkEnvironment = .production
    
    /// Handle network response and decides response according to status code
    /// - Parameter response: Response
    /// - Returns: Results
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    static let  router = Router()
}

/// All network constant
struct NetworkConstant {
    static let baseURL = "https://api.nasa.gov/"
    static let nasaAPIKey = "3gyUmEujhkEgaPJAZdIhmUbRnFJdL5o3znhb7RYk"
}

/// Path Constant
struct PathConstant {
    static let apodPath = "planetary/apod"
}
