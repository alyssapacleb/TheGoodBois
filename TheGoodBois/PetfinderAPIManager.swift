//
//  PetfinderAPIManager.swift
//  TheGoodBois
//
//  Created by Garrett Willis on 5/2/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

//---------------------------------------------------------------------------------------------------------------------------------------------
// TODO:
// 1. Fix BioViewController
// 3. First swipeviewcontroller image is empty
// 5. IF TIME: Add status code switch to error handling
//---------------------------------------------------------------------------------------------------------------------------------------------

import Foundation
import Alamofire
import SwiftyJSON

protocol PetfinderAPIProtocol {
    func requestError(errType: String)
    //func setFields(fields: Fields)
}

class PetfinderAPIManager {

    // MARK: - Properties
    // Shared instance is used as singular instance of object to perform all requests
    static let sharedInstance = PetfinderAPIManager()
    
    // API Key + Secret needed for oauth, path for oauth token request, and boolean to track whether token is invalid/expired
    private let apiKey = "DCvN4VnCtzLaCzo9S96TxUIM5gMhzZam24UBFQ4f0SiO3xynSk"
    private let secret = "9CDaGU1PhPvHlFbrOVIbUumd5I9ErKgnyrjHhaLD"
    private let basePath = "https://api.petfinder.com/v2/"
    private let authPath = "oauth2/token"
    private let nextPath = "https://api.petfinder.com"
    var authToken: String?
    var tokenValid = false
    var nextPageURL: String?
    var delegate: PreferencesViewController?
    
    // MARK: - Functions
    // Function to determine if authentication token has previously been retrieved and is currently valid for use
    func hasOAuthToken() -> Bool {
        if self.authToken != nil && tokenValid {
            return true
        } else {
            return false
        }
    }
    
    // Main function used to perform desired search and return data through completion handler
    func getData(searchType: String, searchStr: String?, params: Parameters?, completion: @escaping ([Any]) -> ()) {
        self.performOAuthLogin {
            switch(searchType){
            // NOTE: Due to time constraints, we retroactively restricted our apps to dogs only, so the types requests are no longer necessary; instead, the allowed values of breeds, coats & colors are hardcoded
            case("types"):
                if searchStr != nil {
                    self.getTypesRequest(type: searchStr!, completion: { coatsData, colorsData in
                        self.getBreedsRequest(type: searchStr!, completion: { breedsData in
                            let newFields = Fields(breeds: breedsData, colors: colorsData, coats: coatsData)
                            completion([newFields])
                        })
                    })
                } else {
                    self.responseError(type: "Search Str", block: "getData", message: "Search string is required for types request")
                }
            case("animals"):
                if params != nil {
                    self.getAnimalsRequest(params: params!, completion: { animalsList in
                        completion(animalsList)
                        })
                } else {
                    self.responseError(type: "Parameters", block: "getData", message: "Animals search parameters must not be nil")
                }
            case("next"):
                if params != nil {
                    self.getNextPageRequest(params: params!, completion: { animalsList in
                        completion(animalsList)
                        })
                } else {
                    self.responseError(type: "Parameters", block: "getdata", message: "Next page search parameters must not be nil")
                }
            default:
                self.responseError(type: "Search Type", block: "getData", message: "Invalid search type given")
            }
        }
    }
    
    // Function to perform authentication login before proceeding onto desired .GET requet
    func performOAuthLogin(completion: @escaping () -> ()) {
        // Use completion handler to perform .GET request once authentication is finished
        if !self.hasOAuthToken() {
            self.postOAuthRequest(completion: {
                if self.authToken != nil {
                    print("Auth token successfully retrieved")
                    self.tokenValid = true
                    completion()
                } else {
                    self.responseError(type: "authToken", block: "OAuth Login", message: "Retrieved authentication token is nil")
                    self.tokenValid = false
                }
            })
        } else {
            print("Valid authentication token present; no re-authorization needed")
            completion()
        }
    }
    
    // MARK: - HTTP Request functions
    // Function for posting authentication request to server
    func postOAuthRequest(completion: @escaping () -> ()) {
        let url = URL(string: (self.basePath + self.authPath))!
        let params : Parameters = ["grant_type":"client_credentials",
                                   "client_id":self.apiKey,
                                   "client_secret":self.secret]
        var token:String?
        Alamofire.request(url, method: .post, parameters: params)
            .validate()
            .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode {
                    switch(status) {
                    case 200:
                        print("Search query processed successfully")
                        switch(response.result) {
                        case(.success):
                            let resultData = JSON(response.result.value!)
                            token = resultData["access_token"].string
                            self.authToken = token
                            completion()
                        case(.failure):
                            self.responseError(type: "Serial", block: "OAuth Request", message: "Response JSON serialization failed")
                        }
                    case 500:
                        self.responseError(type: "Unknown", block: "OAuth Request", message: "Server responded with 500 code; please try again")
                    default:
                        self.responseError(type: "Status", block: "OAuth Request", message: "Server response status code: \(status)")
                    }
                }
            })
    }
    
    // getTypes & getBreeds are simple .GET requests w/ no data included which return allowed (coats + colors) and breeds, respectively
    func getTypesRequest(type: String, completion: @escaping ([String], [String]) -> ()) {
        let url = URL(string: (self.basePath + "types/" + type))!
        Alamofire.request(url, method:.get, headers: ["Authorization": "Bearer \(self.authToken!)"])
            .validate()
            .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode {
                    switch(status) {
                    case 200:
                        print("Search query processed successfully")
                        switch(response.result) {
                        case(.success):
                            let resultData = JSON(response.result.value!)
                            let typeData = resultData["type"].dictionaryValue
                            let coatsData = typeData["coats"]!.arrayValue.map { $0.stringValue}
                            let colorsData = typeData["colors"]!.arrayValue.map { $0.stringValue}
                            completion(coatsData, colorsData)
                        case(.failure):
                            self.responseError(type: "Serial", block: "Types", message: "Response JSON serialization failed")
                        }
                    case 500:
                        self.responseError(type: "Unknown", block: "Types", message: "Server responded with 500 code; please try again")
                    default:
                        self.responseError(type: "Status", block: "Types", message: "Server response status code: \(status)")
                    }
                }
            })
    }
    
    func getBreedsRequest(type: String, completion: @escaping ([String]) -> ()) {
        let url = URL(string: (self.basePath + "types/" + type + "/breeds"))!
        Alamofire.request(url, method: .get, headers: ["Authorization": "Bearer \(self.authToken!)"])
            .validate()
            .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode {
                    switch(status) {
                    case 200:
                        print("Search query processed successfully")
                        switch(response.result) {
                        case(.success):
                            var breeds = [String]()
                            let resultData = JSON(response.result.value!)
                            let breedsData = resultData["breeds"]
                            for (_, subJSON) in breedsData {
                                let breedName = subJSON["name"].string!
                                breeds.append(breedName)
                            }
                            completion(breeds)
                        case(.failure):
                            self.responseError(type: "Serial", block: "Breeds", message: "Response JSON serialization failed")
                        }
                    case 500:
                        self.responseError(type: "Unknown", block: "Breeds", message: "Server responded with 500 code; please try again")
                    default:
                        self.responseError(type: "Status", block: "Breeds", message: "Server response status code: \(status)")
                    }
                }
            })
    }
    
    func getAnimalsRequest(params: Parameters, completion: @escaping ([Animal]) -> ()) {
        let url = URL(string: (self.basePath + "animals"))!
        Alamofire.request(url, method: .get, parameters: params, headers: ["Authorization": "Bearer \(self.authToken!)"])
            .validate()
            .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode {
                    switch(status) {
                    case 200:
                        print("Search query processed successfully")
                        switch(response.result) {
                        case(.success):
                            var animals = [Animal]()
                            let resultData = JSON(response.result.value!)
                            let animalsData = resultData["animals"]
                            for (_, subJSON) in animalsData {
                                let newID = subJSON["id"].int
                                let newURL = subJSON["url"].string
                                let breeds = subJSON["breeds"].dictionary
                                let newBreed = breeds!["primary"]!.string
                                let colors = subJSON["colors"].dictionary
                                let newColor = colors!["primary"]!.string
                                let newAge = subJSON["age"].string
                                let newSex = subJSON["gender"].string
                                let newSize = subJSON["size"].string
                                let newCoat = subJSON["coat"].string
                                let newName = subJSON["name"].string
                                let newBio = subJSON["description"].string
                                let photos = subJSON["photos"].array
                                var photoOne:[String : JSON]?
                                if photos!.count > 0 {
                                    photoOne = photos![0].dictionary
                                } else {
                                    photoOne = ["full" : JSON()]
                                }
                                let newImgURL = photoOne!["full"]!.string
                                let newAnimal = Animal(newID: newID, newURL: newURL, newBreed: newBreed, newColor: newColor, newAge: newAge, newSex: newSex, newSize: newSize, newCoat: newCoat, newName: newName, newBio: newBio, newImgURL: newImgURL, newImg: nil)
                                animals.append(newAnimal)
                            }
                            
                            let pageData = resultData["pagination"]
                            let linkData = pageData["_links"]
                            if let nextData = linkData["next"].dictionary {
                                self.nextPageURL = nextData["href"]!.string
                            } else {
                                self.nextPageURL = nil
                                self.responseError(type: "Next Page", block: "Animals", message: "No next page href available")
                            }
                            completion(animals)
                            
                        case(.failure):
                            self.responseError(type: "Serial", block: "Animals", message: "Response JSON serialization failed")
                        }
                    case 400:
                        switch(response.result) {
                        case(.success):
                            let resultData = JSON(response.result.value!)
                            let type = resultData["type"].string
                            if type == "https://www.petfinder.com/developers/v2/docs/errors/ERR-00002/" {
                                var invalidParams = [String: String]()
                                let paramsData = resultData["invalid-params"]
                                for(_, subJSON) in paramsData {
                                    let param = subJSON["path"].string!
                                    let msg = subJSON["message"].string!
                                    invalidParams[param] = msg
                                }
                            } else {
                                self.responseError(type: "400 Error", block: "Next page", message: "Server responded with unknown 400 error")
                            }
                        case(.failure):
                            self.responseError(type: "Serial", block: "Next page", message: "Server responded with 400 error & JSON serialization failed")
                        }
                    case 500:
                        self.responseError(type: "Unknown", block: "Animals", message: "Server responded with 500 code; please try again")
                    default:
                        self.responseError(type: "Status", block: "Animals", message: "Server response status code: \(status)")
                    }
                }
            })
    }
    
    func getNextPageRequest(params: Parameters, completion: @escaping ([Animal]) -> ()) {
        if self.nextPageURL != nil {
            let url = URL(string: (self.nextPath + self.nextPageURL!))!
            Alamofire.request(url, method: .get, headers: ["Authorization": "Bearer \(self.authToken!)"])
                .validate()
                .responseJSON(completionHandler: { response in
                    if let status = response.response?.statusCode {
                        switch(status) {
                        case 200:
                            switch(response.result) {
                            case(.success):
                                var animals = [Animal]()
                                let resultData = JSON(response.result.value!)
                                let animalsData = resultData["animals"]
                                for (_, subJSON) in animalsData {
                                    let newID = subJSON["id"].int
                                    let newURL = subJSON["url"].string
                                    let breeds = subJSON["breeds"].dictionary
                                    let newBreed = breeds!["primary"]!.string
                                    let colors = subJSON["colors"].dictionary
                                    let newColor = colors!["primary"]!.string
                                    let newAge = subJSON["age"].string
                                    let newSex = subJSON["gender"].string
                                    let newSize = subJSON["size"].string
                                    let newCoat = subJSON["coat"].string
                                    let newName = subJSON["name"].string
                                    let newBio = subJSON["description"].string
                                    let photos = subJSON["photos"].array
                                    var photoOne:[String : JSON]?
                                    if photos!.count > 0 {
                                        photoOne = photos![0].dictionary
                                    } else {
                                        photoOne = ["full" : JSON()]
                                    }
                                    let newImgURL = photoOne!["full"]!.string
                                    
                                    let newAnimal = Animal(newID: newID, newURL: newURL, newBreed: newBreed, newColor: newColor, newAge: newAge, newSex: newSex, newSize: newSize, newCoat: newCoat, newName: newName, newBio: newBio, newImgURL: newImgURL, newImg: nil)
                                    animals.append(newAnimal)
                                }
                                let pageData = resultData["pagination"]
                                let linkData = pageData["_links"]
                                if let nextData = linkData["next"].dictionary {
                                    let nextPageHref = nextData["href"]!.string
                                    self.nextPageURL = nextPageHref
                                } else {
                                    self.nextPageURL = nil
                                    self.responseError(type: "Next Page", block: "Next page", message: "No next page href available")
                                }
                                completion(animals)
                            case(.failure):
                                self.responseError(type: "Serial", block: "Next page", message: "Response JSON serialization failed")
                            }
                        case 400:
                            switch(response.result) {
                            case(.success):
                                let resultData = JSON(response.result.value!)
                                let type = resultData["type"].string
                                if type == "https://www.petfinder.com/developers/v2/docs/errors/ERR-00002/" {
                                    var invalidParams = [String: String]()
                                    let paramsData = resultData["invalid-params"]
                                    for(_, subJSON) in paramsData {
                                        let param = subJSON["path"].string!
                                        let msg = subJSON["message"].string!
                                        invalidParams[param] = msg
                                    }
                                } else {
                                    self.responseError(type: "400 Error", block: "Next page", message: "Server responded with unknown 400 error")
                                }
                            case(.failure):
                                self.responseError(type: "Serial", block: "Next page", message: "Server responded with 400 error & JSON serialization failed")
                            }
                        case 500:
                            self.responseError(type: "Unknown", block: "Next page", message: "Server responded with 500 code; please try again")
                        default:
                            self.responseError(type: "Status", block: "Next page", message: "Server response status code: \(status)")
                        }
                    }
                })
        } else {
            self.responseError(type: "Next page", block: "Next page", message: "Request called with empty next URL")
        }
    }
    
    // MARK: - Error handling
    func responseError(type: String, block: String, message: String) {
        // If time allows, implement more advanced error handling
        print("-----ERROR: {\(type)}-----\nIn block: \(block)\nMessage: \(message)\n")
        self.delegate!.requestError(errType: type)
    }
    
    // MARK: - Get/Set methods
    func getToken() -> String {
        return self.authToken!
    }
    
    func setToken(newToken:String) {
        self.authToken = newToken
    }
    
}
