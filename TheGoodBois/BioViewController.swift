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
    var pet_url: String?
    var pet_breed: String?
    var pet_color: String?
    var pet_age: String?
    var pet_sex: String?
    var pet_size: String?
    var pet_coat: String?
    var pet_bio: String?
    var pet_imgURL: String?
    var pet_image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pet_url = currentPet!.url
        pet_breed = currentPet!.breed
        pet_color = currentPet!.color
        pet_age = currentPet!.age
        pet_sex = currentPet!.sex
        pet_size = currentPet!.size
        pet_coat = currentPet!.coat
        pet_name = currentPet!.name
        pet_bio = currentPet!.bio
        pet_image = currentPet!.image
        
        // Set views
        if pet_name != nil {
            nameLabel.text = pet_name
        } else {
            nameLabel.text = "-"
        }
        var infoLabel1Text = ""
        if pet_age != nil {
            infoLabel1Text = pet_age! + ", "
        } else {
            infoLabel1Text = "-,"
        }
        if pet_breed != nil {
            infoLabel1Text += pet_breed!
        } else {
            infoLabel1Text += "-"
        }
        infoLabel1.text = infoLabel1Text
        
        var infoLabel2Text = ""
        if pet_coat != nil {
            infoLabel2Text = "Coat: " + pet_coat! + ", "
        } else {
            infoLabel2Text = "Coat: -, "
        }
        if pet_color != nil {
            infoLabel2Text += pet_color!
        } else {
            infoLabel2Text += "-"
        }
        infoLabel2.text = infoLabel2Text
        
        var bioLabelText = ""
        if pet_bio != nil {
            bioLabelText = pet_bio!
        } else {
            bioLabelText = "No bio available"
        }
        if pet_url != nil {
            bioLabelText += "\n\n\n\(pet_url!)"
        } else {
            bioLabelText += ""
        }
        bioTextView.text = bioLabelText
        
        var sexLabelText = ""
        if pet_sex != nil {
            sexLabelText = pet_sex! + ", "
        } else {
            sexLabelText = "-, "
        }
        if pet_size != nil {
            sexLabelText += pet_size!
        } else {
            sexLabelText += "-"
        }
        sexLabel.text = sexLabelText
        
        if pet_image != nil {
            imageView.image = pet_image!
        } else {
            imageView.image = UIImage()
        }
    }

}
