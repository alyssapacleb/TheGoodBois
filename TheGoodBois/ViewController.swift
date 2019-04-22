//
//  ViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/19/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.performSegue(withIdentifier: "mainToPreferences", sender: self)
        })

        // Do any additional setup after loading the view.
    }


}

