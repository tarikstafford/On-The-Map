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

class ShareLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mediaTextField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func sharePin(_ sender: Any) {
        
        if let mediaURL = mediaTextField.text{
            Constants.myStudentData.mediaLink = mediaURL
            
            ParseClient.sharedInstance().postPinToMap() { (success, error) in
                if success {
                    let alert = UIAlertController(title: "Location Posted!",message: "You Have Successfully Posted Your Location and Link", preferredStyle: .alert)
                    let finishPosting = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
                        // Get 1st TextField's text
                        self.navigationController!.popToRootViewController(animated: true)
                    })
                    alert.addAction(finishPosting)
                    performUIUpdatesOnMain {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
        }
        
    }
    var locationPin: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        
    }
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
