//
//  Array+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/16.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    public mutating func remove(of element: Element)  {
        guard let idx = firstIndex(of: element) else {
            return
        }
        remove(at: idx)
    }
    
    public func shuffle() -> [Element] {
        var list = self
        for index in 0..<count {
            let nexIdex = Int(arc4random_uniform(UInt32(count - index))) + index
            if index != nexIdex {
                list.swapAt(index, nexIdex)
            }
        }
        
        return list
    }
    
    public mutating func move(from position: Int, to toPostion: Int) {
        guard position < count && toPostion < count else {
            return
        }
        
        let element = self[position]
        remove(at: position)
        insert(element, at: toPostion)
    }
    
}

extension Array {
    public func object(of index: Int) -> Element? {
        guard index >= 0, index < count else {
            return nil
        }
        
        return self[index]
    }
}


public func + <K, V> (left: [K:V], right: [K:V]) -> [K:V] {
    var map = left
    for (k, v) in right {
        map[k] = v
    }
    
    return map
}

public func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

extension Array {
    public func get(_ block: (Element) -> Bool) -> Element? {
        for ele in self {
            if block(ele) {
                return ele
            }
        }
        
        return nil
    }
}

