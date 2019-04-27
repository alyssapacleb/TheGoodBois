//
//  SearchDataSession.swift
//  TheGoodBois
//
//  Created by Don Hogan on 4/26/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//
/*
import UIKit

protocol SearchDataProtocol {
    func animalsResponseDataHandler(currentData:NSDictionary)
    func typesResponseDataHandler(currentdata:NSDictionary)
    func responseError(message:String)
}

class SearchDataSession {
    
    //private let apiKey =
    private let urlSession = URLSession.shared
    //private let urlPathBase = "https://www.petfinder.com"
    
    private var dataTask:URLSessionDataTask? = nil
    
    var delegate:SearchDataProtocol? = nil
    
    init() {}
    
    func getData(searchDataLoc:String, searchType:String) {
        
        // searchDataLoc = url to be used in query
        // searchType = "animals" or "types"; used to determine query response format
        //let urlPath = "\(self.urlPathBase)?key=\(self.apiKey)&format=json&q=\(searchDataLoc)"
        //print(urlPath)
        
        let url = URL(string: urlPath)
        
        let dataTask = self.urlSession.dataTask(with: url!) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if response != nil {
                        print("Received response: \(response!)")
                    }
                    let jsonResult = try JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if jsonResult != nil {
                        let resultData = jsonResult![searchType] as? NSDictionary
                        if resultData != nil {
                            //print("Request received\nRequest type: \(requestData!["type"]!)\nQuery: \(requestData!["query"]!)")
                            // Choose responseDataHandler function to use based on searchType
                            if searchType == "animals" {
                                self.delegate?.animalsResponseDataHandler(currentData: resultData!)
                            }
                            if searchType == "types" {
                                self.delegate?.typesResponseDataHandler(currentdata: resultData!)
                            }
                            
                        } else {
                            self.delegate?.responseError(message: "ERROR: No search results")
                        }
                    }
                } catch {
                    
                }
            }
        }
        dataTask.resume()
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
*/
