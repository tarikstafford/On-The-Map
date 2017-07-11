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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostPin") as! PostPinViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshStudentDataArray(_ completionHandlerForRefreshData: @escaping (_ success: Bool,_ error: String?) -> Void) {
        
        ParseClient.sharedInstance().populateTable(0) { (success, arrayStudentData, error) in
            if success{
                if let tempArray = arrayStudentData {
                    StudentData.ArrayStudentData.sharedInstance = tempArray
                    completionHandlerForRefreshData(true,nil)
                }
            } else {
                completionHandlerForRefreshData(false, error)
            }
        }
    }
}
