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
    @IBOutlet weak var swipeNameLabel: UILabel!
    var animalResults: [Animal]?
    var currentAnimal = 0
    var direction = ""
    
    var managedContext: NSManagedObjectContext?
    let convertQueue = DispatchQueue(label: "convertQueue", attributes: .concurrent)
    let saveQueue = DispatchQueue(label: "saveQueue", attributes: .concurrent)
    
    @IBAction func tapCard(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "swipeToBioSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeToBioSegue" {
            let ExchangeViewData = segue.destination as! BioViewController
            ExchangeViewData.currentPet = searchResults[currentAnimal]
        }
    }
    
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
            guard let image = searchResults[safeNumber].image else {
                print("resetImage(): Nil image found")
                return
            }
            convertQueue.async{
                guard let img = UIImageJPEGRepresentation(image, 1.0) else {
                    return
                }
                
                self.saveQueue.sync(flags: .barrier){
                    
                    // Grab pet entity from core data
                    let entity = NSEntityDescription.entity(forEntityName: "Pet", in: self.managedContext!)!
                    let pet = NSManagedObject(entity: entity, insertInto: self.managedContext)
                    
                    // Grab new values from Animal object
                    let id = searchResults[safeNumber].petID
                    let url = searchResults[safeNumber].url
                    let breed = searchResults[safeNumber].breed
                    let color = searchResults[safeNumber].color
                    let age = searchResults[safeNumber].age
                    let sex = searchResults[safeNumber].sex
                    let size = searchResults[safeNumber].size
                    let coat = searchResults[safeNumber].coat
                    let name = searchResults[safeNumber].name
                    let bio = searchResults[safeNumber].bio
                    let imgURL = searchResults[safeNumber].imgURL
                    
                    // Set values for new pet core data object
                    pet.setValue(id, forKey: "id")
                    pet.setValue(age, forKey: "age")
                    pet.setValue(bio, forKey: "bio")
                    pet.setValue(breed, forKey: "breed")
                    pet.setValue(coat, forKey: "coat")
                    pet.setValue(img, forKey: "img")
                    pet.setValue(name, forKey: "name")
                    pet.setValue(sex, forKey: "sex")
                    pet.setValue(size, forKey: "size")
                    pet.setValue(url, forKey: "url")
                    pet.setValue(color, forKey: "color")
                    pet.setValue(imgURL, forKey: "imgURL")
                    
                    // Save pet object to core data
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
            if currentAnimal == searchResults.count - 1 {
                currentAnimal = 0
                
            } else{
                currentAnimal += 1
                print("Current animal is: \(currentAnimal)")
            }
            swipeImageView.image = searchResults[currentAnimal].image
            swipeNameLabel.text = searchResults[currentAnimal].name
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.center = self.view.center
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        swipeImageView?.image = searchResults[currentAnimal].image
        swipeNameLabel?.text = searchResults[currentAnimal].name
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Failed to retrieve add delegate")
            return
        }
        self.managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
