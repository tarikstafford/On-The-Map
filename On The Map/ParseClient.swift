//
//  GetStudentLocation.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/15/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    let session = URLSession.shared
    
    override init(){
        super.init()
    }
    
    func taskForGetMethod(_ skip: Int,_ completionForGetMethod: @escaping (_ result: AnyObject?,_ error: NSError?) -> Void) -> URLSessionTask{
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation" + "?limit=40" + "&skip=\(skip)")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in

            if error != nil {
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
            guard let data = data else {
                print("data error get PARSE api")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionForGetMethod)
            
        }
        task.resume()
        
        return task
    }
    
    func taskForPostMethod(_ completionForPostMethod: @escaping (_ result: AnyObject?,_ error: NSError?) -> Void) -> URLSessionTask {
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(Constants.LoginInformation.uniqueKey)\", \"firstName\": \"\(Constants.myStudentData.firstName)\", \"\(Constants.myStudentData.secondName)\": \"Doe\",\"mapString\": \"\(Constants.myStudentData.mapString)\", \"mediaURL\": \"\(Constants.myStudentData.mediaLink)\",\"latitude\": \(Constants.myStudentData.latitude), \"longitude\": \(Constants.myStudentData.longitude)}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            
            guard let data = data else {
                print("data error get PARSE api")
                return
            }
            
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionForPostMethod)
        }
        task.resume()
        
        return task
    }
    
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?,_ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        
        completionHandlerForConvertData(parsedResult, nil)
        
    }
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        
        return Singleton.sharedInstance
    }
    
    
    
}
