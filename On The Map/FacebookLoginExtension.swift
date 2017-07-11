//
//  FacebookLoginExtension.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/27/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//
import FacebookLogin
import FacebookCore
import UIKit

extension LoginViewController {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(grantedPermissions: _, declinedPermissions: _, token: _):
            print("logged in")
            facebookAuth()
        case .failed:
            print("Failed Login")
        case .cancelled:
            print("Cancelled")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        logOut()
    }
    
    func facebookAuth(){
        if let accessToken = AccessToken.current {
            Constants.SessionInfo.facebookToken = accessToken.authenticationToken
            Constants.LoginInformation.facebookName = accessToken.userId
        }
        UdacityClient.sharedInstance().facebookLoginFunc() { (success, session, error) in
            if success {
                    self.completeLogin()
            } else {
                print("LOGIN FAILED")
            }
        }
    }
    
}
