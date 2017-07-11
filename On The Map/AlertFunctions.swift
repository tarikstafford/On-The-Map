//
//  AlertFunctions.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/11/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func refreshDataAlert(){
        
        let alert = UIAlertController(title: "Data Refreshed!",message: "Latest Data Being Displayed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        performUIUpdatesOnMain {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func failedAlert(_ title: String,_ message: String){
        let alert = UIAlertController(title: title ,message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        performUIUpdatesOnMain {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
