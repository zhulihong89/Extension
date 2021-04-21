//
//  String+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/3.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    public func substring(from index: Int, length: Int) -> String? {
        guard self.count > index
            ,length > 0
            ,index + length <= self.count else {
                return nil
        }

        let startIndex = self.index(self.startIndex, offsetBy: index)
        let endIndex = self.index(self.startIndex, offsetBy: index + length - 1)
        let subString = self[startIndex...endIndex]
        
        return String(subString)
    }
    
    public func stringByAppendPath(_ path: String) -> String {
        guard !path.isEmpty else {
            return self
        }
        
        let first = self.hasSuffix("/") ? String(self.dropLast()) : self
        let last = path.hasPrefix("/") ? String(path.dropFirst()) : path

        return "\(first)/\(last)"
    }
    
    /// 移除头尾的空格
    public func dropTailSpace() -> String {
        return dropFirstSpace().dropLastSpace()
    }
    
    public func dropFirstSpace() -> String {
        var string = self
        while string.hasPrefix(" ") {
            string = String(string.dropFirst())
        }
        
        return string
    }
    
    public func dropLastSpace() -> String {
        var string = self
        while string.hasSuffix(" ") {
            string = String(string.dropLast())
        }

        return string
    }
}

extension String {
    public var urlencode: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? self
    }
    public var urldecode: String {
        return self.removingPercentEncoding ?? self
    }
    
    public func base64ToBase64url() -> String {
        let base64url = self
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
        return base64url
    }
    
    public func base64urlToBase64() -> String {
        let base64url = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        return base64url
    }
    
    public func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
}

extension String {
    public func attributedString(lineSpace: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}

extension String {
    public func height(WithFont font: UIFont, width: CGFloat) -> CGFloat {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        let dict = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph]
        let rect = (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dict, context: nil)
        
        return ceil(rect.size.height)
    }
    
    public func width(WithFont font: UIFont) -> CGFloat {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        let dict = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph]
        let rect = (self as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dict, context: nil)
    
        return ceil(rect.size.width)
    }
    
    public static func width(titles: [String], WithFont font: UIFont) -> CGFloat {
        return titles.width(WithFont: font)
    }
}

extension Array where Element == String {
    public func width(WithFont font: UIFont) -> CGFloat {
        var width: CGFloat = 0
        for title in self {
            let w = title.width(WithFont: font)
            if w > width {
                width = w
            }
        }
        
        return width
    }
}


public func + (lhs: String?, rhs: String?) -> String? {
    if lhs == nil && rhs == nil {
        return nil
    }
    
    return "\(lhs ?? "")\(rhs ?? "")"
}

extension String {
    public func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        //把汉字转为拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //去掉拼音的音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        
        let string = String(mutableString)
        //去掉空格
        return string.replacingOccurrences(of: " ", with: "")
    }
}

extension String {
    public init?(any: Any?) {
        guard let value = any else {
            return nil
        }
        
        self = "\(value)"
    }
}


public typealias Path = String
extension Path {
    public static let document: Path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    public static let temp: Path = NSTemporaryDirectory()
    
    public static func documentAppend(_ path: String) -> String {
        return document.stringByAppendPath(path)
    }
    
    public static func tempAppend(_ path: String) -> String {
        return temp.stringByAppendPath(path)
    }
}


extension String{
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*"
    public static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}
