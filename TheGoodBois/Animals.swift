//
//  Animals.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 5/3/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import Foundation
import UIKit

class Animal{
    
    var pet_name: String
    var pet_image_url: String
    var pet_image: UIImage?
    var pet_age: String
    var pet_breed: String
    var pet_location: String
    var pet_sex: String
    var pet_coat: String
    var pet_bio: String
    
    init (pet_name: String, pet_image_url: String, pet_age: String, pet_breed: String, pet_location: String, pet_sex: String, pet_coat: String, pet_bio: String){
        self.pet_name = pet_name
        self.pet_image_url = pet_image_url
        self.pet_image = nil
        self.pet_age = pet_age
        self.pet_breed = pet_breed
        self.pet_location = pet_location
        self.pet_sex = pet_sex
        self.pet_coat = pet_coat
        self.pet_bio = pet_bio
    }
    
    func prepareForDisplay(){
        
        let urlSession = URLSession.shared
        guard let url = URL(string: self.pet_image_url) else { return }
        
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
