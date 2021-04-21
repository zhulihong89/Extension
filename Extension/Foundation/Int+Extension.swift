//
//  Int+Extension.swift
//  QYOrder
//
//  Created by lihong on 2019/6/24.
//  Copyright © 2019 qy. All rights reserved.
//

import Foundation

extension Int: ExpressibleByStringLiteral{
    public init(stringLiteral value: String) {
        self = Int(value) ?? 0
    }
}

extension Int {
    public init?(any: Any?) {
        if let value = any as? Int {
            self = value
        } else if let value = any as? UInt64 {
            self = Int(value)
        } else if let value = any as? String {
            guard let valueInt = Int(value) else {
                return nil
            }
            self = valueInt
        } else if let value = any as? Substring {
            guard let valueInt = Int(value) else {
                return nil
            }
            self = valueInt
        } else if let value = any as? Double {
            self = Int(value)
        } else {
            return nil
        }
    }
}

extension UInt {
    public init?(any: Any?) {
        if let value = any as? UInt {
            self = value
        } else if let value = any as? String {
            guard let valueInt = UInt(value) else {
                return nil
            }
            
            self = valueInt
        } else if let value = any as? Double {
            self = UInt(value)
        } else {
            return nil
        }
    }
}


extension CGFloat {
    public init?(any: Any?) {
        if let value = any as? CGFloat {
            self = value
        } else if let value = any as? String {
            guard let valueDouble = Double(value) else {
                return nil
            }
            
            self = CGFloat(valueDouble)
        } else if let value = any as? Double {
            self = CGFloat(value)
        } else if let value = any as? Int {
            self = CGFloat(value)
        } else {
            return nil
        }
    }
}

extension Int {
    public static var kb = 1024
    public static var mb = 1024 * kb
    public static var gb = 1024 * mb
}
