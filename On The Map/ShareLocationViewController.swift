//
//  ShareLocationViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 7/9/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShareLocationViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mediaTextField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        mediaTextField.clearsOnBeginEditing = true
        mediaTextField.delegate = self
    }
    
    @IBAction func cancelPostLoc(_ sender: Any) {
        dismissVC()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    @IBAction func sharePin(_ sender: Any) {
        
        if let mediaURL = mediaTextField.text{
            Constants.myStudentData.mediaLink = mediaURL
            
            ParseClient.sharedInstance().postPinToMap() { (success, error) in
                if success {
                    self.alertWithFullDismiss("Location Posted", "Successfully posted a location!")
                } else {
                    self.alertWithFullDismiss("Location Not Posted", "Check your internet connection!")
                }
            }
            
        }
        
    }
    var locationPin: CLLocation?
    
    //Func to pull current user data
    func fetchUserData(){
        UdacityClient.sharedInstance().fetchUserData() { (success, error) in
            if success{
                if let annotation = self.createAnnotation(){
                    let coordinate = annotation.coordinate
                    self.mapView.addAnnotation(annotation)
                    self.mapView.setCenter(coordinate, animated: true)
                }
            } else {
                print(error ?? "Fetch User Data Error")
            }
        }
    }
    
    
    //Convert CLLocation type to Coordinates for mapkit and add coordinates to myStudentData for ParseClient
    func createAnnotation() -> PinAnnotation? {
        
        guard let locationUnwrapped = locationPin else {
            print("Location Pin Error")
            return nil
        }
        
        let coordinates = CLLocationCoordinate2D(latitude: locationUnwrapped.coordinate.latitude, longitude: locationUnwrapped.coordinate.longitude)
        
        Constants.myStudentData.latitude = coordinates.latitude
        Constants.myStudentData.longitude = coordinates.longitude
        
        let myPin = PinAnnotation(title: Constants.myStudentData.firstName, subtitle: "Your Link Will Go Here", coordinate: coordinates)
        
        
        return myPin
    }
}
