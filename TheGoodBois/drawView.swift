//
//  drawView.swift
//  TheGoodBois
//
//  Created by Daniel Sanchez on 4/26/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

enum Shape {
    case circle
    case elipse
    case filledCircle
    case filledElipse
}

extension FloatingPoint {
    var degToRad: Self { return self * .pi / 180}
}

// Purple color: #c7bfe6, rgb(199, 191, 230)
// White: #ffffff, rgb(255, 255, 255)
class drawView: UIView {
    
    var currentShape: Shape?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        print("Drawing")
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {return}
        
        drawCircle(using: currentContext, isFilled: true)
        drawInnerCircle(using: currentContext, isFilled: true)
        drawInnerMostCircle(using: currentContext, isFilled: true)
    }
    
    private func drawCircle (using context: CGContext, isFilled: Bool){
        
        let centerPoint = CGPoint(x: bounds.size.width/2, y: bounds.size.width/2)
        
        context.addArc(center: centerPoint, radius: 50, startAngle: CGFloat(0).degToRad, endAngle: CGFloat(360).degToRad, clockwise: true)
        
        context.setLineWidth(4.0)
        if isFilled {
            context.setFillColor(UIColor(red:1, green:1, blue:1, alpha:1.0).cgColor)
            context.fillPath()
        }
        else {
            context.setStrokeColor(UIColor.magenta.cgColor)
            context.strokePath()
        }
    }
    
    private func drawInnerCircle (using context: CGContext, isFilled: Bool){
        
        let centerPoint = CGPoint(x: bounds.size.width/2, y: bounds.size.width/2)
        
        context.addArc(center: centerPoint, radius: 30, startAngle: CGFloat(0).degToRad, endAngle: CGFloat(360).degToRad, clockwise: true)
        
        context.setLineWidth(4.0)
        if isFilled {
            context.setFillColor(UIColor(red:199/255, green:191/255, blue:230/255, alpha:1.0).cgColor)
            context.fillPath()
        }
        else {
            context.setStrokeColor(UIColor.magenta.cgColor)
            context.strokePath()
        }
    }
    
    private func drawInnerMostCircle (using context: CGContext, isFilled: Bool){
        
        let centerPoint = CGPoint(x: bounds.size.width/2, y: bounds.size.width/2)
        
        context.addArc(center: centerPoint, radius: 10, startAngle: CGFloat(0).degToRad, endAngle: CGFloat(360).degToRad, clockwise: true)
        
        context.setLineWidth(4.0)
        if isFilled {
            context.setFillColor(UIColor(red:1, green:1, blue:1, alpha:1.0).cgColor)
            context.fillPath()
        }
        else {
            context.setStrokeColor(UIColor.magenta.cgColor)
            context.strokePath()
        }
    }
    
    func drawShape(selectedShape: Shape){
        
        currentShape = selectedShape
        setNeedsDisplay()
    }
    
    
}
