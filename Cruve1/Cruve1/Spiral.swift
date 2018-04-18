//
//  Spiral.swift
//  Cruve1
//
//  Created by 王嘉诚 on 2018/4/3.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import Foundation
import UIKit

class Spiral: NSObject {
    
    
    func createSpiral(r1:Double ,r2: Double ,k: Double) {
        let r1 = r1
        let r2 = r2
        let k = k
        var angle1 = 0.0
        var angle2 = 0.0
        var t = 0.0
        
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        var x = 0.0, y = 0.0
        
        while t < 500 {
            if t == 0 {
                x = k*r2*cos(angle1-angle2)+(r1-r2)*cos(angle2)
                y = k*r2*sin(angle1-angle2)-(r1-r2)*sin(angle2)
                path.move(to: CGPoint(x: x + 380, y: y + 500))
            }
            t += 0.1
            angle1 = t
            angle2 = t*r2/r1
            x = k*r2*cos(angle1-angle2)+(r1-r2)*cos(angle2)
            y = k*r2*sin(angle1-angle2)-(r1-r2)*sin(angle2)
            path.addLine(to: CGPoint(x: x+380, y: y+500))
        }
        
        layer.path = path.cgPath
        layer.lineWidth = 2.0
        layer.opacity = 0.5
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        layer.strokeStart = 0
        baseAnimation.duration = 50   //持续时间
        baseAnimation.fromValue = 0  //开始值
        baseAnimation.toValue = 1    //结束值
        baseAnimation.repeatDuration = 50  //重复次数
        baseAnimation.fillMode = kCAFillModeForwards
        layer.add(baseAnimation, forKey: nil) //给ShapeLayer添
        //显示在界面上
        //        baseAnimation.isRemovedOnCompletion = false
        
//        view.layer.addSublayer(layer)
    }
}
