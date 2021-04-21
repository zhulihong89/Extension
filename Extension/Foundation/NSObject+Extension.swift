//
//  NSObject+Extension.swift
//  QYOrder
//
//  Created by lihong on 2019/8/22.
//  Copyright © 2019 qy. All rights reserved.
//

import UIKit

public func objectSwitchMethod(_ aclass: AnyClass,origina: Selector, swizze: Selector) {
    guard let originaMethodC = class_getInstanceMethod(aclass, origina),
        let swizzeMethodC  = class_getInstanceMethod(aclass, swizze) else {
            assert(false, "\(aclass): \(origina) \(swizze) 方法交换失败")
            return
    }
    
    //替换类中已有方法的实现,如果该方法不存在添加该方法
    //获取方法的Type字符串(包含参数类型和返回值类型)
    //class_replaceMethod(object_getClass(self), #selector(self.swizzeMethod), method_getImplementation(originaMethodC), method_getTypeEncoding(originaMethodC))
    method_exchangeImplementations(originaMethodC, swizzeMethodC)
}


public protocol SwitchMethod {
    static func switchMethod();
}
