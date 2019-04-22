//
//  ViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/19/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
/*extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            
            self.addAttribute(.link, value: linkURL, range: foundRange)
            
            return true
        }
        return false
    }
}*/

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.performSegue(withIdentifier: "mainToMain", sender: self)
        })

        // Do any additional setup after loading the view.
    }


}

