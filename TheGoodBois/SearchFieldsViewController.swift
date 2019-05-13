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
    var location:String
    var url:String
    var image:UIImage?
    
    init(petID:String?, orgID:String?, breed:String?, color:String?, age:String?, sex:String?, size:String?, coat:String?, petName:String?, bio:String?, status:String?, location:String?, url:String?){
        
        self.petName = petName!
        self.petID = petID!
        self.orgID = orgID!
        self.breed = breed!
        self.color = color!
        self.age = age!
        self.sex = sex!
        self.size = size!
        self.coat = coat!
        self.bio = bio!
        self.status = status!
        self.location = location!
        self.url = url!
       
    }
    
    init() {
        self.petName = ""
        self.petID = ""
        self.orgID = ""
        self.breed = ""
        self.color = ""
        self.age = ""
        self.sex = ""
        self.size = ""
        self.coat = ""
        self.bio = ""
        self.status = ""
        self.location = ""
        self.url = ""
        self.image = UIImage()
    }
    
    func getImage(link:String){
        let urlSession = URLSession.shared
        guard let url = URL(string: link) else { return }
        
        let dataTask = urlSession.dataTask(with: url) {
            (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                guard
                    let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode),
                    let mime = response.mimeType, mime.hasPrefix("image"),
                    let data = data,
                    let image = UIImage(data: data)
                    else {return}
                DispatchQueue.main.async() {
                    self.image = image
                }
            }
        }
        dataTask.resume()
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
    
    // MARK: Variables
    private var dataSession = SearchDataSession()
    
    @IBAction func performSearch(_ sender: Any) {
        print("Button pressed")
        self.dataSession.getData(searchType: "types")
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

// MARK: - SearchDataProtocol
extension SearchFieldsViewController: SearchDataProtocol {
    
    func responseError(message: String) {
        print(message)
    }
    
    func animalsResponseDataHandler(currentData:NSDictionary) -> [Animal] {
    
        // Create empty list of Animal objects to store returned animals
        var animalList = [Animal]()
    
        // Retrieve list of animals returned by query
        let animals = currentData["animals"] as? NSArray
        if animals != nil {
            
            for animal in animals! {
                let animal = animal as! NSDictionary
                let petID = animal["id"] as? String
                let orgID = animal["organization_id"] as? String
                let url = animal["url"] as? String
                let breedDict = animal["breeds"] as? NSDictionary
                let breed = breedDict!["primary"] as? String
                let colorDict = animal["colors"] as? NSDictionary
                let color = colorDict!["primary"] as? String
                let age = animal["age"] as? String
                let sex = animal["gender"] as? String
                let size = animal["size"] as? String
                let coat = animal["coat"] as? String
                let name = animal["name"] as? String
                let bio = animal["description"] as? String
                let status = animal["status"] as? String
                let location = animal["location"] as? String
    
                let newAnimal = Animal(petID:petID, orgID:orgID, breed:breed, color:color, age:age, sex:sex, size:size, coat:coat, petName:name, bio:bio, status:status, location:location, url:url)
                animalList.append(newAnimal)
    
            }
        }
        return animalList
    }
        
    func typesResponseDataHandler(currentData: NSArray) -> Fields {
        // Retrieve list of available field values returned by query
        // Query returns array of all types as dictionary, with name of type and allowed search parameter values as keys
        for animal in currentData {
            let animal = animal as! NSDictionary
            if animal["name"] as! String == self.currentType {
                let coats = animal["coats"] as! [String]
                //coats = coats as! [String]
                let colors = animal["colors"] as! [String]
                //colors = colors as! [String]
                //var sexes = animal["genders"] as? NSArray
                let sexes = animal["genders"] as! [String]
                //sexes = sexes as! [String]
                // TODO: Proper forcecasting of NSArray -> [String]
                let sizes = ["small", "medium", "large", "xlarge"]
                let ages = ["baby", "young", "adult", "senior"]
                
                let newFields = Fields(sexes:sexes, sizes:sizes, colors:colors, ages:ages, coats:coats)
                
                return newFields
                
            }
        }
        
        return Fields()
    }
    
}
