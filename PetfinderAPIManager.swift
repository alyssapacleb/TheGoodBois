//
//  PetfinderAPIManager.swift
//  TheGoodBois
//
//  Created by Garertt Willis on 5/2/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PetfinderAPIManager {

    static let sharedInstance = PetfinderAPIManager()
    
    // API Key + Secret needed for oauth, path for oauth token request, and boolean to track whether token is invalid/expired
    private let apiKey = "DCvN4VnCtzLaCzo9S96TxUIM5gMhzZam24UBFQ4f0SiO3xynSk"
    private let secret = "9CDaGU1PhPvHlFbrOVIbUumd5I9ErKgnyrjHhaLD"
    private let authURLPath = "https://api.petfinder.com/v2/oauth2/token"
    var authToken: String?
    var tokenValid = false
    
    // Function to determine if authentication token has previously been retrieved and is currently valid for use
    func hasOAuthToken() -> Bool {
        if self.authToken != nil && tokenValid {
            return true
        } else {
            return false
        }
    }
    
    // Function to perform authentication login before proceeding onto desired .GET requet
    func performOAuthLogin(completion: @escaping () -> ()) {
        
        // Use completion handler to perform .GET request once authentication is finished
        if !self.hasOAuthToken() {
            
            let url = URL(string: self.authURLPath)!
            let params : Parameters = ["grant_type":"client_credentials",
                                       "client_id":self.apiKey,
                                       "client_secret":self.secret]
            
            self.postOAuthRequest(url: url, params: params, completion: {
                
                if self.authToken != nil {
                    print("Auth token successfully retrieved")
                    self.tokenValid = true
                    completion()
                } else {
                    print("---ERROR: Retrieved authentication token is nil")
                    self.tokenValid = false
                }
            })
        } else {
            print("Valid authentication token present; no re-authorization needed")
            completion()
        }
    }
    
    // Function for posting authentication request to server
    func postOAuthRequest(url: URL, params: Parameters, completion: @escaping () -> ()) {
        var token:String?
        Alamofire.request(url, method: .post, parameters: params)
            .validate()
            .responseJSON { response in
                switch(response.result) {
                case(.success):
                    let resultData = JSON(response.result.value!)
                    token = resultData["access_token"].string
                    self.authToken = token
                    completion()
                case(.failure):
                    print("---ERROR: Unable to retrieve authentication token")
                }
        }
    }
    
    func getToken() -> String {
        return self.authToken!
    }
    
}
