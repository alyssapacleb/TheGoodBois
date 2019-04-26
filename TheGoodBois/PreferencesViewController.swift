//
//  PreferencesViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    
    @IBOutlet weak var drawView: drawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView.drawShape(selectedShape: .circle)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
