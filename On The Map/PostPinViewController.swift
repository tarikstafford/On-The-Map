//
//  PostPinViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/9/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit
import CoreLocation

class PostPinViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBAction func findLocationButton(_ sender: Any) {
        
        guard let address = locationTextField.text else {
            return
        }
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            // Use your location
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShareLocation") as! ShareLocationViewController
            vc.locationPin = location
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
