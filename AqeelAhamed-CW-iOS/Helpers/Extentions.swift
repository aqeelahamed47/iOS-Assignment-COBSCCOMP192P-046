//
//  Extentions.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-29.
//

import Foundation

extension Date {
    
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }
    
    func getLast7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)
    }
    
    func getLastLongDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -5000, to: self)
    }
}
