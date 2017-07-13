//
//  StudentData.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/5/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

struct StudentData {
    
    struct ArrayStudentData {
        static var sharedInstance = [StudentData]()
    }
    
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
    
    init(json: [String:AnyObject?]) {
        createdAt = json["createdAt"] as? String ?? ""
        firstName = json["firstName"] as? String ?? "Roger"
        lastName = json["lastName"] as? String ?? "Federer"
        latitude = json["latitude"] as? Double ?? 28.2011
        longitude = json["longitude"] as? Double ?? 83.9451
        mapString = json["mapString"] as? String ?? ""
        mediaURL = json["mediaURL"] as? String ?? "Is A God"
        objectId = json["objectId"] as? String ?? ""
        uniqueKey = json["uniqueKey"] as? String ?? ""
        updatedAt = json["updatedAt"] as? String ?? ""
    }
    
}
