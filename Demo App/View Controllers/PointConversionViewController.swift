//
//  PointConversionViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 14/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class PointConversionViewController: UIViewController, MGLMapViewDelegate {

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
        
        
    }

    @IBAction func handleMapTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let tapPoint = sender.location(in: mapView)
            let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
            
            print("Tap Coordinate: \(tapCoordinate.latitude), \(tapCoordinate.longitude)")
            
            if mapView.annotations != nil, let existingAnnotations = mapView.annotations {
                mapView.removeAnnotations(existingAnnotations)
            }
            
            let annotation = MGLPointAnnotation()
            annotation.coordinate = tapCoordinate
            annotation.title = "\(tapCoordinate.latitude), \(tapCoordinate.longitude)"
            
            mapView.addAnnotation(annotation)
            
        default:
            break
        }
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
