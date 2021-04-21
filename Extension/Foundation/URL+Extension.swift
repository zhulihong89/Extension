//
//  URL+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/8/14.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import Foundation

extension URL {
    /// 自动补齐http和url编码处理
    public static func url(_ urlString: String) -> URL? {
        var urlString = urlString
        if (urlString as NSString).range(of: "://").location == NSNotFound {
            urlString = "http://" + urlString
        }
        
        if let url = URL(string: urlString) {
            return url
        }
        
        let string  = urlString as NSString
        var location = string.range(of: "://").location
        guard location != NSNotFound else {
            return nil
        }
        
        location = location + 3
        urlString = (urlString.substring(from: 0, length: location) ?? "") + (urlString.substring(from: location, length: urlString.count - location)?.urlencode ?? "")
        return URL(string: urlString)
    }
    
    public var params: [String: String] {
        guard let querys = self.query?.split(separator: "&") else {
            return [:]
        }
        
        var paramters: [String: String] = [:]
        for query in querys {
            let keyValue = query.split(separator: "=")
            if keyValue.count == 2, let key = keyValue.first, let value = keyValue.last {
                paramters[String(key)] = String(value).urldecode
            }
        }
        
        return paramters;
    }
}
