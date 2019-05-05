//
//  SearchDataSession.swift
//  TheGoodBois
//
//  Created by Don Hogan on 4/26/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchDataProtocol {
    func animalsResponseDataHandler(currentData:NSDictionary) -> [Animal]
    func typesResponseDataHandler(currentData:NSArray) -> Fields
    func responseError(message:String)
}

class SearchDataSession {

    // Base path shared by all .GET requests we will need
    private let urlPathBase = "https://www.petfinder.com/v2/"
 
    private var dataTask:URLSessionDataTask? = nil
    var delegate:SearchDataProtocol? = nil
    
    init() {}
    
    func getData(searchType:String) {
        // searchType = "animals" || "types"; used to determine query response format
        let urlPath = self.urlPathBase + searchType
        
        // Get OAuth token for header from API Manager if available; else, perform (re-)authorization
        if(!PetfinderAPIManager.sharedInstance.hasOAuthToken()){
            PetfinderAPIManager.sharedInstance.performOAuthLogin()
        }
        let token = PetfinderAPIManager.sharedInstance.authToken
        
        // Perform GET request using Alamofire and check response data integrity before passing to data handler
        
        /*
        var request = URLRequest(url: URL(string: urlPath)!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if response != nil {
                        print("Received response: \(response!)")
                    }
                    
                    // TODO: Implement data processing
                }
            }
        }
        dataTask.resume()*/
        
        
    }

}

/*
// MARK - Example JSON responses from
// Example get_animal_types query response used to populate search fields
 {
 "types": [
 {
 "name": "Rabbit",
 "coats": [
 "Short",
 "Long"
 ],
 "colors": [
 "Agouti",
 "Black",
 "Blue / Gray",
 "Brown / Chocolate",
 "Cream",
 "Lilac",
 "Orange / Red",
 "Sable",
 "Silver Marten",
 "Tan",
 "Tortoiseshell",
 "White"
 ],
 "genders": [
 "Male",
 "Female"
 ],
 "_links": {
 "self": {
 "href": "/v2/types/rabbit"
 },
 "breeds": {
 "href": "/v2/types/rabbit/breeds"
 }
 }
 },
 {
 "name": "Bird",
 "coats": [],
 "colors": [
 "Black",
 "Blue",
 "Brown",
 "Buff",
 "Gray",
 "Green",
 "Olive",
 "Orange",
 "Pink",
 "Purple / Violet",
 "Red",
 "Rust / Rufous",
 "Tan",
 "White",
 "Yellow"
 ],
 "genders": [
 "Male",
 "Female",
 "Unknown"
 ],
 "_links": {
 "self": {
 "href": "/v2/types/bird"
 },
 "breeds": {
 "href": "/v2/types/bird/breeds"
 }
 }
 }
 ]
 }

 // Example get_animals search query response, used for main search functionality
 {
 "animals": [
 {
 "id": 124,
 "organization_id": "NJ333",
 "url": "https://www.petfinder.com/cat/nebula-124/nj/jersey-city/nj333-petfinder-test-account/?referrer_id=d7e3700b-2e07-11e9-b3f3-0800275f82b1",
 "type": "Cat",
 "species": "Cat",
 "breeds": {
 "primary": "American Shorthair",
 "secondary": null,
 "mixed": false,
 "unknown": false
 },
 "colors": {
 "primary": "Tortoiseshell",
 "secondary": null,
 "tertiary": null
 },
 "age": "Young",
 "gender": "Female",
 "size": "Medium",
 "coat": "Short",
 "name": "Nebula",
 "description": "Nebula is a shorthaired, shy cat. She is very affectionate once she warms up to you.",
 "photos": [
 {
 "small": "http://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=100",
 "medium": "http://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=300",
 "large": "http://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=600",
 "full": "http://photos.petfinder.com/photos/pets/124/1/?bust=1546042081"
 }
 ],
 "status": "adoptable",
 "attributes": {
 "spayed_neutered": true,
 "house_trained": true,
 "declawed": false,
 "special_needs": false,
 "shots_current": true
 },
 "environment": {
 "children": false,
 "dogs": true,
 "cats": true
 },
 "tags": [
 "Cute",
 "Intelligent",
 "Playful",
 "Happy",
 "Affectionate"
 ],
 "contact": {
 "email": "petfindertechsupport@gmail.com",
 "phone": "555-555-5555",
 "address": {
 "address1": null,
 "address2": null,
 "city": "Jersey City",
 "state": "NJ",
 "postcode": "07097",
 "country": "US"
 }
 },
 "published_at": "2018-09-04T14:49:09+0000",
 "_links": {
 "self": {
 "href": "/v2/animals/124"
 },
 "type": {
 "href": "/v2/types/cat"
 },
 "organization": {
 "href": "/v2/organizations/nj333"
 }
 }
 }
 ],
 "pagination": {
 "count_per_page": 20,
 "total_count": 320,
 "current_page": 1,
 "total_pages": 16,
 "_links": {}
 }
 }
*/
