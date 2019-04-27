//
//  PreferencesViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreLocation

class PreferencesViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var drawView: drawView!
    @IBOutlet weak var locationLabel: UITextField!
    let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        drawView.drawShape(selectedShape: .circle)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UseUserLocation(_ sender: UIButton) {
        
        print("Inside function")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            print("services enabled")
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        print("updating")
        locationLabel.text = (NSNumber(value: (userLocation?.coordinate.latitude)! as Double)).stringValue+", "+(NSNumber(value: (userLocation?.coordinate.longitude)! as Double)).stringValue
        locationManager.stopUpdatingLocation()
        //store the user location here to firebase or somewhere
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
