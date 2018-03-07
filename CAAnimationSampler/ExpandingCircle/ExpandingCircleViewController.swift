//
//  ViewController.swift
//  CAAnimationSampler
//
//  Created by hiraya.shingo on 2018/03/07.
//  Copyright © 2018 hiraya.shingo. All rights reserved.
//

import UIKit

class ExpandingCircleViewController: UIViewController {

    @IBOutlet weak var circleView: ExpandingCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleView.animate()
    }
}

class ExpandingCircleView: UIView {
    
    var circleLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.fillColor = UIColor.black.withAlphaComponent(0.2).cgColor
        circleLayer.needsDisplayOnBoundsChange = true
        layer.addSublayer(circleLayer)
    }
    
    func animate() {
        let startSize = CGSize(width: 100, height: 100)
        let inset = (bounds.width / 2) - (startSize.width / 2)
        let startRect = bounds.insetBy(dx: inset,
                                       dy: inset)
        let startPath = UIBezierPath(ovalIn: startRect).cgPath
        circleLayer.path = startPath
        
        let endPath = UIBezierPath(ovalIn: bounds).cgPath
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.toValue = endPath
        pathAnimation.duration = 2
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue   = 0
        fadeOutAnimation.duration  = 1
        fadeOutAnimation.beginTime = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = pathAnimation.duration + fadeOutAnimation.duration
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [pathAnimation, fadeOutAnimation]
        
        circleLayer.add(animationGroup,
                        forKey: nil)
    }
}
