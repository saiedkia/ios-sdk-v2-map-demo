//
//  UserCurrentLocationViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class UserCurrentLocationViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.minimumZoomLevel = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        
        view.addSubview(mapView)
        
        view.sendSubviewToBack(mapView)
        
        mapView.delegate = self
    }
    
    @IBAction func locateUserButtonTouched(_ sender: UIButton) {
        mapView.userTrackingMode = .followWithHeading
        mapView.showsUserHeadingIndicator = true
        mapView.showsUserLocation = true
    }
}
