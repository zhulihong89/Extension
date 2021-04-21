//
//  Date+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/26.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension Date {    
    public func display(format: String = "MM-dd HH:mm") -> String {
        let threadDictionary = Thread.current.threadDictionary
        var formatter = threadDictionary["mydateformatter"] as? DateFormatter
        
        synchronized(lock: self) {
            if formatter == nil {
                formatter = DateFormatter()
                formatter?.locale = Locale.current
                threadDictionary["mydateformatter"] = formatter
            }
        }
        formatter?.dateFormat = format
        
        return formatter?.string(from: self) ?? ""
    }
    
    public static func date(from string:String, format: String) -> Date? {
        let threadDictionary = Thread.current.threadDictionary
        var formatter = threadDictionary["mydateformatter"] as? DateFormatter
        
        synchronized(lock: self) {
            if formatter == nil {
                formatter = DateFormatter()
                formatter?.locale = Locale.current
                threadDictionary["mydateformatter"] = formatter
            }
        }
        formatter?.dateFormat = format
        
        return formatter?.date(from: string)
    }

    public static func duration(_ long: TimeInterval) -> String {
        let long = Int64(long)
        let days = long / (3600 * 24)
        let hours = long % (3600*24) / 3600;
        let minutes = long % (3600*24) % 3600/60;
//        let seconds = long % (3600*24) % 3600 % 60;
        
        var string = ""
        if days > 365 {
            let year: Int = Int(days / 365)
            let ds = Int(days) - year * 365
            string.append("\(year)年 \(ds)天")
        } else if days > 0 {
            string.append("\(days)天 \(hours)小时 \(minutes)分")
        } else if hours > 0 {
            string.append("\(hours)小时 \(minutes)分")
        } else {
            string.append("\(minutes) 分")
        }
        
        return string
    }
    
    public static func display(_ timp: TimeInterval) -> String {
        let long = Date().timeIntervalSince1970 - timp
        let days = long / (3600 * 24)
        let date = Date(timeIntervalSince1970: timp)
        if days >= 365 {
            return date.display(format: "YYYY-MM-dd")
        } else {
            return date.display(format: "MM-dd HH:mm")
        }
    }
    
    public static func displayWorld(_ timp: TimeInterval) -> String {
        let long = Date().timeIntervalSince1970 - timp
        let days = long / (3600 * 24)
        let date = Date(timeIntervalSince1970: timp)
        if days >= 365 {
            return date.display(format: "MMM dd YYYY")
        } else {
            return date.display(format: "MMM dd HH:mm")
        }
    }
    
    public var isToday: Bool {
        return NSCalendar.current.isDateInToday(self)
    }

}
