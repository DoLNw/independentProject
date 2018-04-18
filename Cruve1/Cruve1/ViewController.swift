//
//  ViewController.swift
//  Cruve1
//
//  Created by 王嘉诚 on 2018/4/2.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let view = MyView(frame: CGRect(x: 0, y: 0, width: 500, height: 600))
//        view.createCruve1()
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 100, y: 100))
//        path.addLine(to: CGPoint(x: 500, y: 500))
//        path.close()
//        UIColor.red.setStroke()
//        UIColor.black.setFill()
//        path.stroke()
//        path.fill()
        self.view.isMultipleTouchEnabled = true
        
//        createSpiral(r1: 250, r2: -50, k: 1.231 ,color: UIColor(hue: 0.561, saturation: 0.973, brightness: 0.997, alpha: 0.600))
//        createSpiral(r1: 250, r2: -50, k: 0.635 , color: UIColor(hue: 0.909, saturation: 0.870, brightness: 1.000, alpha: 0.600))
        createSpiral(r1: 250, r2: 50, k: 0.45 ,color: UIColor(hue: 0.561, saturation: 0.973, brightness: 0.997, alpha: 0.600))
        createSpiral(r1: 250, r2: 50, k: 1.5 , color: UIColor(hue: 0.909, saturation: 0.870, brightness: 1.000, alpha: 0.600))
//        createSpiral(r1: 455.8, r2: 123.3, k: 765 ,color: UIColor(hue: 0.561, saturation: 0.973, brightness: 0.997, alpha: 0.600))
//        createSpiral(r1: 200, r2: 123.6, k: 0.765 , color: UIColor(hue: 0.909, saturation: 0.870, brightness: 1.000, alpha: 0.600))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func createFlower() {
        let width: CGFloat = 640
        let height: CGFloat = 640
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0,
                                  width: width, height: height)
        
        let path = CGMutablePath()
        
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            var transform  = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
            
            let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100),
                               transform: &transform)
            
            path.addPath(petal)
        }
        
        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        view.layer.addSublayer(shapeLayer)
    }
    
    func create() {
        let r1 = 498.2332
        let r2 = 345.33
        let k = 0.34
        var angle1 = 0.0
        var angle2 = 0.0
        var t = 0.0
        
        let layer = CAShapeLayer()
//        let path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 300, height: 300))
        let path = UIBezierPath()
        var x = 0.0, y = 0.0
        
        while t < 2500 {
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
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        layer.strokeStart = 0
        baseAnimation.duration = 50   //持续时间
        baseAnimation.fromValue = 0  //开始值
        baseAnimation.toValue = 1    //结束值
        baseAnimation.repeatDuration = 50  //重复次数
//        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = kCAFillModeForwards
        layer.add(baseAnimation, forKey: nil) //给ShapeLayer添
        //显示在界面上
        view.layer.addSublayer(layer)
    }
    
    func createSpiral(r1:Double ,r2: Double ,k: Double ,color: UIColor) {
        let r1 = r1
        let r2 = r2
        let k = k
        var angle1 = 0.0
        var angle2 = 0.0
        var t = 0.0
        
        let layer = CAShapeLayer()
        layer.frame = self.view.frame
        let path = UIBezierPath()
        var x = 0.0, y = 0.0
        if r2 > 0 {
            while t < 500 {
                if t == 0 {
                    x = k*r2*cos(angle1-angle2)+(r1-r2)*cos(angle2)
                    y = k*r2*sin(angle1-angle2)-(r1-r2)*sin(angle2)
                    path.move(to: CGPoint(x: x + 150, y: y + 300))
                }
                t += 0.1
                angle1 = t
                angle2 = t*r2/r1
                x = k*r2*cos(angle1-angle2)+(r1-r2)*cos(angle2)
                y = k*r2*sin(angle1-angle2)-(r1-r2)*sin(angle2)
                path.addLine(to: CGPoint(x: x+150, y: y+380))
            }
        } else {
            while t < 1000 {
                if t == 0 {
                    x = k*r2*cos(angle1+angle2)+(r1-r2)*cos(angle2)
                    y = -k*r2*sin(angle1+angle2)-(r1-r2)*sin(angle2)
                    path.move(to: CGPoint(x: x + 150, y: y + 380))
                }
                t += 0.1
                angle1 = t
                angle2 = t*r2/r1
                x = k*r2*cos(angle1+angle2)+(r1-r2)*cos(angle2)
                y = -k*r2*sin(angle1+angle2)-(r1-r2)*sin(angle2)
                path.addLine(to: CGPoint(x: x+150, y: y+380))
            }
        }
        
        
        layer.path = path.cgPath
        layer.lineWidth = 2.0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color.cgColor
        
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

        layers.append(layer)
        view.layer.addSublayer(layer)
        print(layer.position)
    }
    
    //MARK: - touchesBehaviour
    
    var layers = [CAShapeLayer]()
    var scale: CGFloat = 1.0 {                            //缩放比例
        didSet {
            if scale <= 0 {
                scale = 0
            }
        }
    }
    var lastDistance = 0.0                                //双指缩放距离
    var distance = CGPoint(x: 0.0, y: 0.0)                //单指移动距离
    var distanceX:CGFloat = 0.0 , distanceY:CGFloat = 0.0 //移动距离
    var lastX:CGFloat = 0.0 , lastY:CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastDistance = 0.0
        distance = CGPoint(x: 0.0, y: 0.0)
        lastX = distanceX
        lastY = distanceY
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.count == 1 {
            let position = touches.first!.location(in: self.view)
            if distance == CGPoint(x: 0.0, y: 0.0) {
                distance = position
            } else {
                distanceX = position.x - distance.x + lastX
                distanceY = position.y - distance.y + lastY
                for layer in layers {
                    layer.setAffineTransform(CGAffineTransform(translationX: distanceX, y: distanceY).concatenating(CGAffineTransform(scaleX: scale, y: scale)))
//                    print(layer.position)
                }
            }
        }
        
        guard touches.count == 2 else { return }
        var positions = [CGPoint]()
        for touch in touches {
            positions.append(touch.location(in: self.view))
        }
        let xx = positions[0].x - positions[1].x
        print("xx\(xx)")
        let yy = positions[0].y - positions[1].y
        print("yy\(yy)")
        let currentDistance = Double(sqrt(xx*xx+yy*yy))
        
        if self.lastDistance == 0.0 {
            self.lastDistance = currentDistance
        } else {
            if self.lastDistance - currentDistance > 0.3 {
                self.lastDistance = currentDistance
                scale -= 0.01
                for layer in layers {
                    layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale).concatenating(CGAffineTransform(translationX: distanceX, y: distanceY)))
                    print(layer.position)
                }
            } else if self.lastDistance - currentDistance < -0.3 {
                self.lastDistance = currentDistance
                scale += 0.01
                for layer in layers {
                    layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale).concatenating(CGAffineTransform(translationX: distanceX, y: distanceY)))
                    print(layer.position)
                }
            }
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

