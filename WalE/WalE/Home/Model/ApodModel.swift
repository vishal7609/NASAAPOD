//
//  ApodModel.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

struct ApodModel: Codable {
    var copyright: String = ""
    var date: String = ""
    var explanation: String = ""
    var hdurl: String = ""
    var media_type: String = ""
    var service_version: String = ""
    var title: String = ""
    var url: String = ""
    
    private enum rootKeys: String, CodingKey {
        case copyright, date, explanation, hdurl, media_type, service_version, title, url
    }
    
    init(from decoder: Decoder) throws {
        let containeer = try decoder.container(keyedBy: rootKeys.self)
        if let copyright = try? containeer.decodeIfPresent(String.self, forKey: .copyright) {
            self.copyright = copyright
        }
        if let date = try? containeer.decodeIfPresent(String.self, forKey: .date) {
            self.date = date
        }
        if let explanation = try? containeer.decodeIfPresent(String.self, forKey: .explanation) {
            self.explanation = explanation
        }
        if let hdurl = try? containeer.decodeIfPresent(String.self, forKey: .hdurl) {
            self.hdurl = hdurl
        }
        if let media_type = try? containeer.decodeIfPresent(String.self, forKey: .media_type) {
            self.media_type = media_type
        }
        if let service_version = try? containeer.decodeIfPresent(String.self, forKey: .service_version) {
            self.service_version = service_version
        }
        if let title = try? containeer.decodeIfPresent(String.self, forKey: .title) {
            self.title = title
        }
        if let url = try? containeer.decodeIfPresent(String.self, forKey: .url) {
            self.url = url
        }
        
    }
}
