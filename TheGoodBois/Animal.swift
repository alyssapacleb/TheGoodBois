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
    
    var petID:Int?
    var url:String?
    var breed:String?
    var color:String?
    var age:String?
    var sex:String?
    var size:String?
    var coat:String?
    var name:String?
    var bio:String?
    var imgURL:String?
    var image:UIImage?
    
    init(newID:Int?, newURL:String?, newBreed:String?, newColor:String?, newAge:String?, newSex:String?, newSize:String?, newCoat:String?, newName:String?, newBio:String?, newImgURL: String?, newImg:UIImage?) {
        
        self.petID = newID
        self.url = newURL
        self.breed = newBreed
        self.color = newColor
        self.age = newAge
        self.sex = newSex
        self.size = newSize
        self.coat = newCoat
        self.name = newName
        self.bio = newBio
        self.imgURL = newImgURL
        self.image = newImg
        
    }
    
    init() {
        
        self.petID = 0
        self.url = ""
        self.breed = ""
        self.color = ""
        self.age = ""
        self.sex = ""
        self.size = ""
        self.coat = ""
        self.name = ""
        self.bio = ""
        self.imgURL = ""
        
    }
}
