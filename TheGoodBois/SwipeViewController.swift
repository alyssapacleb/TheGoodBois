//
//  SwipeViewController.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 4/21/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreData

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var swipeImageView: UIImageView!
    var animalResults: [Animal]?
    var currentAnimal = 0
    var direction = ""
    
    var managedContext: NSManagedObjectContext?
    let convertQueue = DispatchQueue(label: "convertQueue", attributes: .concurrent)
    let saveQueue = DispatchQueue(label: "saveQueue", attributes: .concurrent)
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xfromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y)
        
        if xfromCenter > 0 {
            heart.image = #imageLiteral(resourceName: "heart")
            //heart.tintColor = UIColor.red
        } else {
            heart.image = #imageLiteral(resourceName: "unheart")
            //heart.tintColor = UIColor.blue
        }
        
        heart.alpha = abs(xfromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < 75 {
                // Move off to left
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                    card.alpha = 0
                })
                direction = "left"
                // Reset
                resetImage()
                UIView.animate(withDuration: 0.1, animations: {
                    card.center.x = self.view.center.x
                    card.center.y = self.view.center.y + 200
                    self.heart.alpha = 0
                    card.alpha = 0
                })
                UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                    card.center = self.view.center
                    self.heart.alpha = 0
                    card.alpha = 1
                })
                return
            } else if card.center.x > (view.frame.width - 75) {
                // Move off to right
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                    card.alpha = 0
                })
                direction = "right"
                // Reset
                resetImage()
                UIView.animate(withDuration: 0.1, animations: {
                    card.center.x = self.view.center.x
                    card.center.y = self.view.center.y + 200
                    self.heart.alpha = 0
                    card.alpha = 0
                })
                UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                    card.center = self.view.center
                    self.heart.alpha = 0
                    card.alpha = 1
                })
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
                self.heart.alpha = 0
            })
        }
        
        
    }
    
    
    func resetImage() {
        if direction == "right" {
            let safeNumber = self.currentAnimal
            convertQueue.async{
                guard let img = UIImageJPEGRepresentation(self.animalResults![safeNumber].image!, 1.0) else {
                    return
                }
                
                self.saveQueue.sync(flags: .barrier){
                    // Dummy data
                    // 2
                    let entity = NSEntityDescription.entity(forEntityName: "Pet", in: self.managedContext!)!
                    let pet = NSManagedObject(entity: entity, insertInto: self.managedContext)
                    // 3
                    let age = self.animalResults![safeNumber].age
                    let bio = self.animalResults![safeNumber].bio
                    let breed = self.animalResults![safeNumber].breed
                    let coat = self.animalResults![safeNumber].coat
                    let loc = self.animalResults![safeNumber].location
                    let name = self.animalResults![safeNumber].petName
                    let sex = self.animalResults![safeNumber].sex
                    pet.setValue(age, forKey: "age")
                    pet.setValue(bio, forKey: "bio")
                    pet.setValue(breed, forKey: "breed")
                    pet.setValue(coat, forKey: "coat")
                    pet.setValue(img, forKey: "img")
                    pet.setValue(loc, forKey: "loc")
                    pet.setValue(name, forKey: "name")
                    pet.setValue(sex, forKey: "sex")
                    // 4
                    do {
                        try self.managedContext?.save()
                        savedPets.append(pet)
                        print("Safe number is: \(safeNumber)")
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
            
        }
        
        if direction == "left" || direction == "right" {
            if currentAnimal == animalResults!.count - 1 {
                currentAnimal = 0
                
            }else{
                currentAnimal += 1
                print("Current animal is: \(currentAnimal)")
            }
            swipeImageView.image = animalResults![currentAnimal].image
        }
        /*
         if direction == "right" {
         if currentImage == 0 {
         currentImage = imageNames.count - 1
         }else{
         currentImage -= 1
         }
         swipeImageView.image = UIImage(named: imageNames[currentImage])
         }*/
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.center = self.view.center
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        swipeImageView?.image = animalResults![currentAnimal].image
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Failed to retrieve add delegate")
            return
        }
        self.managedContext = appDelegate.persistentContainer.viewContext
        
        // create tap gesture recognizer
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SwipeViewController.imageTapped(gesture:)))
        
        // add it to the image view;
        //swipeImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        //swipeImageView.isUserInteractionEnabled = true
        
        /*var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        */
        
        
    }
    
    
    /*@objc func imageTapped(gesture: UIGestureRecognizer) {
     // if the tapped view is a UIImageView then set it to imageview
     if (gesture.view as? UIImageView) != nil {
     print("Image Tapped")
     
     //This really don't work
     let storyBoard: UIStoryboard = UIStoryboard(name: "petBio", bundle: nil)
     let bioViewController = storyBoard.instantiateViewController(withIdentifier: "petBio")
     self.navigationController.pushViewController(bioViewController, animated: true)
     
     }
     }*/
    /*
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                if currentImage == imageNames.count - 1 {
                    currentImage = 0
                    
                }else{
                    currentImage += 1
                }
                swipeImageView.image = UIImage(named: imageNames[currentImage])
                
            case UISwipeGestureRecognizerDirection.right:
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
    }*/
    
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
