//
//  UITextField+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/17.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension UITextField: UITextFieldDelegate {
    private struct AssociatedObKeys {
        static var nextInputView = "UITextField_nextInputView"
    }
    
    public func addReturnHide() {
        delegate = self
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextInputView = self.nextInputView else {
            textField.resignFirstResponder()
            return false
        }
        nextInputView.becomeFirstResponder()
        
        return false
    }
    
    public var nextInputView: UIResponder? {
        set {
            delegate = self
            returnKeyType = newValue == nil ? .done : .next
            objc_setAssociatedObject(self, &AssociatedObKeys.nextInputView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedObKeys.nextInputView) as? UIResponder
        }
    }

}
