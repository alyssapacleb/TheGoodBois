//
//  Tutorial2ViewController.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 5/5/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class Tutorial2ViewController: UIViewController {

    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var cursor: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startAnimation(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options:[.repeat], animations: {
            self.cursor.center.x = self.cursor.center.x-300
            self.dogImage.center.x = self.dogImage.center.x-375
            
        }, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
