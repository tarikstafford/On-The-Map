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
                completionHandlerForPopulateTable(false, nil, "Server Error")
            } else if let results = results {
                //Check Acct Info
                
                var arrayStudentData = [StudentData]()
                
                if let arrayObjects = results["results"] as? [[String:AnyObject?]] {
                    
                    for object in arrayObjects {

                        let dataObject = StudentData(json: object)
                        
                        arrayStudentData.append(dataObject)
                    }
                    
                } else {
                    completionHandlerForPopulateTable(false,nil,"Could Not Retrieve Student Data")
                }
                print(arrayStudentData)
                completionHandlerForPopulateTable(true, arrayStudentData, nil)
            }
            
        }
    }
    
    func postPinToMap(_ completionHandlerForPostPinToMap: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let _ = taskForPostMethod() { (results, error) in
            
            if error != nil {
                print(error!)
                completionHandlerForPostPinToMap(false, "Post Failed")
            } else if let results = results as? [String:AnyObject] {
                
                if let objectId = results["objectId"] as? String {
                    Constants.myStudentData.objectId = objectId
                } else {
                    return
                }
                
                completionHandlerForPostPinToMap(true, nil)
            }
        }
    }
}
