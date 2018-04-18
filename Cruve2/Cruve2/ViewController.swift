//
//  ViewController.swift
//  Cruve2
//
//  Created by 王嘉诚 on 2018/4/5.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum State {
        case running , stop
    }
    var state = State.stop

    enum Color {
        case yes , no
    }
    var color = Color.no
    
    let color1:[CGFloat] = [0.909, 0.870, 1.000, 0.600]
    let color2:[CGFloat] = [0.561, 0.973, 0.997, 0.600]
    let count = 1
    var layers = [CAShapeLayer]()
    var savedSpirals = [spiralStruct]()
    var spirals = [spiralStruct]() {
        didSet {
            if spirals.count == 0 {
                showSpiral.text = "Spirals configuration here...\n\n\n\n\n\n\n\n\n\n\n"
                btns[3].isHidden = true
            } else {
                var spiraltaxt = ""
                for spiral in spirals {
                    spiraltaxt += "r1: \(spiral.r1)  r2: \(spiral.r2)  k : \(spiral.k)  speed:  \(spiral.speed) \n"
                }
                //通过计算，这高度它最多能容纳10行，为了使其没有省略号，根据cout数，加换行符
                for _ in 0 ... 10-spirals.count {
                    spiraltaxt += "\n"
                }
                showSpiral.text = spiraltaxt
            }
        }
    }
    
    @IBOutlet var btns: [UIButton]!
    @IBOutlet weak var r1: UITextField!
    @IBOutlet weak var r2: UITextField!
    @IBOutlet weak var k: UITextField!
    @IBOutlet weak var speed: UITextField!
    @IBOutlet weak var showSpiral: UILabel!
    @IBOutlet weak var hue: UITextField!
    @IBOutlet weak var sat: UITextField!
    @IBOutlet weak var bri: UITextField!
    @IBOutlet weak var alpha: UITextField!
    
    @IBAction func saveAction(_ sender: UIButton) {
        guard spirals.count != 0 else {
            //此处没有写无新内容，因为如果我重复保存，此处也不会识别
            let ac = UIAlertController(title: "无内容", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac ,animated: true)
            return
        }
        
        let defaults = UserDefaults.standard
        if let saved = defaults.object(forKey: "spirals") as? Data{
            let jsonDecoder = JSONDecoder()
            do{
                savedSpirals = try jsonDecoder.decode([spiralStruct].self, from: saved)
            } catch {
                print("Failed to load spirals")
            }
        }
        for spiral in spirals {
            savedSpirals.append(spiral)
        }
        
        let jsonEncoder = JSONEncoder()
        if let saved = try? jsonEncoder.encode(savedSpirals) {
            let defaults = UserDefaults.standard
            defaults.set(saved, forKey: "spirals")
        }
        
        let ac = UIAlertController(title: "保存成功！", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(ac ,animated: true)
    }
    
    @IBAction func viewAction(_ sender: UIButton) {
    }
    
    @IBAction func randomAction(_ sender: UIButton) {
        r1.text = String(format: "%.2f", Double.random(50, 400))
        r2.text = String(format: "%.2f", Double.random(-250, 250))
        k.text = String(format: "%.2f", Double.random(0, 2))
        speed.text = String(format: "%.2f", Double.random(0.3, 1.2))
        
        if color == Color.yes {
            hue.text = String(format: "%.2f", Double.random())
            sat.text = String(format: "%.2f", Double.random())
            bri.text = String(format: "%.2f", Double.random())
            alpha.text = String(format: "%.2f", Double.random(0.05,1))
        }
    }
    
    @IBAction func tapAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func colorAction(_ sender: UIButton) {
        if color == .no {
            color = .yes
            hue.isHidden = false
            sat.isHidden = false
            bri.isHidden = false
            alpha.isHidden = false
        } else if color == .yes {
            color = .no
            hue.isHidden = true
            sat.isHidden = true
            bri.isHidden = true
            alpha.isHidden = true
        }
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        guard spirals.count != 0 else {
            let ac = UIAlertController(title: "无内容", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac ,animated: true)
            return
        }
        
        btns[3].isHidden = true
        spirals.removeAll()

        guard layers.count != 0 else { return }
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        layers.removeAll()
        
    }
    
    @IBAction func popAction(_ sender: UIButton) {
        guard spirals.count != 0 else {
            let ac = UIAlertController(title: "无内容", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac ,animated: true)
            return
        }
        
        //其实此处不用判断state的，因为running的时候按钮隐藏了。
        guard state != .running else {
            let ac = UIAlertController(title: "请先暂停", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac ,animated: true)
            return
        }
        if spirals.count == layers.count {
            spirals.removeLast()
            layers.last?.removeFromSuperlayer()
            layers.removeLast()
        } else {
            spirals.removeLast()
        }
    }
    
    @IBAction func pushAction(_ sender: UIButton) {
//        if r1.text != "" && r2.text != "" && k.text != "" && speed.text != ""{
            if let r1_ = Double(r1.text!) {
                if let r2_ = Double(r2.text!) {
                    if let k_ = Double(k.text!) {
                        if let speed_ = Double(speed.text!) {
                            if color == .yes {
                                if let hue_ = Double(hue.text!) {
                                    if let sat_ = Double(sat.text!) {
                                        if let bri_ = Double(bri.text!) {
                                            if let alpha_ = Double(alpha.text!) {
                                                let spiral = spiralStruct(r1: r1_, r2: r2_, k: k_, speed: speed_ ,hue: CGFloat(hue_), sat: CGFloat(sat_), bri: CGFloat(bri_), alpha: CGFloat(alpha_), drawing: false)
                                                spirals.append(spiral)
                                                r1.text = ""
                                                r2.text = ""
                                                k.text  = ""
                                                speed.text = ""
                                                
                                                return
                                            }
                                        }
                                    }
                                }
                            } else {
                                let spiral: spiralStruct
                                if Int.random(0,1) == 0 {
                                    spiral = spiralStruct(r1: r1_, r2: r2_, k: k_, speed: speed_ , hue: color1[0], sat: color1[1], bri: color1[2], alpha: color1[3], drawing: false)
                                } else {
                                    spiral = spiralStruct(r1: r1_, r2: r2_, k: k_, speed: speed_ , hue: color2[0], sat: color2[1], bri: color2[2], alpha: color2[3], drawing: false)
                                }
                                spirals.append(spiral)
                                r1.text = ""
                                r2.text = ""
                                k.text  = ""
                                speed.text = ""
                                
                                return
                            }
                            let ac = UIAlertController(title: "请输入颜色", message: "", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(ac ,animated: true)
                        }
                    }
                }
            }
//        }
        let ac = UIAlertController(title: "请输入合法内容", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(ac ,animated: true)
    }
    
    @IBAction func drawAction(_ sender: UIButton) {
        guard spirals.count != 0 else {
            let ac = UIAlertController(title: "无内容", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac ,animated: true)
            return
        }
        state = .running
        showSpiral.isHidden = true
        if color == .yes {
            color = .no
            hue.isHidden = true
            sat.isHidden = true
            bri.isHidden = true
            alpha.isHidden = true
        }
        //下面代码continue按钮中存在，使得之前以画过的曲线接下去画
        for layer in layers {
            let pausedTime = layer.timeOffset
            layer.speed = 1.0
            layer.timeOffset = 0.0
            layer.beginTime = 0.0
            let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            layer.beginTime = timeSincePause
        }
        for i in 0 ..< spirals.count {
            if !spirals[i].drawing{
                createSpiral(r1: spirals[i].r1, r2: spirals[i].r2, k: spirals[i].k, color: UIColor(hue: spirals[i].hue, saturation: spirals[i].sat, brightness: spirals[i].bri, alpha: spirals[i].alpha), speed: spirals[i].speed)
                spirals[i].drawing = true
            }
        }
        
        for btn in btns {
            if btn.tag != 4 {
                btn.isHidden = true
            } else {
                btn.isHidden = false
            }
        }
        r1.isHidden = true
        r2.isHidden = true
        k.isHidden = true
        speed.isHidden = true
        btns[3].setTitle("Stop", for: .normal)
        
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        if sender.currentTitle == "Stop" {
            state = .stop
            showSpiral.isHidden = false
            for btn in btns {
                if btn.tag != 4 {
                    btn.isHidden = false
                }
            }
            r1.isHidden = false
            r2.isHidden = false
            k.isHidden = false
            speed.isHidden = false
            
            for layer in layers {
                //            layer.removeAllAnimations()
                let currTimeOffset = layer.convertTime(CACurrentMediaTime(), from: nil)
                layer.speed = 0.0
                layer.timeOffset = currTimeOffset
            }
            sender.setTitle("Cotu", for: .normal)
            
        } else if sender.currentTitle == "Cotu" {
            if color == .yes {
                color = .no
                hue.isHidden = true
                sat.isHidden = true
                bri.isHidden = true
                alpha.isHidden = true
            }
            state = .running
            showSpiral.isHidden = true
            for btn in btns {
                if btn.tag != 4 {
                    btn.isHidden = true
                }
            }
            r1.isHidden = true
            r2.isHidden = true
            k.isHidden = true
            speed.isHidden = true
            for layer in layers {
                let pausedTime = layer.timeOffset
                layer.speed = 1.0
                layer.timeOffset = 0.0
                layer.beginTime = 0.0
                let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
                layer.beginTime = timeSincePause
            }
            sender.setTitle("Stop", for: .normal)
            
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = true
        btns[3].isHidden = true
        btns[3].layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        btns[3].layer.shadowColor = UIColor.darkGray.cgColor
        btns[3].layer.shadowOpacity = 0.3
        btns[3].layer.masksToBounds = false
        
        let startWord = "Spirals configuration here...\n\n\n\n\n\n\n\n\n\n\n"
        showSpiral.text = startWord
        hue.isHidden = true
        sat.isHidden = true
        bri.isHidden = true
        alpha.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - createSpiral
    
    func createSpiral(r1:Double ,r2: Double ,k: Double ,color: UIColor ,speed: Double) {
        let r1 = r1
        let r2 = r2
        let k = k
        var angle1 = 0.0
        var angle2 = 0.0
        var t = 0.0
        let midx = Double(self.view.frame.midX)
        let midy = Double(self.view.frame.midY)
        let layer = CAShapeLayer()
        layer.frame = self.view.frame
        let path = UIBezierPath()
        var x = 0.0, y = 0.0
        if r2 > 0 {
            while t < 2500 {
                if t == 0.0 {
                    x = k*r2*cos(angle1-angle2)+(r1-r2)*cos(angle2)
                    y = k*r2*sin(angle1-angle2)-(r1-r2)*sin(angle2)
                    path.move(to: CGPoint(x: x + midx, y: y + midy))
                }
                t += 0.1
                angle1 = t
                angle2 = t*r2/r1
                x = k*r2*cos(angle1-angle2)+(r1-r2)*cos(angle2)
                y = k*r2*sin(angle1-angle2)-(r1-r2)*sin(angle2)
                path.addLine(to: CGPoint(x: x + midx, y: y + midy))
            }
        } else {
            while t < 5000 {
                if t == 0.0 {
                    x = k*r2*cos(angle1+angle2)+(r1-r2)*cos(angle2)
                    y = -k*r2*sin(angle1+angle2)-(r1-r2)*sin(angle2)
                    path.move(to: CGPoint(x: x + midx, y: y + midy))
                }
                t += 0.1
                angle1 = t
                angle2 = t*r2/r1
                x = k*r2*cos(angle1+angle2)+(r1-r2)*cos(angle2)
                y = -k*r2*sin(angle1+angle2)-(r1-r2)*sin(angle2)
                path.addLine(to: CGPoint(x: x + midx, y: y + midy))
            }
        }
        
        
        layer.path = path.cgPath
        layer.lineWidth = 2.0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color.cgColor
        
        let speed = 100.0 / speed
        
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.duration = speed   //持续时间
        baseAnimation.fromValue = 0  //开始值
        baseAnimation.toValue = 1    //结束值
        baseAnimation.repeatDuration = speed  //重复次数
        baseAnimation.fillMode = kCAFillModeForwards
        baseAnimation.isRemovedOnCompletion = false
        layer.add(baseAnimation, forKey: nil) //给ShapeLayer添
        //显示在界面上
        
        layers.append(layer)
        view.layer.addSublayer(layer)
    }
    
    //MARK: - touchesBehaviour
    
    var scale: CGFloat = 1.0 {                            //缩放比例
        didSet {
            if scale <= 0.15 {
                scale = 0.15
            }
        }
    }
    var lastDistance = 0.0                                //双指缩放距离

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastDistance = 0.0
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 2 else { return }
        var positions = [CGPoint]()
        for touch in touches {
            positions.append(touch.location(in: self.view))
        }
        let xx = positions[0].x - positions[1].x
        let yy = positions[0].y - positions[1].y
        let currentDistance = Double(sqrt(xx*xx+yy*yy))
        
        if self.lastDistance == 0.0 {
            self.lastDistance = currentDistance
        } else {
            if self.lastDistance - currentDistance > 0.3 {
                self.lastDistance = currentDistance
                scale -= 0.03
                for layer in layers {
                    layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale))
                }
            } else if self.lastDistance - currentDistance < -0.3 {
                self.lastDistance = currentDistance
                scale += 0.03
                for layer in layers {
                    layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale))
                }
            }
            
        }
    }
    
    /*
    //MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSavedSpirals" {
            let destination = segue.destination as! SavedSpirals
            destination.spirals = spirals
        }
    }
    */

}

