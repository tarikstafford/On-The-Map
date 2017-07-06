//
//  StudentData.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/5/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

struct StudentData {
    
    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String?
    let uniqueKey: String?
    let updatedAt: String?
    
    init(createdAt: String?, firstName: String?, lastName: String?, latitude: Double?, longitude: Double?, mapString: String?, mediaURL: String?, objectId: String?, uniqueKey: String?, updatedAt: String?) {
        self.createdAt = createdAt
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.objectId = objectId
        self.uniqueKey = uniqueKey
        self.updatedAt = updatedAt
    }
    
}
