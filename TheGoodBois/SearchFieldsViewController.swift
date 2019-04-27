//
//  SearchFieldsViewController.swift
//  TheGoodBois
//
//  Created by Don Hogan on 4/26/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//
// MARK: - Import statements
import UIKit
import Foundation

// MARK: - Results classes
// Use Animal class to store returned animals' data
class Animal {
    
    var petName:String
    var petID:String
    var orgID:String
    var breed:String
    var color:String
    var age:String
    var sex:String
    var size:String
    var coat:String
    var bio:String
    var status:String
    var url:String
    
    init(name:String, petID:String, orgID:String, breed:String, color:String, age:String, sex:String, size:String, coat:String, petName:String, bio:String, status:String, url:String){
        
        self.petName = petName
        self.petID = petID
        self.orgID = orgID
        self.breed = breed
        self.color = color
        self.age = age
        self.sex = sex
        self.size = size
        self.coat = coat
        self.bio = bio
        self.status = status
        self.url = url
       
    }
    
    init() {
        
    }
    
}

// Use Fields class to store returned allowed search field values
class Fields {
    
    var sexVals = [String]()
    var sizeVals = [String]()
    var colorVals = [String]()
    var ageVals = [String]()
    var coatVals = [String]()
    
    init(sexes:[String], sizes:[String], colors:[String], ages:[String], coats:[String]) {
        
        self.sexVals = sexes
        self.sizeVals = sizes
        self.colorVals = colors
        self.ageVals = ages
        self.coatVals = coats
        
    }
    
    init() {
        
    }
    
}

class SearchFieldsViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    
    @IBAction func performSearch(_ sender: Any) {
    }
    
    // MARK: - Properties
    private var currentType = ""
    private var currentFields = Fields()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeField.delegate = self
        breedField.delegate = self
        sizeField.delegate = self
        sexField.delegate = self
        ageField.delegate = self
        colorField.delegate = self
        locationField.delegate = self
        distanceField.delegate = self
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
/*
// MARK: - SearchDataProtocol
extension SearchFieldsViewController: SearchDataProtocol {
    
    func animalsResponseDataHandler(currentData:NSDictionary) -> [Animal] {
    
        // Create empty list of Animal objects to store returned animals
        var animalList = [Animal]()
    
        // Retrieve list of animals returned by query
        let animals = currentData!["animals"] as? NSArray
        if animals != nil {
            
            for animal in animals {
                var petID = currentData!["id"] as? Int
                var orgID = currentData["organization_id"] as? String
                let url = currentData["url"] as? String
                let breedDict = currentData["breeds"] as? NSDictionary
                let breed = breed_dict!["primary"] as? String
                let colorDict = currentData["colors"] as? NSDictionary
                let color = colorDict!["primary"] as? String
                let age = currenttData!["age"] as? String
                let sex = currentData!["gender"] as? String
                let size = currentData!["size"] as? String
                let coat = currentData!["coat"] as? String
                let name = currentData!["name"] as? String
                let bio = currentData!["description"] as? String
                let status = currentData!["status"] as? String
    
                let newAnimal = Animal(name:name, petID:petID, orgID:orgID, url:url, breed:breed, color:color, age:age, sex:sex, size:size, coat:coat, bio:bio, status:status)
                animalList.append(newAnimal)
    
        }
    
        return animalList
    }
    
    func typesResponseDataHandler(currentData:NSArray) -> Fields {
        
        // Retrieve list of available field values returned by query
        // Query returns array of all types as dictionary, with name of type and allowed search parameter values as keys
        for animal in currentdata as? NSDictionary {
            if animal!["name"] == self.currentType {
    
                let coats = animal!["coats"] as? NSArray
                let colors = animal!["colors"] as? NSArray
                let sexes = animal!["genders"] as? NSArray
                let sizes = ["small", "medium", "large", "xlarge"]
                let ages = ["baby", "young", "adult", "senior"]
    
                let newFields = Fields(coats:coats, colors:colors, sexes:sexes, sizes:sizes, ages:ages)
                
                return newFields
    
            }
        }
        
        return Fields()
        
    }
    
    func responseError(message:String) {
        print(message)
    }
    
}
*/
