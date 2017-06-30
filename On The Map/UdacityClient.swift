//
//  AuthViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/15/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    let session = URLSession.shared
    
    override init() {
        super.init()
    }
    
    func taskForPostMethod(_ completionHandlerForPostMethod: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        let request = NSMutableURLRequest(url: URL(string: Constants.UAPI.SessionMethod)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(Constants.LoginInformation.username)\", \"password\": \"\(Constants.LoginInformation.password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("POST request error type: \(String(describing: error))")
                return
            }
            
            guard let data = data else{
                print("Data error")
                return
            }
            
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPostMethod)
            
            
            
        }
        task.resume()
        
        return task
        
    }
    
    func taskForDeleteMethod(_ completionHandlerForDeleteMethod: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        let request = NSMutableURLRequest(url: URL(string: Constants.UAPI.SessionMethod)!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("DELETE request error type: \(String(describing: error))")
                return
            }
            
            guard let data = data else{
                print("Data error")
                return
            }

            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForDeleteMethod)
        }
        task.resume()
        
        return task
    }
    
    func taskForGetMethod(_ completionHandlerForGetMethod: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/users/3903878747")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("GET request error type: \(String(describing: error))")
                return
            }
            
            guard let data = data else{
                print("Data error")
                return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForGetMethod)
            
        }
        task.resume()
        
        return task
    }
    
    func taskForPostFacebookSession(_ completionHandlerForFacebookPostMethod: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"facebook_mobile\": {\"access_token\": \"\(Constants.SessionInfo.facebookToken);\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("Facebook Udacity Post Method Error")
                return
            }
            guard let data = data else{
                print("Data error")
                return
            }
        let range = Range(5..<data.count)
        let newData = data.subdata(in: range) /* subset response data! */
        print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            
        self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForFacebookPostMethod)
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
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}