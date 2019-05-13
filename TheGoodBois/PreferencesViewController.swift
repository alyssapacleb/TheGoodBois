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
    var currentTextField: UITextField?
    var searchResults = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        locationLabel.delegate = self
        
        // PICKERS
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
        
        // PICKER TOOLBAR
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.default
        toolBar.tintColor = UIColor.black
        toolBar.backgroundColor = UIColor.black
        
        //let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.tappedToolBarBtn))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([/*defaultButton,*/flexSpace,flexSpace,flexSpace,flexSpace,doneButton], animated: true)
        breedTextField.inputAccessoryView = toolBar
        ageTextField.inputAccessoryView = toolBar
        sizeTextField.inputAccessoryView = toolBar
        genderTextField.inputAccessoryView = toolBar
        goodWithTextField.inputAccessoryView = toolBar
        
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
        //self.dataSession.getData(searchType: "types")
        //PetfinderAPIManager.sharedInstance.performOAuthLogin()
        
        self.dataSession.getData(searchType: "types")
        // Dummy data
        let animal1 = Animal(petID: "1", orgID: "1", breed: "Cocker Spaniel", color: "Brown", age: "Young", sex: "Male", size: "Small", coat: "Long", petName: "Cary", bio: "Look, I know my pictures make me look like I am a big doofus. Am I big? yes. Am I a doofus? Ok, also yes. But I'm a very very SWEET doofus.\n\nCary (Carrot Top aka Care Bear) is a young guy. He's probably maybe only a year and a half old with the energy and vigor of a much younger pup. He loves to play, he loves to bark, he loves to jump up on your face and smother you with drooly kisses. He is NOT a delicate flower, to put it mildly. He would make an AWFUL apartment dog--his bark can be heard several states over. He has the will to climb up on countertops but all the grace and skill of a drunken walrus. If you're looking for a calm companion, we can direct you to several other wonderful, deserving dogs. But if you're looking for a lotta fun and a lotta love and heart of gold, Cary's your guy. This loveable mug is fostering in the Austin area.", status: "Hi", location: "Austin, Texas", url: "www.google.com")
        animal1.image = UIImage(named: "dog1")
        let animal2 = Animal(petID: "2", orgID: "1", breed: "Cocker Spaniel", color: "Brown", age: "Young", sex: "Male", size: "Small", coat: "Long", petName: "Dog2", bio: "Look, I know my pictures make me look like I am a big doofus. Am I big? yes. Am I a doofus? Ok, also yes. But I'm a very very SWEET doofus.\n\nCary (Carrot Top aka Care Bear) is a young guy. He's probably maybe only a year and a half old with the energy and vigor of a much younger pup. He loves to play, he loves to bark, he loves to jump up on your face and smother you with drooly kisses. He is NOT a delicate flower, to put it mildly. He would make an AWFUL apartment dog--his bark can be heard several states over. He has the will to climb up on countertops but all the grace and skill of a drunken walrus. If you're looking for a calm companion, we can direct you to several other wonderful, deserving dogs. But if you're looking for a lotta fun and a lotta love and heart of gold, Cary's your guy. This loveable mug is fostering in the Austin area.", status: "Hi", location: "Austin, Texas", url: "www.google.com")
        animal2.image = UIImage(named: "dog2")
        let animal3 = Animal(petID: "3", orgID: "1", breed: "Cocker Spaniel", color: "Brown", age: "Young", sex: "Male", size: "Small", coat: "Long", petName: "Dog3", bio: "Look, I know my pictures make me look like I am a big doofus. Am I big? yes. Am I a doofus? Ok, also yes. But I'm a very very SWEET doofus.\n\nCary (Carrot Top aka Care Bear) is a young guy. He's probably maybe only a year and a half old with the energy and vigor of a much younger pup. He loves to play, he loves to bark, he loves to jump up on your face and smother you with drooly kisses. He is NOT a delicate flower, to put it mildly. He would make an AWFUL apartment dog--his bark can be heard several states over. He has the will to climb up on countertops but all the grace and skill of a drunken walrus. If you're looking for a calm companion, we can direct you to several other wonderful, deserving dogs. But if you're looking for a lotta fun and a lotta love and heart of gold, Cary's your guy. This loveable mug is fostering in the Austin area.", status: "Hi", location: "Austin, Texas", url: "www.google.com")
        animal3.image = UIImage(named: "dog3")
        searchResults.append(animal1)
        searchResults.append(animal2)
        searchResults.append(animal3)
        print("Before perform segue")
        performSegue(withIdentifier: "swipeViewSegue", sender: self)
        
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
        
        /*breedTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        sizeTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        goodWithTextField.resignFirstResponder()*/
        
    }
    
    /*func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        pickerTextField.text = "one"
        pickerTextField.resignFirstResponder()
        
    }*/
    
    // PICKER PROTOCOL
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            currentTextField = breedTextField
            return breedOptions.count
        } else if pickerView.tag == 2 {
            currentTextField = ageTextField
            return ageOptions.count
        } else if pickerView.tag == 3 {
            currentTextField = sizeTextField
            return sizeOptions.count
        } else if pickerView.tag == 4 {
            currentTextField = genderTextField
            return genderOptions.count
        } else if pickerView.tag == 5 {
            currentTextField = goodWithTextField
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
