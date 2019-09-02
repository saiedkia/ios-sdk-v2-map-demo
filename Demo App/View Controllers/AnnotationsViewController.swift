//
//  AnnotationsViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class AnnotationsViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        let tehranCoordinates = CLLocationCoordinate2D(latitude: 35.6, longitude: 51.3)
        
        let annotaion = MGLPointAnnotation()
        annotaion.coordinate = tehranCoordinates
        mapView.addAnnotation(annotaion)
        
        mapView.zoomLevel = 2
        mapView.centerCoordinate = tehranCoordinates
    }
}
