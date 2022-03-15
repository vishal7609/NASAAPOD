//
//  HTTPTask.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
