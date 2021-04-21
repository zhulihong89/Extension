//
//  CGFloat+Extension.swift
//  Extension
//
//  Created by lihong on 2020/12/28.
//  Copyright © 2020 lihong. All rights reserved.
//

import Foundation


public protocol ConvertToNumbers {
    var toCGFloat: CGFloat {get}
    var toFloat: Float {get}
    var toDouble: Double {get}
}

// MARK: - CGFloat
public func + <T: ConvertToNumbers> (left: CGFloat, right: T) -> CGFloat {
    return left + right.toCGFloat
}

public func - <T: ConvertToNumbers> (left: CGFloat, right: T) -> CGFloat {
    return left - right.toCGFloat
}

public func * <T: ConvertToNumbers> (left: CGFloat, right: T) -> CGFloat {
    return left * right.toCGFloat
}

public func / <T: ConvertToNumbers> (left: CGFloat, right: T) -> CGFloat {
    return left / right.toCGFloat
}


// MARK: - Float
public func + <T: ConvertToNumbers> (left: Float, right: T) -> Float {
    return left + right.toFloat
}

public func - <T: ConvertToNumbers> (left: Float, right: T) -> Float {
    return left - right.toFloat
}

public func * <T: ConvertToNumbers> (left: Float, right: T) -> Float {
    return left * right.toFloat
}

public func / <T: ConvertToNumbers> (left: Float, right: T) -> Float {
    return left / right.toFloat
}


// MARK: - Double
public func + <T: ConvertToNumbers> (left: Double, right: T) -> Double {
    return left + right.toDouble
}

public func - <T: ConvertToNumbers> (left: Double, right: T) -> Double {
    return left - right.toDouble
}

public func * <T: ConvertToNumbers> (left: Double, right: T) -> Double {
    return left * right.toDouble
}

public func / <T: ConvertToNumbers> (left: Double, right: T) -> Double {
    return left / right.toDouble
}



extension Int: ConvertToNumbers {
    public var toCGFloat: CGFloat { return CGFloat(self) }
    public var toFloat: Float { return Float(self) }
    public var toDouble: Double { return Double(self) }
}

extension Float: ConvertToNumbers {
    public var toCGFloat: CGFloat { return CGFloat(self) }
    public var toFloat: Float { return Float(self) }
    public var toDouble: Double { return Double(self) }
}

extension Double: ConvertToNumbers {
    public var toCGFloat: CGFloat { return CGFloat(self) }
    public var toFloat: Float { return Float(self) }
    public var toDouble: Double { return Double(self) }
}
