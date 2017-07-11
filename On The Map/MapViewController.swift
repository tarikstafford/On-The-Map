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
        createAnnotationArray(StudentData.ArrayStudentData.sharedInstance)
//        loadData(createAnnotationArray(_:_:))
        mapView.delegate = self
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func refreshData(_ sender: Any) {
        performUIUpdatesOnMain {
            self.mapView.reloadInputViews()
        }
    }
    
    @IBAction func postPin(_ sender: Any) {
        addYourPost()
    }
    
    var annotationArray = [MKAnnotation]()
    
//    func loadData(_ completionHandlerForLoadData: @escaping (_ result: [StudentData],_ error: String?) -> Void) {
//        ParseClient.sharedInstance().populateTable(pageLoad) { (success, arrayStudentData, error) in
//            if success{
//                if let studentDataArray = arrayStudentData {
//                    completionHandlerForLoadData(studentDataArray,nil)
//                }
//            }
//        }
//    }
    
    func createAnnotationArray(_ studentDataArray: [StudentData]) {
        for object in studentDataArray {
            
            let coordinate = CLLocationCoordinate2D(latitude: object.latitude, longitude: object.longitude)
            
            let pin = PinAnnotation(title: object.firstName , subtitle: object.mediaURL, coordinate: coordinate)
            
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
                }
            }
        }
    }
}
