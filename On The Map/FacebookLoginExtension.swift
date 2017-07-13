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
            facebookAuth()
        case .failed:
            self.failedAlert("Failed Facebook Login!", "Please Try Again.")
        case .cancelled:
            self.failedAlert("Cancelled Facebook Login!", "Please Try Again")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        logOut()
    }
    
    func facebookAuth(){
        performUIUpdatesOnMain {
            self.activityIndicator.startAnimating()
            self.textFieldsToggle(false)
        }
        
        if let accessToken = AccessToken.current {
            Constants.SessionInfo.facebookToken = accessToken.authenticationToken
            Constants.LoginInformation.facebookName = accessToken.userId
        }
        UdacityClient.sharedInstance().facebookLoginFunc() { (success, session, error) in
            if success {
                self.completeLogin()
            } else {
                self.failedAlert("Facebook Login Failed", "Please Try Again.")
                performUIUpdatesOnMain {
                    self.activityIndicator.startAnimating()
                    self.textFieldsToggle(true)
                }
            }
        }
    }
    
}
