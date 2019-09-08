//
//  CodeBasedVersionViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 10/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class CodeBasedVersionViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.styleURL = MGLStyle.mapirVectorStyleURL
            mapView.minimumZoomLevel = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instanciate MapView
        mapView = MGLMapView(frame: view.bounds)
                
        view.addSubview(mapView)
        
        mapView.delegate = self
    }
}

