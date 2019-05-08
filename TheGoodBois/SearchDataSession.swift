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
    private let urlPathBase = "https://api.petfinder.com/v2/animals?type=dog&page=2"
    //type=dog&page=2
    private var dataTask:URLSessionDataTask? = nil
    var delegate:SearchDataProtocol? = nil
    
    init() {}
    
    func getData(searchType:String) {
        print("getData")
        // searchType = "animals" || "types"; used to determine query response format
        
        //PetfinderAPIManager.sharedInstance.performOAuthLogin()
        let urlPath = self.urlPathBase //+ searchType
        
        // Get OAuth token for header from API Manager if available; else, perform (re-)authorization
        
        /*if(!PetfinderAPIManager.sharedInstance.hasOAuthToken()){
         PetfinderAPIManager.sharedInstance.performOAuthLogin()
         print("in if loop in getData")
         print(PetfinderAPIManager.sharedInstance.authToken)
         }*/
        
        //let fullNameArr = fullName.components(separatedBy: " ")
        //let token = PetfinderAPIManager.sharedInstance.authToken
        
        print("The token being fed into the request is: ")
        let token = PetfinderAPIManager.sharedInstance.authToken
        print(token)
        
        //print("reached")
        
        // Perform GET request using Alamofire and check response data integrity before passing to data handler
        
        
        var request = URLRequest(url: URL(string: urlPath)!)
        var token_test = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjBlNmMwNTExYmM5ZGQ4ZDFiZDJhMjAxNmQwNjZkMzJlZWI2OTRlNWY4OGM4ZGNjYTJhZTcwM2E2N2NlZjFjYjdiZGYxMDdiNDQyNzQ3NDg0In0.eyJhdWQiOiJEQ3ZONFZuQ3R6TGFDem85Uzk2VHhVSU01Z01oelphbTI0VUJGUTRmMFNpTzN4eW5TayIsImp0aSI6IjBlNmMwNTExYmM5ZGQ4ZDFiZDJhMjAxNmQwNjZkMzJlZWI2OTRlNWY4OGM4ZGNjYTJhZTcwM2E2N2NlZjFjYjdiZGYxMDdiNDQyNzQ3NDg0IiwiaWF0IjoxNTU3Mjk1OTI2LCJuYmYiOjE1NTcyOTU5MjYsImV4cCI6MTU1NzI5OTUyNiwic3ViIjoiIiwic2NvcGVzIjpbXX0.Pc6i74ENcrg1fnREMAP0NQVoFk8c9ebhV_lMRMDLrbHJCJi6cpWjSgn12cAD5Fjr_EfG2mG6P4-nmgzRfVQ74pqmf-XcJaWevFN1mQqUERkSEYq9CUZfQCEoWmjatxtzf3WN07-W4s4iZ3rBk-ChVlH2WytlsKtdgrbY_27tJ9MxSsCbKfb3ObC9M_g-_p_h0fiQM8YyT_Ont3MnmWxDIsHk9DZwdAW0kRBb10aD46stC0zlK5G3-mijpIIwslayZdZ5waNn0GLrH4NyYnV1tSYt-3da8wA61OWTrLCZlIh5GKcLXmSJTmY8_34J3rLcyW4pBlQv8vbhEh8JuWYVcg"
        
        request.addValue("Bearer \(token_test)", forHTTPHeaderField: "Authorization")
        
        //print("\nRequested URL in getData:\n \(request)\n")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if response != nil {
                        //print("\nReceived response: \(response!)")
                        print("========================================================================================================================")
                        
                        
                        //name
                        
                        /*
                         func convertToDictionary(text: String) -> [String: Any]? {
                         if let data = text.data(using: .utf8) {
                         do {
                         return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                         } catch {
                         print(error.localizedDescription)
                         }
                         }
                         return nil
                         }
                         
                         let str = "{\"name\":\"James\"}"
                         
                         let dict = convertToDictionary(text: str)
                         
                         */
                        
                        
                        
                        func convertToDictionary(text: String) -> [String: Any]? {
                            if let data = text.data(using: .utf8) {
                                do {
                                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            return nil
                        }
                        
                        let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                        
                        let dict = convertToDictionary(text: responseString! as String)
                        //print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                        //print(dict!)
                        
                        //print(dict![0])
                        
                        
                        print("\nResponse Data: \(responseString!)\n\n")
                        //var animals = (responseString!.value(forKeyPath: "animals") as! NSArray)
                        //print(animals)
                    }
                    
                    // TODO: Implement data processing
                }
            }
        }
        dataTask.resume()
        
        
    }
    
}








