//
//  prefTableViewController.swift
//  TheGoodBois
//
//  Created by Alyssa June Pacleb on 5/13/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

//1
var gender_male = ""
//2
var gender_female = ""
//3
var age_Baby = ""
//4
var age_Young = ""
//5
var age_Adult = ""
//6
var age_Senior = ""
//7
var size_Small = ""
//8
var size_Medium = ""
//9
var size_Large = ""
//10
var size_Xlarge = ""


class prefTableViewController: UITableViewController {
    var num_rows = [2,4,4]
    
    @IBAction func toggle_1(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_2(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_3(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_4(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_5(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_6(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_7(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_8(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_9(_ sender: UISwitch) {
        changeText()
    }
    @IBAction func toggle_10(_ sender: UISwitch) {
        changeText()
    }
    
    
    @IBOutlet weak var gen_male: UISwitch!
    @IBOutlet weak var gen_female: UISwitch!
    @IBOutlet weak var age_baby: UISwitch!
    @IBOutlet weak var age_young: UISwitch!
    @IBOutlet weak var age_adult: UISwitch!
    @IBOutlet weak var age_senior: UISwitch!
    @IBOutlet weak var size_small: UISwitch!
    @IBOutlet weak var size_medium: UISwitch!
    @IBOutlet weak var size_large: UISwitch!
    @IBOutlet weak var size_xlarge: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeText()
        gen_male.addTarget(self, action: #selector(toggle_1(_:)), for: UIControlEvents.valueChanged)
        gen_female.addTarget(self, action: #selector(toggle_2(_:)), for: UIControlEvents.valueChanged)
        age_baby.addTarget(self, action: #selector(toggle_3(_:)), for: UIControlEvents.valueChanged)
        age_young.addTarget(self, action: #selector(toggle_4(_:)), for: UIControlEvents.valueChanged)
        age_adult.addTarget(self, action: #selector(toggle_5(_:)), for: UIControlEvents.valueChanged)
        age_senior.addTarget(self, action: #selector(toggle_6(_:)), for: UIControlEvents.valueChanged)
        size_small.addTarget(self, action: #selector(toggle_7(_:)), for: UIControlEvents.valueChanged)
        size_medium.addTarget(self, action: #selector(toggle_8(_:)), for: UIControlEvents.valueChanged)
        size_large.addTarget(self, action: #selector(toggle_9(_:)), for: UIControlEvents.valueChanged)
        size_xlarge.addTarget(self, action: #selector(toggle_10(_:)), for: UIControlEvents.valueChanged)
    }
    
    func changeText() {
        print("========================")
        if gen_male.isOn {
            gender_male = "male"
        } else {
            gender_male = ""
        }
        print("1")
        print(gender_male)
        
        if gen_female.isOn {
            gender_female = "female"
        } else {
            gender_female = ""
        }
        print("2")
        print(gender_female)
        
        if age_baby.isOn {
            age_Baby = "baby"
        } else {
            age_Baby = ""
        }
        print("3")
        print(age_Baby)
        
        if age_young.isOn {
            age_Young = "young"
        } else {
            age_Young = ""
        }
        print("4")
        print(age_Young)
        
        if age_adult.isOn {
            age_Adult = "Adult"
        } else {
            age_Adult = ""
        }
        print("5")
        print(age_Adult)
        
        if age_senior.isOn {
            age_Senior = "senior"
        } else {
            age_Senior = ""
        }
        print("6")
        print(age_Senior)
        
        if size_small.isOn {
            size_Small = "small"
        } else {
            size_Small = ""
        }
        print("7")
        print(size_Small)
        
        if size_medium.isOn {
            size_Medium = "medium"
        } else {
            size_Medium = ""
        }
        print("8")
        print(size_Medium)
        
        if size_large.isOn {
            size_Large = "large"
        } else {
            size_Large = ""
        }
        print("9")
        print(size_Large)
        
        if size_xlarge.isOn {
            size_Xlarge = "xlarge"
        } else {
            size_Xlarge = ""
        }
        print("10")
        print(size_Xlarge)
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return num_rows[section]
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
