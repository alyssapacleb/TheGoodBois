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


class drawView: UIView {

    var currentShape: Shape?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        print("Drawing")
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {return}
        
        drawCircle(using: currentContext, isFilled: true)
        
    }
    
    private func drawCircle (using context: CGContext, isFilled: Bool){
        
        let centerPoint = CGPoint(x: bounds.size.width/2, y: bounds.size.width/2)
        
        context.addArc(center: centerPoint, radius: 50, startAngle: CGFloat(0).degToRad, endAngle: CGFloat(360).degToRad, clockwise: true)
        
        context.setLineWidth(4.0)
        if isFilled {
            context.setFillColor(UIColor(red:0.90, green:0.85, blue:0.95, alpha:1.0).cgColor)
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
