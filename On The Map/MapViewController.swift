//
//  MapViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/30/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation
import MapKit
import FacebookCore
import FacebookLogin

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var annotationArray = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnnotationArray(StudentData.ArrayStudentData.sharedInstance)
        mapView.delegate = self
    }
    @IBAction func logoutButton(_ sender: Any) {
        if AccessToken.current != nil {
            LoginManager().logOut()
            logOut()
        } else {
            logOut()
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func refreshData(_ sender: Any) {
        annotationArray = []
        refreshStudentDataArray() { (success, error) in
            if success{
                self.createAnnotationArray(StudentData.ArrayStudentData.sharedInstance)
                performUIUpdatesOnMain {
                    self.mapView.reloadInputViews()
                    self.refreshDataAlert()
                }
            } else {
                self.failedAlert("Refresh Data Error!", error ?? "Error Refreshing Data")
            }
        }
    }
    
    @IBAction func postPin(_ sender: Any) {
        addYourPost()
    }
    
    func createAnnotationArray(_ studentDataArray: [StudentData]) {
        for object in studentDataArray {
            
            let coordinate = CLLocationCoordinate2D(latitude: object.latitude, longitude: object.longitude)
            
            let pin = PinAnnotation(title: ("\(object.firstName) \(object.lastName)") , subtitle: object.mediaURL, coordinate: coordinate)
            
            annotationArray.append(pin)
            
            
        }
        
        self.mapView.addAnnotations(annotationArray)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                let url = URL(string: toOpen)!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    failedAlert("Invalid URL", "The URL can not be opened.")
                }
            }
        }
    }
}
