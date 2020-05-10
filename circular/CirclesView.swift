//
//  Circles.swift
//  circular
//
//  Created by Jawad Ali on 09/05/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
@IBDesignable
public class CirclesView: UIView {
    
    //MARK:- properties
    private var numberOfCircles: Int = 2
    private var lineWidth: CGFloat = 8.0
    private var space = 20
    private var color : UIColor = .white
    private static let kRotationAnimationKey = "rotationanimationkey"
   
    private lazy var circularLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = self.lineWidth
        
        return shapeLayer
    }()
    
    //MARK:- inializer
    
    public init(_ circles: Int, circleWidth: CGFloat) {
        self.numberOfCircles = circles
        self.lineWidth = circleWidth
        super.init(frame: .zero)
        addSubLayer()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubLayer()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        addSubLayer()
    }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        addCircles()
        
    }
    
    
}
private extension CirclesView {
    
    func addCircles() {
        circularLayer.bounds = self.bounds
        let bezierPath = UIBezierPath()
        
        let center = CGPoint(x: bounds.maxX / 2, y: bounds.maxY / 2)
        let maximumRadius =  min(bounds.maxX,bounds.maxY)/2 - (lineWidth / 2.0)
        var startAngle = CGFloat(60)
        var endAngle = CGFloat(130)
        
        
        for i in 1...numberOfCircles {
            
            let radius = maximumRadius - CGFloat(i * space)
            let  startX = center.x  + (radius) * CGFloat(cos(startAngle.deg2rad()))
            let  startY = center.y  + (radius) * CGFloat(sin(startAngle.deg2rad()))
            
            bezierPath.move(to: CGPoint(x: startX,y: startY))
            bezierPath.addArc(withCenter: center, radius: radius, startAngle: startAngle.deg2rad(), endAngle: endAngle.deg2rad(), clockwise: false)
            
            startAngle = startAngle - 10
            endAngle = endAngle + 50
            
        }
        
        circularLayer.path = bezierPath.cgPath
    }
    
    func addSubLayer() {
        self.backgroundColor = .clear
        layer.addSublayer(circularLayer)
        
    }
    
    
}

 //MARK:- Public Functions
public extension CirclesView {
    
    func startAnimation(_ reversed: Bool = false, _ duration: Double = 1) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = reversed ? -(Float.pi * 2.0) : Float.pi * 2.0
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.circularLayer.add(rotateAnimation, forKey: Self.kRotationAnimationKey)
    }
    
    func stopAnimation() {
        if let _ = circularLayer.animation(forKey: Self.kRotationAnimationKey)  {
            
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = circularLayer.presentation()?.value(forKeyPath: "transform.rotation")
            rotateAnimation.toValue = 0
            rotateAnimation.duration = 0.5
            rotateAnimation.repeatCount = 0
            rotateAnimation.isRemovedOnCompletion = true
            self.circularLayer.removeAnimation(forKey: Self.kRotationAnimationKey)
            self.circularLayer.add(rotateAnimation, forKey: Self.kRotationAnimationKey)
        }
    }
    
    func pauseLayer(){
        let pausedTime : CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        circularLayer.speed = 0.0
        circularLayer.timeOffset = pausedTime
    }
}


 extension CGFloat {
    func deg2rad() -> CGFloat {
        return self * .pi / 180
    }
}
