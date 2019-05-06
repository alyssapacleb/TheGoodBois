//
//  Logo.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 5/5/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

@IBDesignable class Logo: UIView {
    
    //rgb(199, 191, 230)
    var light_purp = UIColor(displayP3Red: 199/255, green: 191/255, blue: 230/255, alpha: 1)
    
    //rgb(151, 145, 173)
    var dark_purp = UIColor(displayP3Red: 151/255, green: 145/255, blue: 173/255, alpha: 1)
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        //SET THE CONTEXT
        var ctx = UIGraphicsGetCurrentContext();
        
        // Drawing code
        let bg = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        bg.fill()
        
        let headOrigin = CGPoint(x: 3*bounds.width/16, y: 3*bounds.height/16)
        let headSize = CGSize(width: bounds.width*0.6, height: bounds.height*0.6)
        let head = UIBezierPath(ovalIn: CGRect(origin: headOrigin, size: headSize))
        ctx!.setFillColor(light_purp.cgColor);
        head.fill()
        
        let earOrigin = CGPoint(x: bounds.width/8, y: 1*bounds.height/4)
        let earSize = CGSize(width: bounds.width*0.25, height: bounds.height*0.55)
        let ear = UIBezierPath(ovalIn: CGRect(origin: earOrigin, size: earSize))
        ctx!.setFillColor(dark_purp.cgColor);
        ear.fill()
        
        let snoutOrigin = CGPoint(x: 5*bounds.width/8, y: 3*bounds.height/8)
        let snoutSize = CGSize(width: bounds.width*0.25, height: bounds.height*0.3)
        let snout = UIBezierPath(ovalIn: CGRect(origin: snoutOrigin, size: snoutSize))
        ctx!.setFillColor(dark_purp.cgColor);
        snout.fill()
        
        let noseOrigin = CGPoint(x: 51*bounds.width/64, y: 3*bounds.height/8)
        let noseSize = CGSize(width: bounds.width*0.1, height: bounds.height*0.1)
        let nose = UIBezierPath(ovalIn: CGRect(origin: noseOrigin, size: noseSize))
        ctx!.setFillColor(light_purp.cgColor);
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
