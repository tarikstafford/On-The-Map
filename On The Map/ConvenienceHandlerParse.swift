//
//  ConvenienceHandlerParse.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/5/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func populateTable(_ completionHandlerForPopulateTable: @escaping (_ success: Bool, _ arrayStudentData: [AnyObject]?, _ errorString: String?) -> Void) {
        
        let _ = taskForGetMethod() { (results, error) in
            
            if error != nil {
                print(error)
                completionHandlerForPopulateTable(false, nil, "Login Failed.")
            } else if let results = results {
                //Check Acct Info
                if let arrayStudentData = results["results"] as? [[String:AnyObject?]] {
                    
                    for object in arrayStudentData {
                        let object = 
                    }
                    
                } else {
                    print("There is an problem with Parse Results, no array found")
                }
                
                completionHandlerForPopulateTable(true, nil, nil)
            }
            
        }
    }
    
    
    
    
    
    
}
