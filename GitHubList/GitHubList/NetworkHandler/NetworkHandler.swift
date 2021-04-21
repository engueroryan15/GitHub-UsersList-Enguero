//
//  NetworkHandler.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import Foundation
import Alamofire

class NetworkHandler: NSObject {
    
    func getUserList(url: String, completionHandler: @escaping ([UserList]) -> Void){
        
        AF.request(url)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                        let errorValue = value
                        let jsonData = self.jsonToData(json: value)
                        let decoder = JSONDecoder()
                        
                        UserDefaults.standard.setValue(jsonData, forKey: "jsonData")

                        do {
                            let response = try decoder.decode([UserList].self, from: jsonData!)
                            print(response)
                            completionHandler(response)
                        } catch let error  {
                            print("Parsing Failed \(error.localizedDescription)")
                            debugPrint(error)
                            
                            do {
                                let response = try decoder.decode([UserList].self, from: UserDefaults.standard.data(forKey: "jsonData")!)
                                print(response)
                                completionHandler(response)
                            } catch let error  {
                                print("Parsing Failed \(error.localizedDescription)")
                                debugPrint(error)
    
                                
                            }
                            
                            
                            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: errorValue as? [AnyHashable : Any])
                            
                        }
                        
                    case .failure(let error):
                        print(error)
                      
                    }
            }
    }
    
    
    func getUserDetails(url: String, completionHandler: @escaping (UserDetails) -> Void){
        
        AF.request(url)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                        let errorValue = value
                        let jsonData = self.jsonToData(json: value)
                        let decoder = JSONDecoder()
                        
                        UserDefaults.standard.setValue(jsonData, forKey: "jsonData")

                        do {
                            let response = try decoder.decode(UserDetails.self, from: jsonData!)
                            print(response)
                            completionHandler(response)
                        } catch let error  {
                            print("Parsing Failed \(error.localizedDescription)")
                            debugPrint(error)
                            
                            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: errorValue as? [AnyHashable : Any])
                            
                        }
                        
                    case .failure(let error):
                        print(error)
                      
                    }
            }
    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    

}
