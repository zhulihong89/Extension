//
//  UINavigationBar+Extension.swift
//  LeapIn
//
//  Created by lihong on 2019/6/20.
//  Copyright © 2019 leapin. All rights reserved.
//

import UIKit

extension UINavigationBar {
    private struct AssociatedKeys {
        static var overlayKey = "overlayKey"
    }
    
    public var overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.overlayKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}


extension UINavigationBar {
    
    public func lt_setBackgroundColor(backgroundColor: UIColor) {
        if overlay == nil {
//            shadowImage = UIImage()
            setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            let height = UIApplication.shared.statusBarFrame.size.height
            overlay = UIView.init(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height + height))
            overlay?.isUserInteractionEnabled = false
            overlay?.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
            subviews.first?.insertSubview(overlay!, at: 0)
        }
        overlay?.backgroundColor = backgroundColor
    }
    
    
    public func lt_setTranslationY(translationY: CGFloat) {
        transform = CGAffineTransform.init(translationX: 0, y: translationY)
    }
    
    
    public func lt_setElementsAlpha(alpha: CGFloat) {
        for (_, element) in subviews.enumerated() {
            if element.isKind(of: NSClassFromString("UINavigationItemView") as! UIView.Type) ||
                element.isKind(of: NSClassFromString("UINavigationButton") as! UIButton.Type) ||
                element.isKind(of: NSClassFromString("UINavBarPrompt") as! UIView.Type)
            {
                element.alpha = alpha
            }
            
            if element.isKind(of: NSClassFromString("_UINavigationBarBackIndicatorView") as! UIView.Type) {
                element.alpha = element.alpha == 0 ? 0 : alpha
            }
        }
        
        items?.forEach({ (item) in
            if let titleView = item.titleView {
                titleView.alpha = alpha
            }
            for BBItems in [item.leftBarButtonItems, item.rightBarButtonItems] {
                BBItems?.forEach({ (barButtonItem) in
                    if let customView = barButtonItem.customView {
                        customView.alpha = alpha
                    }
                })
            }
        })
    }
    
    
    public func lt_reset() {
//        shadowImage = nil
        setBackgroundImage(nil, for: UIBarMetrics.default)
        overlay?.removeFromSuperview()
        overlay = nil
    }
    
    public func lt_removeOverlay() {
        overlay?.removeFromSuperview()
        overlay = nil
    }
}
