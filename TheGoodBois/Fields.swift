//
//  Fields.swift
//  TheGoodBois
//
//  Created by Garrett Willis on 5/13/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import SwiftyJSON

// Use Fields class to store returned allowed search field values
class Fields {
    
    var breedVals:[String]
    var colorVals:[String]
    var coatVals:[String]
    
    init(breeds:[String], colors:[String], coats:[String]) {
        
        self.breedVals = breeds
        self.colorVals = colors
        self.coatVals = coats
        
    }
    
    init() {
        
        self.breedVals = [String]()
        self.colorVals = [String]()
        self.coatVals = [String]()
        
    }
    
}
