//
//  NavBarFunctions.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/9/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func logOut() {
        UdacityClient.sharedInstance().logOutFunc() { (success, results, error) in
            
            if success{
                print("DELETE METHOD SUCCESSFUL")
                Constants.SessionInfo.sessionID = ""
                if Constants.SessionInfo.isFacebookLogin {
                    
                }
                performUIUpdatesOnMain {
                    print("PERFORMING UI UPDATES")
                    self.dismiss(animated: true, completion: nil)
                    let loginViewController = LoginViewController()
                    self.present(loginViewController, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func addYourPost(){
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
