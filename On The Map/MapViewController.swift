//
//  MapViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/30/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        performUIUpdatesOnMain {
            self.mapView.addAnnotations(self.annotationArray)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var studentDataArray = [StudentData]()
    var annotationArray = [MKAnnotation]()
    var loadingData = false
    var pageLoad = 0
    
    func loadData() {
        ParseClient.sharedInstance().populateTable(pageLoad) { (success, arrayStudentData, error) in
            if success{
                if let tempArray = arrayStudentData {
                    self.studentDataArray = self.studentDataArray + tempArray
                    self.loadingData = false
                    self.pageLoad = self.pageLoad + 40
                }
            }
        }
        
        for object in studentDataArray {
            if let lat = object.latitude, let long = object.longitude, let media = object.mediaURL {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let pin = PinAnnotation(title: object.firstName , subtitle: media, coordinate: coordinate)
                
                annotationArray.append(pin)
                
            }
        }
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
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    
    //    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //
    //        if control == annotationView.rightCalloutAccessoryView {
    //            let app = UIApplication.sharedApplication()
    //            app.openURL(NSURL(string: annotationView.annotation.subtitle))
    //        }
    //    }
    
    
    
    
}
