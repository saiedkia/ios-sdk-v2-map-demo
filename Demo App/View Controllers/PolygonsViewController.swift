//
//  PolygonsViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox
class PolygonsViewController: UIViewController, MGLMapViewDelegate {

    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.minimumZoomLevel = 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        let coordinates = [CLLocationCoordinate2D(latitude: 35.749245, longitude: 51.080899),
                           CLLocationCoordinate2D(latitude: 35.825123, longitude: 51.473877),
                           CLLocationCoordinate2D(latitude: 35.729642, longitude: 51.619514),
                           CLLocationCoordinate2D(latitude: 35.576021, longitude: 51.434265),
                           CLLocationCoordinate2D(latitude: 35.576021, longitude: 51.434265)]
        
        let polygon = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        polygon.title = "Tehran"
        polygon.subtitle = "Iran"
        
        mapView.addAnnotation(polygon)
        
        mapView.zoomLevel = 8
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.716877, longitude: 51.382115)
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return #colorLiteral(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return #colorLiteral(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return CGFloat(0.2)
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
