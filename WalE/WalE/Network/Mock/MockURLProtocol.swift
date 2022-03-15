//
//  MockURLProtocol.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var responseData: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockURLProtocol.responseData else {
            assertionFailure("Received unexpected response with no handler set")
            return
        }
        client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: handler)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
