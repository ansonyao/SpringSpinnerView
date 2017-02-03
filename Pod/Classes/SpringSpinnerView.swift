//
//  SpinnerViewSpringBased.swift
//  GMSpinner
//
//  Created by Anson Yao on 2017-01-05.
//  Copyright © 2017 TTT. All rights reserved.
//

import UIKit

@IBDesignable
public class SpringSpinnerView: UIView {
    @IBInspectable public var radius: CGFloat = CGFloat(40.0)
    @IBInspectable public var warningColor: UIColor = UIColor(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
    @IBInspectable public var regularColor: UIColor = UIColor.blue
    @IBInspectable public var baseSpeed: Double = 2.0 * Double.pi
    
    private var speedFactor = 3.0
    private var sameSpeedState = false
    private var startPointAngle = 0.0
    private var endPointAngle = Double.pi / 2.0
    private var markedStartPointAngle = 0.0
    private var startPointVelocity = 0.0
    private var endPointVelocity = 0.0
    private var shapeLayer = CAShapeLayer()
    
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
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle:  CGFloat(startPointAngle), endAngle: CGFloat(endPointAngle), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.opacity = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = regularColor.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.frame = bounds
        layer.addSublayer(shapeLayer)
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateView))
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        startPointVelocity = baseSpeed
        endPointVelocity = speedFactor * baseSpeed
    }
    
    func stopAnimation() {
        displayLink?.invalidate()
    }
    
    func updateView() {
        guard let strongDisplayLink = displayLink else { return }
        updateAngle(time: strongDisplayLink.duration)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startPointAngle), endAngle: CGFloat(endPointAngle), clockwise: true)
        shapeLayer.path = path.cgPath
    }
    
    func updateAngle(time: Double) {
        endPointAngle = endPointAngle + endPointVelocity * time
        startPointAngle = startPointAngle + startPointVelocity * time
        
        if (startPointVelocity != endPointVelocity) && endPointAngle - startPointAngle >= 1.5 * Double.pi {
            endPointVelocity = baseSpeed
            markedStartPointAngle = startPointAngle
        }
        if (startPointVelocity == endPointVelocity) && (startPointAngle - markedStartPointAngle > 0.5 * Double.pi) {
            startPointVelocity = speedFactor * baseSpeed
        }
        
        if startPointAngle > endPointAngle {
            var tmp = startPointAngle
            startPointAngle = endPointAngle
            endPointAngle = tmp
            
            tmp = startPointVelocity
            startPointVelocity = endPointVelocity
            endPointVelocity = tmp
            shapeLayer.strokeColor = warningColor.cgColor
        }
      
      if endPointAngle - startPointAngle < Double.pi * 0.8 {
        shapeLayer.opacity = Float((endPointAngle - startPointAngle) / (Double.pi * 0.8))
      }
    }
}
