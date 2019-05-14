//
//  PreferencesViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreLocation
import CoreGraphics
import Alamofire
import SwiftyJSON

// MARK: - Globals
var usedIDs = [Int]()

class PreferencesViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    
    // Picker Options (have to be strings!!!)
    //var breedOptions = [String]()
    let ageOptions = ["Baby", "Young","Adult","Senior"]
    let sizeOptions = ["Small", "Medium","Large","XLarge"]
    let genderOptions = ["Male","Female"]
    //var coatOptions = [String]()
    let coatOptions = ["Hairless", "Short", "Medium",
                       "Long", "Wire", "Curly"]
    //var colorOptions = [String]()
    let colorOptions = ["Apricot / Beige", "Bicolor", "Black", "Brindle", "Brown / Chocolate",
                        "Golden", "Gray / Blue / Silver", "Harlequin", "Merle (Blue)", "Merle (Red)",
                        "Red / Chestnut / Orange", "Sable", "Tricolor (Brown, Black, & White)", "White / Cream", "Yellow / Tan / Blond / Fawn"]
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    var currentTextField: UITextField?
    var searchResults = [Animal]()
    var indexesToRemove = [Int]()
    private var parameters: Parameters = ["type":"dog", "status":"adoptable", "limit":"100", "gender":"",
                                          "size":"", "age":"", "breed":"", "location":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        locationLabel.delegate = self
        
        // LOCATION
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
        
        PetfinderAPIManager.sharedInstance.delegate = self

    }
    
    // MARK: - Actions
    @IBAction func performSearch(_ sender: Any) {
        print("Performing search...")
        self.searchResults = [Animal]()
        self.indexesToRemove = [Int]()
        self.setParams()
        // Perform initial get request to get animal results
        PetfinderAPIManager.sharedInstance.getData(searchType: "animals", searchStr: nil, params: self.parameters, completion: {resultsList in
            let animals = resultsList as! [Animal]
            self.searchResults += animals
            // Perform next search to get additional results
            print("Fetching more results...")
            PetfinderAPIManager.sharedInstance.getData(searchType: "next", searchStr: nil, params: self.parameters, completion: {moreResults in
                var moreAnimals = moreResults as! [Animal]
                self.searchResults += moreAnimals
                self.removeViewedPets()
                var exitEarly = false
                while self.searchResults.count < 20 {
                    if !exitEarly {
                        print("Current # of results: \(self.searchResults.count)\nFetching more results...")
                        PetfinderAPIManager.sharedInstance.getData(searchType: "next", searchStr: nil, params: self.parameters, completion: {moreResults in
                            if moreResults.count != 0 {
                                moreAnimals = moreResults as! [Animal]
                                self.searchResults += moreAnimals
                                self.removeViewedPets()
                            } else {
                                PetfinderAPIManager.sharedInstance.responseError(type: "Missing results", block: "Next", message: "No results found")
                                exitEarly = true
                            }
                        })
                    }
                }
                print("Number of results before segue: \(self.searchResults.count)")
                for index in 0...(self.searchResults.count - 1) {
                    if let imgurl = self.searchResults[index].imgURL {
                        let url = URL(string: imgurl)
                        self.downloadPic(url: url!, completion: { image in
                            self.searchResults[index].image = image
                        })
                    } else {
                        print("Animal w/ empty image url found; removing from results")
                        self.indexesToRemove.append(index)
                    }
                }
                })
            for index in self.indexesToRemove {
                self.searchResults.remove(at: index)
            }
            print("Performing segue...")
            self.performSegue(withIdentifier: "swipeViewSegue", sender: self)
            })
    }
    
    // Use globals set by switches in table view to set query parameters
    func setParams() {
        let genders = gender_male + "," + gender_female
        let sizes = size_Small + "," + size_Medium + "," + size_Large + "," + size_Xlarge
        let ages = age_Baby + "," + age_Young + "," + age_Adult + "," + age_Senior
        
        if let breedText = self.breedTextField!.text {
            self.parameters["breed"] = breedText
        } else {
            self.parameters["breed"] = ""
        }
        if let locText = self.locationLabel!.text {
            self.parameters["location"] = locText
        } else {
            self.parameters["location"] = ""
        }
        self.parameters["gender"] = genders
        self.parameters["size"] = sizes
        self.parameters["age"] = ages
    }
    
    // Function to iterate through search results and remove pets who have already been viewed
    // Note: Core data saving of used IDs was not implemented due to time constraints so this function does not do anything at the moment
    func removeViewedPets() {
        for index in 0...(self.searchResults.count - 1) {
            if let newID = self.searchResults[index].petID {
                if usedIDs.contains(newID) {
                    self.searchResults.remove(at: index)
                }
            }
        }
    }
    
    // Function to download images from url
    func downloadPic(url: URL, completion: @escaping (UIImage) -> ()) {
        Alamofire.request(url).responseData(completionHandler: { response in
            if let newImageData = response.result.value {
                let newImage = UIImage(data: newImageData)!
                completion(newImage)
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationLabel.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in prepare for segue")
        if segue.identifier == "swipeViewSegue" {
            let ExchangeViewData = segue.destination as! SwipeViewController
            ExchangeViewData.animalResults = searchResults
        }
    }
    
    // TOOLBAR FUNCTIONS
    
    @objc func donePressed(sender: UIBarButtonItem) {
        
        currentTextField?.resignFirstResponder()
        
    }
    
}

// MARK: - Location managing
extension PreferencesViewController: CLLocationManagerDelegate {

    @IBAction func UseUserLocation(_ sender: UIButton) {
        
        print("Inside function")
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            print("services enabled")
        } else {
            //locationManager.requestWhenInUseAuthorization()
            print("services disabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        print("updating")
        locationLabel.text = (NSNumber(value: (userLocation?.coordinate.latitude)! as Double)).stringValue+", "+(NSNumber(value: (userLocation?.coordinate.longitude)! as Double)).stringValue
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}

// MARK: - PetfinderAPIProtocol
extension PreferencesViewController: PetfinderAPIProtocol {
    
    func requestError(errType: String) {
        print("requestError called with error type: \(errType)")
    }
    
}
