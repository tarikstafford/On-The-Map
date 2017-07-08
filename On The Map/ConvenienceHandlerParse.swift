//
//  ConvenienceHandlerParse.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/5/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func populateTable(_ skip: Int, _ completionHandlerForPopulateTable: @escaping (_ success: Bool, _ arrayStudentData: [StudentData]?, _ errorString: String?) -> Void) {
        
        let _ = taskForGetMethod(skip) { (results, error) in
            
            if error != nil {
                print(error!)
                completionHandlerForPopulateTable(false, nil, "Login Failed.")
            } else if let results = results {
                //Check Acct Info
                
                var arrayStudentData = [StudentData]()
                
                if let arrayObjects = results["results"] as? [[String:AnyObject?]] {
                    
                    for object in arrayObjects {

                        let dataObject = StudentData(json: object)
                        
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
