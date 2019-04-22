//
//  SwipeViewController.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 4/21/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    @IBOutlet weak var swipeImageView: UIImageView!
    let imageNames = ["dog1","dog2","dog3"]
    var currentImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if currentImage == imageNames.count - 1 {
                    currentImage = 0
                    
                }else{
                    currentImage += 1
                }
                swipeImageView.image = UIImage(named: imageNames[currentImage])
                
            case UISwipeGestureRecognizer.Direction.right:
                if currentImage == 0 {
                    currentImage = imageNames.count - 1
                }else{
                    currentImage -= 1
                }
                swipeImageView.image = UIImage(named: imageNames[currentImage])
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
