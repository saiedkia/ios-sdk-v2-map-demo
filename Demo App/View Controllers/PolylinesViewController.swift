//
//  PolylinesViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class PolylinesViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        let coordinates = [CLLocationCoordinate2D(latitude: 35.719820, longitude: 51.406258),
                           CLLocationCoordinate2D(latitude: 34.634002, longitude: 50.875116),
                           CLLocationCoordinate2D(latitude: 33.979195, longitude: 51.412375),
                           CLLocationCoordinate2D(latitude: 32.650998, longitude: 51.666047),
                           CLLocationCoordinate2D(latitude: 29.578307, longitude: 52.581962)]
        
        let polyline = MGLPolyline(coordinates: coordinates, count: UInt(coordinates.count))
        mapView.addAnnotation(polyline)
        
        var annotations = [MGLPointAnnotation]()
        for coordinate in coordinates {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = coordinate
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
        mapView.zoomLevel = 5.5
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 32.282091, longitude: 53.151601)
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return #colorLiteral(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
    }
    
}
