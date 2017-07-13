//
//  PostPinViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/9/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit
import CoreLocation

class PostPinViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func cancelPostLoc(_ sender: Any) {
        dismissVC()
    }
    @IBOutlet weak var locationTextField: UITextField!
    
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        locationTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func findLocationButton(_ sender: Any) {
        
        applySettingsActivityIndicator(activityIndicator)
        self.activityIndicator.startAnimating()
        
        guard let address = locationTextField.text else {
            return
        }
        // Geocode Location Address
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0)  {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        self.failedAlert("Geocoder Failed", "Please Re-enter your location")
                        self.activityIndicator.stopAnimating()
                        return
                }
                
                self.activityIndicator.stopAnimating()
                
                // Use your location
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShareLocation") as! ShareLocationViewController
                vc.locationPin = location
                
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
}
