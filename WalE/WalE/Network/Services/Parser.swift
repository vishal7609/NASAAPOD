//
//  Parser.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

struct Parser {
    static func decodeResponse<T: Decodable>(_ type: T.Type, from data: Data?) -> (T?, Error?) {
        do {
            if let data = data {
                let response = try JSONDecoder().decode(T.self, from: data)
                return (response, nil)
            }
        } catch {
            let error = NSError(domain: "Unable to decode data to type of \(T.self)", code: -1)
            return (nil, error)
        }
        let error = NSError(domain: "Unable to decode data to type of \(T.self)", code: -1)
        return (nil, error)
    }
}
