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
    
    let activityIndicator = UIActivityIndicatorView()
    
    @IBAction func findLocationButton(_ sender: Any) {
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
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
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
