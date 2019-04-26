//
//  SearchFieldsViewController.swift
//  TheGoodBois
//
//  Created by Don Hogan on 4/26/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

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
