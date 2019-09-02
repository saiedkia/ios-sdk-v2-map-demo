//
//  AnnotationViewsAndImagesViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class AnnotationViewsAndImagesViewController: UIViewController, MGLMapViewDelegate {
    
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
        
        mapView.delegate = self
        
        let pointA = CustomPointAnnotation()
        pointA.coordinate = CLLocationCoordinate2D(latitude: 35.699738, longitude: 51.338116)
        pointA.title = "Azadi Tower"
        pointA.usesImage = true
        
        let pointB = CustomPointAnnotation()
        pointB.coordinate = CLLocationCoordinate2D(latitude: 35.744870, longitude: 51.375302)
        pointB.title = "Milad Tower"
        pointB.usesImage = true
        
        let pointC = CustomPointAnnotation()
        pointC.coordinate = CLLocationCoordinate2D(latitude: 35.746102, longitude: 51.342211)
        pointC.title = "Nahjolbalagheh Park"
        
        let pointD = CustomPointAnnotation()
        pointD.coordinate = CLLocationCoordinate2D(latitude: 35.703206, longitude: 51.351323)
        pointD.title = "Sharif University"
        
        mapView.addAnnotations([pointA, pointB, pointC, pointD])
        
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.726472, longitude: 51.353191)
        mapView.zoomLevel = 12
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if let castAnnotation = annotation as? CustomPointAnnotation {
            if castAnnotation.usesImage {
                return nil
            }
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Point")
        
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: "Point")
            
            annotationView?.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            annotationView?.layer.cornerRadius = (annotationView?.frame.width)! / 2.0
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView?.backgroundColor = #colorLiteral(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let castAnnotation = annotation as? CustomPointAnnotation {
            if !castAnnotation.usesImage {
                return nil
            }
        }
        
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "Camera")
        
        if annotationImage == nil {
            annotationImage = MGLAnnotationImage(image: UIImage(named: "camera")!, reuseIdentifier: "Camera")
        }
        
        return annotationImage
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}


class CustomPointAnnotation: MGLPointAnnotation {
    var usesImage: Bool = false
}
