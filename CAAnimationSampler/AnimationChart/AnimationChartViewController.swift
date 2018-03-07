//
//  AnimationChartViewController.swift
//  CAAnimationSampler
//
//  Created by hiraya.shingo on 2018/03/07.
//  Copyright © 2018 hiraya.shingo. All rights reserved.
//

import UIKit

class AnimationChartViewController: UIViewController {

    @IBOutlet weak var chartView: AnimationChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chartView.drawGraph()
    }
    
    @IBAction func drawButtonDidTap(_ sender: Any) {
        chartView.drawGraph()
    }
}

// http://dev.classmethod.jp/smartphone/ios-count-down-view/
// https://www.raywenderlich.com/90690/modern-core-graphics-with-swift-part-1
class AnimationChartView: UIView {
    
    let pi = Double.pi
    let backgroundGraphColor = UIColor(red: 247/255, green: 241/255, blue: 241/255, alpha: 1)
    let foregroundGraphColor = UIColor(red: 19/255, green: 149/255, blue: 240/255, alpha: 1)
    let shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height) / 2
        let arcWidth: CGFloat = 30
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = CGFloat(pi * 2)
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius - arcWidth / 2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        backgroundGraphColor.setStroke()
        path.stroke()
    }
    
    override func layoutSubviews() {
        shapeLayer.isHidden = true
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height) / 2
        let arcWidth: CGFloat = 30
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius - arcWidth / 2,
                                startAngle: CGFloat(3 * pi / 2),
                                endAngle: CGFloat(pi / 4),
                                clockwise: true)
        
        shapeLayer.frame = bounds
        shapeLayer.lineWidth = arcWidth
        shapeLayer.strokeColor = foregroundGraphColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    func drawGraph() {
        shapeLayer.isHidden = false
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.8
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shapeLayer.add(animation, forKey: "circleAnim")
    }
}
