//
//  MyView.swift
//  Cruve1
//
//  Created by 王嘉诚 on 2018/4/2.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class MyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        print("init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCruve1() {
        print("bbb")
        let path = UIBezierPath()
        var x = 0.0, y = 0.0
        path.move(to: CGPoint(x: x, y: y))
        
        while x < 10000 {
            x += 0.01
            y = 100*sin(x)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.lineWidth = 5.0
        
        UIColor.black.setStroke()
        path.stroke()
        UIColor.red.setFill()
        path.fill()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("aaa")
        createCruve1()
    }

    

}
