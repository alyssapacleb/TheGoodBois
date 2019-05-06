//
//  Logo.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 5/5/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

@IBDesignable class Logo: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let bg = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        bg.fill()
        
        let headOrigin = CGPoint(x: 3*bounds.width/16, y: 3*bounds.height/16)
        let headSize = CGSize(width: bounds.width*0.6, height: bounds.height*0.6)
        let head = UIBezierPath(ovalIn: CGRect(origin: headOrigin, size: headSize))
        UIColor.magenta.setFill()
        head.fill()
        
        let earOrigin = CGPoint(x: bounds.width/8, y: 1*bounds.height/4)
        let earSize = CGSize(width: bounds.width*0.25, height: bounds.height*0.55)
        let ear = UIBezierPath(ovalIn: CGRect(origin: earOrigin, size: earSize))
        UIColor.purple.setFill()
        ear.fill()
        
        let snoutOrigin = CGPoint(x: 5*bounds.width/8, y: 3*bounds.height/8)
        let snoutSize = CGSize(width: bounds.width*0.25, height: bounds.height*0.3)
        let snout = UIBezierPath(ovalIn: CGRect(origin: snoutOrigin, size: snoutSize))
        UIColor.purple.setFill()
        snout.fill()
        
        let noseOrigin = CGPoint(x: 51*bounds.width/64, y: 3*bounds.height/8)
        let noseSize = CGSize(width: bounds.width*0.1, height: bounds.height*0.1)
        let nose = UIBezierPath(ovalIn: CGRect(origin: noseOrigin, size: noseSize))
        UIColor.magenta.setFill()
        nose.fill()
        
        let eyecenter = CGPoint(x: 5*bounds.width/8, y: 3*bounds.height/8)
        let eyeradius = bounds.width/16
        let startAngle: CGFloat = .pi
        let endAngle: CGFloat = 0.0
        let eyePath = UIBezierPath(arcCenter: eyecenter, radius: eyeradius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        eyePath.addLine(to: CGPoint(x: eyecenter.x-eyeradius, y: eyecenter.y))
        UIColor.white.setFill()
        eyePath.fill()
        
    }

}
