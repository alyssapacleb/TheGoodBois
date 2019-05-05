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
    
    func performOAuthLogin() {
        var token: String?
        let url = URL(string: self.authURLPath)
        let params : Parameters = ["grant_type":"client_credentials","client_id":self.apiKey,"client_secret":self.secret]
        
        Alamofire.request(url!, method: .post, parameters: params).responseJSON { response in
            let resultData = JSON(response.result.value!)
            token = resultData["access_token"].string
        }
        if token != nil {
            print("Auth token successfully retrieved")
            self.authToken = token!
            self.tokenExpired = false
        }
    }
    
}
