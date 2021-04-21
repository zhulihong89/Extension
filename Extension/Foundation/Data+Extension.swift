//
//  NSData+Extension.swift
//  Extension
//
//  Created by lihong on 2019/9/6.
//  Copyright © 2019 lihong. All rights reserved.
//

import Foundation

extension Data {
    /// Initializes `Data` with a hex string representation.
    public init?(hexString: String) {
        let string: Substring
        if hexString.hasPrefix("0x") {
            string = hexString.dropFirst(2)
        } else {
            string = Substring(hexString)
        }
        
        self.init(capacity: string.count / 2)
        for offset in stride(from: 0, to: string.count, by: 2) {
            let start = string.index(string.startIndex, offsetBy: offset)
            guard string.distance(from: start, to: string.endIndex) >= 2 else {
                let byte = string[start...]
                guard let number = UInt8(byte, radix: 16) else {
                    return nil
                }
                append(number)
                break
            }
            
            let end = string.index(string.startIndex, offsetBy: offset + 2)
            let byte = string[start ..< end]
            guard let number = UInt8(byte, radix: 16) else {
                return nil
            }
            append(number)
        }
    }
    
    /// Returns the hex string representation of the data.
    public var hexString: String {
        var string = ""
        for byte in self {
            string.append(String(format: "%02x", byte))
        }
        return string
    }
}
