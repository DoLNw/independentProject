//
//  RandomHelper.swift
//  Cruve2
//
//  Created by 王嘉诚 on 2018/4/7.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    public static func random(_ lower: Int = 0 , _ upper: Int = Int.max) -> Int{
        return lower + Int(arc4random_uniform(UInt32(upper-lower+1)))
    }
    
    public static func random(_ range: Range<Int>) -> Int {
        return random(range.upperBound, range.upperBound)
    }
}

public extension Bool {
    public static func random() -> Bool {
        return Int.random(0,1) == 0
    }
}

public extension Double {
    public static func random(_ lower: Double = 0, _ upper: Double = 1) -> Double {
        return (Double(arc4random())) / 0xFFFFFFFF * (upper - lower) + lower
    }
}

public extension Float {
    public static func random(_ lower: Float = 0, _ upper: Float = 1) -> Float {
        return Float(arc4random()) / 0xFFFFFFFF * (upper - lower) + lower
    }
}

public extension CGFloat {
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

