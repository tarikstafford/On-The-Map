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
                Constants.SessionInfo.sessionID = ""
                if Constants.SessionInfo.isFacebookLogin {
                    
                }
                performUIUpdatesOnMain {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func addYourPost(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostPin") as! PostPinViewController
        self.navigationController?.present(vc, animated: true)
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
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func applySettingsActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.addSubview(activityIndicator)
        
    }
    
    

}
