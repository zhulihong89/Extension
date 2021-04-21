//
//  Dictionary+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/8/3.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension Dictionary {
    public var allValues: [Value] {
        var values: [Value] = []
        for (_, value) in self {
            values.append(value)
        }
        
        return values
    }
}
