//
//  SpinnerView.swift
//  GMSpinner
//
//  Created by Anson Yao on 2017-01-04.
//  Copyright © 2017 Anson Yao. All rights reserved.
//

import UIKit

@IBDesignable
public class PendulumSpinnerView: UIView {
    @IBInspectable public var color: UIColor = UIColor.blue
    @IBInspectable public var radius: CGFloat = CGFloat(40.0)
    
    private var startAngle = 0.0
    private var endAngle = Double.pi
    private var shapeLayer = CAShapeLayer()
    var velocityAtSummit = 3.0
    var gravityMultiplyRadiusFactor = 100.0
    private var displayLink: CADisplayLink?

    //MARK: - Initializers
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        startAnimation()
    }
    
    func startAnimation() {
        if shapeLayer.superlayer != nil {
            shapeLayer.removeFromSuperlayer()
        }
        shapeLayer = CAShapeLayer()
        let center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle:  CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.opacity = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.frame = bounds
        layer.addSublayer(shapeLayer)
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateView))
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func stopAnimation() {
        displayLink?.invalidate()
    }
    
    func updateView() {
        guard let strongDisplayLink = displayLink else { return }
        startAngle = updateAngle(angle: startAngle, time: strongDisplayLink.duration)
        endAngle = updateAngle(angle: endAngle, time: strongDisplayLink.duration)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.opacity = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.frame = bounds
    }
    
    func updateAngle(angle: Double, time: Double) -> Double {
        let convertedPotentialEnergy = (1 - cos(angle)) * gravityMultiplyRadiusFactor
        let velocity = sqrt(convertedPotentialEnergy + velocityAtSummit * velocityAtSummit)
        return angle + velocity * time
    }
}
