//
//  Dispatch+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/3.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
