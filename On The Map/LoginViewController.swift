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
                        print("LOGIN FAILED")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        configureBackground()
        
        if (AccessToken.current != nil) {
            facebookAuth()
        }
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        view.addSubview(loginButton)
        
        loginButton.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        usernameField.clearsOnBeginEditing = true
        passwordField.clearsOnBeginEditing = true
        
        passwordField.delegate = self
    }
        
    func completeLogin(){

        let controller = storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        present(controller, animated: true, completion: nil)
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

