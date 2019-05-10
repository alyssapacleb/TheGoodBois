//
//  PetfinderAPIManager.swift
//  TheGoodBois
//
//  Created by Don Hogan on 5/2/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PetfinderAPIManager {
    
    static let sharedInstance = PetfinderAPIManager()
    
    // API Key + Secret needed for oauth, path for oauth token request & timer to track when token will expire and re-auth is required
    private let apiKey = "DCvN4VnCtzLaCzo9S96TxUIM5gMhzZam24UBFQ4f0SiO3xynSk"
    private let secret = "9CDaGU1PhPvHlFbrOVIbUumd5I9ErKgnyrjHhaLD"
    private let authURLPath = "https://api.petfinder.com/v2/oauth2/token"
    var authToken = ""
    var tokenExpired = false
    
    func hasOAuthToken() -> Bool {
        if self.authToken != "" && !tokenExpired {
            return true
        } else {
            return false
        }
    }
    
    func performOAuthLogin(completion: @escaping () -> ()) {
        print("in performOAuthLogin()")
        var token: String?
        let url = URL(string: self.authURLPath)
        let params : Parameters = ["grant_type":"client_credentials","client_id":self.apiKey,"client_secret":self.secret]
        print("here1")
        Alamofire.request(url!, method: .post, parameters: params).responseJSON {
            response in
            switch(response.result) {
            case .success:
            
                let resultData = JSON(response.result.value!)
                print("here2")
                token = resultData["access_token"].string
                print("\n token in performOAuthLogin():\n \(token!)")
                self.authToken = token!
               
                //self.authToken = token!
                //print(token!)
                
                //print(resultData)
                // this looks like this :
                /*
                 {"token_type": "Bearer",
                 "expires_in": 3600,
                 "access_token": "..."}
                 */
                completion()
            case .failure:
                print("JSON Encoding Failed")
        }
        
        
        if token != nil {
            print("Auth token successfully retrieved")
            self.authToken = token!
            self.tokenExpired = false
        }
        
        }
        
    }
    func getToken() -> String {
        return(self.authToken)
    }
    
}
