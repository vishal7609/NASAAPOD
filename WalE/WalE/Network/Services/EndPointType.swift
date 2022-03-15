//
//  EndPointType.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

/// End Point Type
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
