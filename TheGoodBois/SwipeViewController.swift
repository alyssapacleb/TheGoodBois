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
        
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SwipeViewController.imageTapped(gesture:)))
        
        // add it to the image view;
        swipeImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        swipeImageView.isUserInteractionEnabled = true
        
        
        swipeImageView?.image = UIImage(named:imageNames[currentImage])
        var swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture"))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture"))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    
    
    
    
    }

    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            
            //This really don't work
            /*let storyBoard: UIStoryboard = UIStoryboard(name: "petBio", bundle: nil)
            let bioViewController = storyBoard.instantiateViewController(withIdentifier: "petBio")
            self.navigationController.pushViewController(bioViewController, animated: true)
            */
        }
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
