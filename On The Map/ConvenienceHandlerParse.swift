//
//  ConvenienceHandlerParse.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/5/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func populateTable(_ completionHandlerForPopulateTable: @escaping (_ success: Bool, _ arrayStudentData: [StudentData]?, _ errorString: String?) -> Void) {
        
        let _ = taskForGetMethod() { (results, error) in
            
            if error != nil {
                print(error!)
                completionHandlerForPopulateTable(false, nil, "Login Failed.")
            } else if let results = results {
                //Check Acct Info
                
                var arrayStudentData = [StudentData]()
                
                if let arrayObjects = results["results"] as? [[String:AnyObject?]] {
                    
                    for object in arrayObjects {
                        
                        guard let createdAt = object["createdAt"] as? String else {
                            return
                        }
                        guard let firstName = object["firstName"] as? String else {
                            return
                        }
                        guard let lastName = object["lastName"] as? String else {
                            return
                        }
                        guard let latitude = object["latitude"] as? Double else {
                            return
                        }
                        guard let longitude = object["longitude"] as? Double else {
                            return
                        }
                        guard let mapString = object["mapString"] as? String else {
                            return
                        }
                        guard let mediaURL = object["mediaURL"] as? String else {
                            return
                        }
                        guard let objectId = object["objectId"] as? String else {
                            return
                        }
                        guard let uniqueKey = object["uniqueKey"] as? String else {
                            return
                        }
                        guard let updatedAt = object["updatedAt"] as? String else {
                            return
                        }
                        
                        let dataObject = StudentData(createdAt: createdAt, firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, mapString: mapString, mediaURL: mediaURL, objectId: objectId, uniqueKey: uniqueKey, updatedAt: updatedAt)
                        
                        arrayStudentData.append(dataObject)
                    }
                    
                } else {
                    print("There is an problem with Parse Results, no array found")
                }
                print(arrayStudentData)
                completionHandlerForPopulateTable(true, arrayStudentData, nil)
            }
            
        }
    }
    
    
    
    
    
    
}
