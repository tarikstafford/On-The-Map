//
//  ViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/7/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController, UITextFieldDelegate, LoginButtonDelegate {

    var session: URLSession!
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func signUpButton(_ sender: Any) {
        let url = URL(string: "https://www.udacity.com/account/auth#!/signup")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let username = usernameField.text else{
            return
        }
        
        guard let password = passwordField.text else{
            return
        }
        
        if isValidEmailAddress(emailAddressString: username) {
            if password.isEmpty == false {
                Constants.LoginInformation.username = username
                Constants.LoginInformation.password = password
                UdacityClient.sharedInstance().loginFunc() { (success, sessionID, errorString) in
                    if success {
                        performUIUpdatesOnMain {
                            print(sessionID ?? "none")
                            self.completeLogin()
                        }
                    } else {
                        performUIUpdatesOnMain {
                            self.failedAlert("Login Failed!", "Please try again.")
                        }
                                            }
                }
            } else {
                performUIUpdatesOnMain {
                    self.failedAlert("Password is Empty!", "Please enter a proper password.")
                }
            }
        } else {
            performUIUpdatesOnMain{
                self.failedAlert("Invalid Email!", "Please Enter a Proper Email Address.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        
        if (AccessToken.current != nil) {
            usernameField.isEnabled = false
            passwordField.isEnabled = false
            
            facebookAuth()
        }
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        let newCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 70)
        loginButton.center = newCenter
        
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        usernameField.clearsOnBeginEditing = true
        passwordField.clearsOnBeginEditing = true
        
        passwordField.delegate = self
    }
        
    func completeLogin(){
        
        ParseClient.sharedInstance().populateTable(0) { (success, arrayStudentData, error) in
            if success{
                if let tempArray = arrayStudentData {
                    StudentData.ArrayStudentData.sharedInstance = tempArray
                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(controller, animated: true, completion: nil)
                }
            } else {
                performUIUpdatesOnMain {
                    self.failedAlert("Login Failed!", "Could not login please try again!")
                }
            }
        }
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loginPressed((Any).self)
        return true
    }
}

