//
//  PreferencesViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreLocation

class PreferencesViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var goodWithTextField: UITextField!
    
    // Picker Options (have to be strings!!!)
    var breedOptions = ["Chihuahua","German Shepherd"]
    var ageOptions = ["Puppy", "Young","Adult","Senior"]
    var sizeOptions = ["Small", "Medium","Large","XL"]
    var genderOptions = ["Male","Female"]
    var goodWithOptions = ["Kids","Other dogs","Cats"]
    
    // MARK: - Properties
    private var dataSession = SearchDataSession()
    let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        locationLabel.delegate = self
        
        //PICKERS
        let breedPickerView = UIPickerView()
        breedPickerView.delegate = self
        breedPickerView.tag = 1
        breedTextField.inputView = breedPickerView
        
        let agePickerView = UIPickerView()
        agePickerView.delegate = self
        agePickerView.tag = 2
        ageTextField.inputView = agePickerView
        
        let sizePickerView = UIPickerView()
        sizePickerView.delegate = self
        sizePickerView.tag = 3
        sizeTextField.inputView = sizePickerView
        
        let genderPickerView = UIPickerView()
        genderPickerView.delegate = self
        genderPickerView.tag = 4
        genderTextField.inputView = genderPickerView
        
        let goodWithPickerView = UIPickerView()
        goodWithPickerView.delegate = self
        goodWithPickerView.tag = 5
        goodWithTextField.inputView = goodWithPickerView
        
        // LOCATION
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }

    }
    
    // MARK: - Actions
    @IBAction func performSearch(_ sender: Any) {
        print("Performing Search")
        self.dataSession.getData(searchType: "types")
        PetfinderAPIManager.sharedInstance.performOAuthLogin()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationLabel.resignFirstResponder()
        return true
    }
    
    // PICKER PROTOCOL
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return breedOptions.count
        } else if pickerView.tag == 2 {
            return ageOptions.count
        } else if pickerView.tag == 3 {
            return sizeOptions.count
        } else if pickerView.tag == 4 {
            return genderOptions.count
        } else if pickerView.tag == 5 {
            return goodWithOptions.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return breedOptions[row]
        } else if pickerView.tag == 2 {
            return ageOptions[row]
        } else if pickerView.tag == 3 {
            return sizeOptions[row]
        } else if pickerView.tag == 4 {
            return genderOptions[row]
        } else if pickerView.tag == 5 {
            return goodWithOptions[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            breedTextField.text = breedOptions[row]
        } else if pickerView.tag == 2 {
            ageTextField.text = ageOptions[row]
        } else if pickerView.tag == 3 {
            sizeTextField.text = sizeOptions[row]
        } else if pickerView.tag == 4 {
            genderTextField.text = genderOptions[row]
        } else if pickerView.tag == 5 {
            goodWithTextField.text = goodWithOptions[row]
        }
    }
    
    // LOCATION MANAGING
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
