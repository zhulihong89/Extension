//
//  UIView+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/2.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension UIView {
    private struct associatedKeys {
        static var bottomLineView  = "bottomLineView"
    }

    public var originX: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var originY: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.centerY)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: centerX, y: newValue)
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    public func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        if #available(iOS 10.0, *) {
            let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
                self.transform = CGAffineTransform(translationX: translation, y: 0)
            }
            propertyAnimator.addAnimations({
                self.transform = CGAffineTransform(translationX: 0, y: 0)
            }, delayFactor: 0.2)
            propertyAnimator.startAnimation()
        }
    }
    
    public func addTapGesture(_ target: Any? = nil, action: Selector? = nil) {
        let target = target ?? self
        let action = action ?? #selector(hideKeyboard)
        let gestureRecognizer  = UITapGestureRecognizer(target: target, action: action)
//        gestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }

    public func shot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        
        layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func setRoundedCorners(corners: UIRectCorner, withRadii radii:CGSize) {
        let rounded = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        
        self.layer.mask = shape
    }
    
    // MARK - Private
}

extension UIView {
    
    public func snapshotImage(with: CGRect? = nil, afterScreenUpdates: Bool = false) -> UIImage? {//
        let rect = with ?? bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        drawHierarchy(in: CGRect(x:-rect.minX, y: -rect.minY, width: bounds.width, height: bounds.height), afterScreenUpdates: afterScreenUpdates)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}


extension UIView {
    public struct BorderSideType: OptionSet {
        public var rawValue: UInt8
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        public static let top = BorderSideType(rawValue: 1 << 0)
        public static let right = BorderSideType(rawValue: 1 << 1)
        public static let bottom = BorderSideType(rawValue: 1 << 2)
        public static let left = BorderSideType(rawValue: 1 << 3)
    }
    
    public func removeBorderLine() {
        let all:[BorderSideType] = [.top, .bottom, .right, .left]
        for t in all {
            let tag = Int(t.rawValue) + 1330
            viewWithTag(tag)?.removeFromSuperview()
        }
    }
    
    public func setBorderLine(_ type: BorderSideType, color: UIColor) {
        let all:[BorderSideType] = [.top, .bottom, .right, .left]
        for t in all {
            if type.contains(t) {
                let tag = Int(t.rawValue) + 1330
                if let view = viewWithTag(tag) {
                    view.backgroundColor = color
                } else {
                    let view = UIView()
                    view.backgroundColor = color
                    view.tag = tag
                    translatesAutoresizingMaskIntoConstraints = false
                    view.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(view)
                    if type != .right {
                        addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
                    }
                    if type != .left {
                        addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
                    }
                    if type != .bottom {
                        addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
                    }
                    if type != .top {
                        addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
                    }
                    if type == .top || type == .bottom {
                        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0.5))
                    }
                    if type == .left || type == .right {
                        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 0.5))
                    }
                }
            }
        }
    }
}
