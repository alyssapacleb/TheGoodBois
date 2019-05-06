//
//  ViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/19/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreData
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

var savedPets: [NSManagedObject] = []

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.performSegue(withIdentifier: "mainToMain", sender: self)
        })

        // Do any additional setup after loading the view.
        // Dummy data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Pet", in: managedContext)!
        
        let pet = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        let age = "Young"
        let bio = "Look, I know my pictures make me look like I am a big doofus. Am I big? yes. Am I a doofus? Ok, also yes. But I'm a very very SWEET doofus.\n\nCary (Carrot Top aka Care Bear) is a young guy. He's probably maybe only a year and a half old with the energy and vigor of a much younger pup. He loves to play, he loves to bark, he loves to jump up on your face and smother you with drooly kisses. He is NOT a delicate flower, to put it mildly. He would make an AWFUL apartment dog--his bark can be heard several states over. He has the will to climb up on countertops but all the grace and skill of a drunken walrus. If you're looking for a calm companion, we can direct you to several other wonderful, deserving dogs. But if you're looking for a lotta fun and a lotta love and heart of gold, Cary's your guy. This loveable mug is fostering in the Austin area."
        let breed = "Cocker Spaniel"
        let coat = "Long"
        let img = "dog1"
        let loc = "Austin, Texas"
        let name = "Cary"
        let sex = "Male"
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
            try managedContext.save()
            savedPets.append(pet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}

