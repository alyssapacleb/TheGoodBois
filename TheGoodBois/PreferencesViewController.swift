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
var searchResults = [Animal]()

class PreferencesViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    var currentTextField: UITextField?
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
        searchResults = [Animal]()
        self.indexesToRemove = [Int]()
        self.setParams()
        // Perform initial get request to get animal results
        PetfinderAPIManager.sharedInstance.getData(searchType: "animals", searchStr: nil, params: self.parameters, completion: {resultsList in
            let animals = resultsList as! [Animal]
            searchResults += animals
            // Perform next search to get additional results
            print("Fetching more results...")
            PetfinderAPIManager.sharedInstance.getData(searchType: "next", searchStr: nil, params: self.parameters, completion: {moreResults in
                var moreAnimals = moreResults as! [Animal]
                searchResults += moreAnimals
                self.removeViewedPets()
                var exitEarly = false
                while searchResults.count < 20 {
                    if !exitEarly {
                        print("Current # of results: \(searchResults.count)\nFetching more results...")
                        PetfinderAPIManager.sharedInstance.getData(searchType: "next", searchStr: nil, params: self.parameters, completion: {moreResults in
                            if moreResults.count != 0 {
                                moreAnimals = moreResults as! [Animal]
                                searchResults += moreAnimals
                                self.removeViewedPets()
                            } else {
                                PetfinderAPIManager.sharedInstance.responseError(type: "Missing results", block: "Next", message: "No results found")
                                exitEarly = true
                            }
                        })
                    }
                }
                print("Number of results before segue: \(searchResults.count)")
                if(searchResults.count > 0) {
                    var completeRequests: Int = 0
                    var seguePerformed: Bool = false
                    for index in 0...(searchResults.count - 1) {
                        if let imgurl = searchResults[index].imgURL {
                            let url = URL(string: imgurl)
                            self.downloadPic(url: url!, completion: { image in
                                completeRequests += 1
                                searchResults[index].image = image
                                if completeRequests > 20 && !seguePerformed {
                                    print("Performing segue...")
                                    self.performSegue(withIdentifier: "swipeViewSegue", sender: self)
                                    seguePerformed = true
                                }
                            })
                        } else {
                            print("Animal w/ empty image url found; setting default image")
                            searchResults[index].image = UIImage(named: "missingImage")
                        }
                    }
                } else {
                    print("ZERO RESULTS FOUND; please try again")
                }
                })/*
            if(searchResults.count > 0) {
                print("Performing segue...")
                self.performSegue(withIdentifier: "swipeViewSegue", sender: self)
            } else {
                print("ZERO RESULTS FOUND; please try again")
            }*/
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
            if locText.count > 0 {
                self.parameters["location"] = locText
            } else {
                self.parameters.removeValue(forKey: "location")
            }
        } else {
            self.parameters.removeValue(forKey: "location")
        }
        self.parameters["gender"] = genders
        self.parameters["size"] = sizes
        self.parameters["age"] = ages
        print("New parameters:\n\(self.parameters)")
    }
    
    // Function to iterate through search results and remove pets who have already been viewed
    // Note: Core data saving of used IDs was not implemented due to time constraints so this function does not do anything at the moment
    func removeViewedPets() {
        for index in 0...(searchResults.count - 1) {
            if let newID = searchResults[index].petID {
                if usedIDs.contains(newID) {
                    searchResults.remove(at: index)
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
