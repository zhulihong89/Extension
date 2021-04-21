//
//  CGPoint+Extension.swift
//  Extension
//
//  Created by lihong on 2020/12/19.
//  Copyright © 2020 lihong. All rights reserved.
//

import UIKit


public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (left:inout CGPoint, right: CGPoint) {
    left.x = left.x + right.x
    left.y = left.y + right.y
}


public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -= (left:inout CGPoint, right: CGPoint) {
    left.x = left.x - right.x
    left.y = left.y - right.y
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

public func *= (left:inout CGPoint, right: CGFloat) {
    left.x = left.x * right
    left.y = left.y * right
}

public func * (left: CGFloat, right: CGPoint) -> CGPoint {
    return CGPoint(x: left * right.x, y: left * right.y)
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}


extension CGPoint {
    public func getVector(cross line: CGPoint) -> CGPoint {
        let x1 = line.x
        let y1 = line.y
        let x2 = x
        let y2 = y
        
        return CGPoint(x: y1*(y1*x2 - y2*x1) / (y1*y1 + x1*x1), y: -x1*(y1*x2 - y2*x1) / (y1*y1 + x1*x1))
    }
    
    public func getVector(at direction: CGPoint) -> CGPoint {
        let x1 = x
        let y1 = y
        let x2 = direction.x
        let y2 = direction.y

        return CGPoint(x: x2*(x1*x2+y1*y2)/(y2*y2+x2*x2), y: y2*(x1*x2+y1*y2)/(y2*y2+x2*x2))
    }
    
    public func oneVector() -> CGPoint {
        let vectorLen = sqrt(x * x + y * y)
        
        return CGPoint(x: x / vectorLen, y: y / vectorLen)
    }
    
    public func distance(to point: CGPoint) -> CGFloat {
        return hypot((self.x - point.x), (self.y - point.y))
    }
}


public extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}



public func + (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(top: left.top + right.top,
                        left: left.left + right.left,
                        bottom: left.bottom + right.bottom,
                        right: left.right + right.right)
}
