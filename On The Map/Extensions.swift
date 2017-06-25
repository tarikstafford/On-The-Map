//
//  Extensions.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/16/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

extension String {
    
    func emailCheck() -> Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
