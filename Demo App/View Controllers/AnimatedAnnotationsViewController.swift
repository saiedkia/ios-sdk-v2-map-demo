//
//  AnimatedAnnotationsViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class AnimatedAnnotationsViewController: UIViewController, MGLMapViewDelegate {
    
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
        
        let coordinates = [CLLocationCoordinate2D(latitude: 35.0, longitude: 51.0),
                           CLLocationCoordinate2D(latitude: 36.0, longitude: 52.0),
                           CLLocationCoordinate2D(latitude: 34.0, longitude: 50.0)]
        
        var annotations = [MGLPointAnnotation]()
        
        for coordinate in coordinates {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(coordinate.latitude), \(coordinate.longitude)"
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.0, longitude: 51.0)
        mapView.zoomLevel = 6
    }
    
    // - MARK: MGLMapViewDelegate methods
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else {
            return nil
        }
            
        let reuseIdentifier = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? AnimatedAnnotationView
        
        if annotationView == nil {
            annotationView = AnimatedAnnotationView(reuseIdentifier: reuseIdentifier)
            
            annotationView?.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            let hue = CGFloat(annotation.coordinate.longitude.remainder(dividingBy: 50)) / 10
            annotationView?.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }
        
        return annotationView
    }
    
}

class AnimatedAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? bounds.width / 4 : 2
        layer.add(animation, forKey: "borderWidth")
    }
}
