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
        
        PetfinderAPIManager.sharedInstance.performOAuthLogin(completion: {
            var request = URLRequest(url: URL(string: urlPath)!)
            let token = PetfinderAPIManager.sharedInstance.authToken
            var token_test = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ3NTNmMjRiZmNjYWUzZDdiYmQxZWJkYmQ5NjIwZDY2ODUzMGJlOTA3YTY4Njk1NTViMTY5Y2QzNjIyOTIzYThlMmMyODVlNmQxZDFlMjM1In0.eyJhdWQiOiJEQ3ZONFZuQ3R6TGFDem85Uzk2VHhVSU01Z01oelphbTI0VUJGUTRmMFNpTzN4eW5TayIsImp0aSI6ImQ3NTNmMjRiZmNjYWUzZDdiYmQxZWJkYmQ5NjIwZDY2ODUzMGJlOTA3YTY4Njk1NTViMTY5Y2QzNjIyOTIzYThlMmMyODVlNmQxZDFlMjM1IiwiaWF0IjoxNTU3MzM1ODQwLCJuYmYiOjE1NTczMzU4NDAsImV4cCI6MTU1NzMzOTQ0MCwic3ViIjoiIiwic2NvcGVzIjpbXX0.hjW6OxKxVPnrLQckdWBwH_sIFNp2bQzRnCeQvfbuCangjYvir631TEvc-vgAAGJ3XlO2cNPDxy5qrL5n8y0nPcRq2my0FssgzKQ4TjC7n751OIlcqDQGCNE3pGDJYXMXFvYkoOBkm13y05Du6QUOx64nhTSwTrjp9rszV3Kzox0fnPHRcONBmakYlzpMZmktPrI-hZby_wqWUjli-1cCo0sctvx2g2SVripg507b7ILTckMkSHf-GBqW0f8q46b9GL7frG0Acur9xb4L70ztO_ESSkKb3gcUe3A8JZStnURpgor29BO59vZK2mwqsqncVIu5p1l8ouzDd5Q6B73n5w"
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
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
                            
                            
                            print("\nResponse Data:\n \(responseString!)\n\n")
                            //var animals = (responseString!.value(forKeyPath: "animals") as! NSArray)
                            //print(animals)
                        }
                        
                        // TODO: Implement data processing
                    }
                }
            }
            dataTask.resume()
        })
        
        /*if(!PetfinderAPIManager.sharedInstance.hasOAuthToken()){
            PetfinderAPIManager.sharedInstance.performOAuthLogin(completion: {
                token = PetfinderAPIManager.sharedInstance.authToken
            })
         print("in if loop in getData")
         print(PetfinderAPIManager.sharedInstance.authToken)
        } else {
            token = "WTF"
        }*/
        
        //let fullNameArr = fullName.components(separatedBy: " ")
        //let token = PetfinderAPIManager.sharedInstance.authToken
        
        //print("The token being fed into the request is: ")
        //let token = PetfinderAPIManager.sharedInstance.authToken
        //print(token)
        
        //print("reached")
        
        // Perform GET request using Alamofire and check response data integrity before passing to data handler
        
        /*
        var request = URLRequest(url: URL(string: urlPath)!)
        var token_test = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ3NTNmMjRiZmNjYWUzZDdiYmQxZWJkYmQ5NjIwZDY2ODUzMGJlOTA3YTY4Njk1NTViMTY5Y2QzNjIyOTIzYThlMmMyODVlNmQxZDFlMjM1In0.eyJhdWQiOiJEQ3ZONFZuQ3R6TGFDem85Uzk2VHhVSU01Z01oelphbTI0VUJGUTRmMFNpTzN4eW5TayIsImp0aSI6ImQ3NTNmMjRiZmNjYWUzZDdiYmQxZWJkYmQ5NjIwZDY2ODUzMGJlOTA3YTY4Njk1NTViMTY5Y2QzNjIyOTIzYThlMmMyODVlNmQxZDFlMjM1IiwiaWF0IjoxNTU3MzM1ODQwLCJuYmYiOjE1NTczMzU4NDAsImV4cCI6MTU1NzMzOTQ0MCwic3ViIjoiIiwic2NvcGVzIjpbXX0.hjW6OxKxVPnrLQckdWBwH_sIFNp2bQzRnCeQvfbuCangjYvir631TEvc-vgAAGJ3XlO2cNPDxy5qrL5n8y0nPcRq2my0FssgzKQ4TjC7n751OIlcqDQGCNE3pGDJYXMXFvYkoOBkm13y05Du6QUOx64nhTSwTrjp9rszV3Kzox0fnPHRcONBmakYlzpMZmktPrI-hZby_wqWUjli-1cCo0sctvx2g2SVripg507b7ILTckMkSHf-GBqW0f8q46b9GL7frG0Acur9xb4L70ztO_ESSkKb3gcUe3A8JZStnURpgor29BO59vZK2mwqsqncVIu5p1l8ouzDd5Q6B73n5w"
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
 
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
        dataTask.resume()*/
        
        
    }
    
}








