//
//  NSAttributedString+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/27.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension NSAttributedString {
    public static func imageAttribueString(_ string: String, image: UIImage, font: UIFont, color: UIColor, index: Int? = nil, offset: CGPoint = CGPoint(x: 0, y: 0)) -> NSAttributedString {
        let imageAttach = NSTextAttachment()
        imageAttach.image = image
        imageAttach.bounds = CGRect(x: offset.x, y: offset.y, width: image.size.width, height: image.size.height)
        let imageAttri = NSAttributedString(attachment: imageAttach)
        let attriStr = NSMutableAttributedString(string: "\(string) ")
        if let index = index {
            attriStr.insert(imageAttri, at: index)
        } else {
            attriStr.append(imageAttri)
        }

        attriStr.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], range: NSMakeRange(0, attriStr.length))

        return attriStr
    }
}

extension NSAttributedString {
    private struct AssociatedObKeys {
        static var attributedHeight = "attributedHeight"
    }

    private var _attributedSize: CGSize? {
        set {
            objc_setAssociatedObject(self, &AssociatedObKeys.attributedHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedObKeys.attributedHeight) as? CGSize
        }
    }
    
    public static func htmlString(string: String, lineSpacing: CGFloat = 8, firstLineHeadIndent: CGFloat = 28) -> NSAttributedString? {
        guard let data = string.data(using: .utf8),
        let attributedText = try? NSMutableAttributedString(data: data, options:
        [.documentType :NSAttributedString.DocumentType.html,
         .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }
        
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        paraph.firstLineHeadIndent = firstLineHeadIndent
        attributedText.addAttributes([.paragraphStyle:paraph], range: NSMakeRange(0, attributedText.length))
        
        return attributedText
    }
    
    public func height(_ width: CGFloat) -> CGFloat {
        if let size = _attributedSize, size.width == width {
            return size.height
        }
        
        let size = boundingRect(with:  CGSize(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue), context: nil)
        _attributedSize = CGSize(width: width, height: size.height)
        
        return size.size.height
    }
 
}
