//
//  Date+Extension.swift
//  WalE
//
//  Created by Vishal Kumar on 11/03/22.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

enum DateFormatterString : String {
    case onlydate = "yyyy-MM-dd"
}
