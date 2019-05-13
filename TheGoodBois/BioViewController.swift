//
//  BioViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreData

class BioViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel1: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    var currentPet: Animal?
    
    // Info to be set when view loads
    var pet_name: String?
    var pet_image: UIImage?
    var pet_age: String?
    var pet_breed: String?
    var pet_location: String?
    var pet_sex: String?
    var pet_coat: String?
    var pet_bio: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Extract info from data model
        pet_name = (currentPet!.value(forKeyPath: "name") as! String)
        pet_image = UIImage(named: currentPet!.value(forKeyPath: "img") as! String)!
        pet_age = (currentPet!.value(forKeyPath: "age") as! String)
        pet_breed = (currentPet!.value(forKeyPath: "breed") as! String)
        pet_location = (currentPet!.value(forKeyPath: "loc") as! String)
        pet_sex = (currentPet!.value(forKeyPath: "sex") as! String)
        pet_coat = (currentPet!.value(forKeyPath: "coat") as! String)
        pet_bio = (currentPet!.value(forKeyPath: "bio") as! String)
        */
        
        pet_name = currentPet!.petName
        pet_image = currentPet!.image
        pet_age = currentPet!.age
        pet_breed = currentPet!.breed
        pet_location = currentPet!.location
        pet_sex = currentPet!.sex
        pet_coat = currentPet!.coat
        pet_bio = currentPet!.bio
 
        // Set views
        nameLabel.text = pet_name!
        imageView.image = pet_image!
        infoLabel1.text = pet_age! + ", " + pet_breed!
        locationLabel.text = pet_location!
        sexLabel.text = pet_sex!
        infoLabel2.text = "Coat length: " + pet_coat!
        bioTextView.text = pet_bio!

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
