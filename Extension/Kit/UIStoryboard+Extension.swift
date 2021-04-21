
//
//  UIStoryboard+Extension.swift
//  Extension
//
//  Created by lihong on 2020/7/2.
//  Copyright © 2020 lihong. All rights reserved.
//

import Foundation


extension UIStoryboard {
    
    public func instantiate<T>(_ name: String) -> T {
        return self.instantiateViewController(withIdentifier: name) as! T
    }
    
}
