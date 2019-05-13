//
//  SavedPetsViewController.swift
//  TheGoodBois
//
//  Created by Don Hogan on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit
import CoreData

var selectedSavedPet: Animal?

class SavedPetsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pet")
        
        do {
            savedPets = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedPets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pet = savedPets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPetsCell", for: indexPath) as! SavedPetsTableViewCell
        let cellImage = UIImage(data: pet.value(forKeyPath: "img") as! Data)!
        let label1 = pet.value(forKeyPath: "name") as! String

        // Configure the cell...
        cell.displayContent(image: cellImage, label1: label1)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pet = savedPets[indexPath.row]
        let pet_name = (pet.value(forKeyPath: "name") as! String)
        let pet_image = UIImage(data: pet.value(forKeyPath: "img") as! Data)!
        let pet_age = (pet.value(forKeyPath: "age") as! String)
        let pet_breed = (pet.value(forKeyPath: "breed") as! String)
        let pet_location = (pet.value(forKeyPath: "loc") as! String)
        let pet_sex = (pet.value(forKeyPath: "sex") as! String)
        let pet_coat = (pet.value(forKeyPath: "coat") as! String)
        let pet_bio = (pet.value(forKeyPath: "bio") as! String)
        selectedSavedPet = Animal(petID: "", orgID: "", breed: pet_breed, color: "", age: pet_age, sex: pet_sex, size: "", coat: pet_coat, petName: pet_name, bio: pet_bio, status: "", location: pet_location, url: "")
        selectedSavedPet?.image = pet_image
        print(selectedSavedPet!)
        self.performSegue(withIdentifier: "BioViewSegue", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(savedPets[indexPath.row])
            do {
                try managedContext.save()
            } catch {
                return
            }
            savedPets.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "BioViewSegue" {
            let ExchangeViewData = segue.destination as! BioViewController
            ExchangeViewData.currentPet = selectedSavedPet!
        }
    }

}
