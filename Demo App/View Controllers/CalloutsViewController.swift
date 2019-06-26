//
//  CalloutsViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class CalloutsViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating object of Map View.
        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        // Making point annotations.
        let annotationA = MGLPointAnnotation()
        annotationA.coordinate = CLLocationCoordinate2D(latitude: 35.732547, longitude: 51.422682)
        annotationA.title = "Map.ir"
        annotationA.subtitle = "Savojinia, Tehran"
        
        let annotationB = MGLPointAnnotation()
        annotationB.coordinate = CLLocationCoordinate2D(latitude: 35.744870, longitude: 51.375341)
        annotationB.title = "Milad Tower"
        annotationB.subtitle = "Tehran"
        
        // Adding annotaions to the mapView
        mapView.addAnnotations([annotationA, annotationB])
        
        // Setting center of the map for better preview.
        mapView.zoomLevel = 11
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.739383, longitude: 51.398894)
    }
    
    // Delegate method to let the annotation show callouts.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
