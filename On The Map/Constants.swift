//
//  File.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/7/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

struct Constants {
    
    //Udacity API
    struct UAPI {
        static let SessionMethod = "https://www.udacity.com/api/session"
    }
    
    //Login Data
    struct LoginInformation {
        
        static var loggedIn: Bool = false
        static var facebookName: String?
        static var uniqueKey = ""
        static var username = ""
        static var password = ""
    }
    
    struct SessionInfo {
        static var sessionID = ""
        static var facebookToken = ""
        static var isFacebookLogin: Bool = false
    }
    
    struct myStudentData {
        static var firstName = ""
        static var secondName = ""
        static var mapString = ""
        static var latitude = ""
        static var longitude = ""
        static var mediaLink = ""
    }
    
    struct Parse {
        static let Url = "https://parse.udacity.com/parse/classes"
        static let RESTApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
    }
    
    
    
}
