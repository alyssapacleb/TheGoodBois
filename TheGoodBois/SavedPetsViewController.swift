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
        let pet_name = (pet.value(forKeyPath: "name") as? String)
        let pet_image = UIImage(data: pet.value(forKeyPath: "img") as! Data)!
        let pet_age = (pet.value(forKeyPath: "age") as? String)
        let pet_breed = (pet.value(forKeyPath: "breed") as? String)
        let pet_color = (pet.value(forKeyPath: "color") as? String)
        let pet_sex = (pet.value(forKeyPath: "sex") as? String)
        let pet_coat = (pet.value(forKeyPath: "coat") as? String)
        let pet_bio = (pet.value(forKeyPath: "bio") as? String)
        let pet_size = (pet.value(forKeyPath: "size") as? String)
        let pet_id = (pet.value(forKeyPath: "id") as? Int)
        let pet_url = (pet.value(forKeyPath: "url") as? String)
        let pet_imgURL = (pet.value(forKeyPath: "imgURL") as? String)
        selectedSavedPet = Animal(newID: pet_id, newURL: pet_url, newBreed: pet_breed, newColor: pet_color, newAge: pet_age, newSex: pet_sex, newSize: pet_size, newCoat: pet_coat, newName: pet_name, newBio: pet_bio, newImgURL: pet_imgURL, newImg: pet_image)
        selectedSavedPet?.image = pet_image
        print(selectedSavedPet!)
        self.performSegue(withIdentifier: "BioViewSegue", sender: self)
    }

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
