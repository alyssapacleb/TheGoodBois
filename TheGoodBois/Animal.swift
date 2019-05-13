//
//  Animal.swift
//  TheGoodBois
//
//  Created by Garrett Willis on 5/13/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import SwiftyJSON

// Use Animal class to store returned animals' data
class Animal {
    
    var petID:String
    var orgID:String
    var url:String
    var species:String
    var breed:String
    var color:String
    var age:String
    var sex:String
    var size:String
    var coat:String
    var environment:[String:JSON]
    var name:String
    var bio:String
    var imgURL:String
    var status:String
    
    init(newID:String?, newOrg:String?, newURL:String?, newSpecies:String?, newBreed:String?, newColor:String?, newAge:String?, newSex:String?, newSize:String?, newCoat:String?, newEnv:[String:JSON]?, newName:String?, newBio:String?, newImg:String?, newStatus:String?){
        
        self.petID = newID!
        self.orgID = newOrg!
        self.url = newURL!
        self.species = newSpecies!
        self.breed = newBreed!
        self.color = newColor!
        self.age = newAge!
        self.sex = newSex!
        self.size = newSize!
        self.coat = newCoat!
        self.environment = newEnv!
        self.name = newName!
        self.bio = newBio!
        self.imgURL = newImg!
        self.status = newStatus!
        
    }
    
    init() {
        
        self.petID = ""
        self.orgID = ""
        self.url = ""
        self.species = ""
        self.breed = ""
        self.color = ""
        self.age = ""
        self.sex = ""
        self.size = ""
        self.coat = ""
        self.environment = [String:JSON]()
        self.name = ""
        self.bio = ""
        self.imgURL = ""
        self.status = ""
        
    }
}
