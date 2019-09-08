//
//  RestrictMapPanningViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 14/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class RestrictMapPanningViewController: UIViewController, MGLMapViewDelegate {

    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.minimumZoomLevel = 1
        }
    }
    
    var iran: MGLCoordinateBounds!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        let northwest = CLLocationCoordinate2D(latitude: 42.0, longitude: 66.0)
        let southeast = CLLocationCoordinate2D(latitude: 22.0, longitude: 42.0)
        
        iran = MGLCoordinateBounds(sw: southeast, ne: northwest)
        
        mapView.zoomLevel = 7
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.631642, longitude: 51.349183)
        
    }
    
    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool {
        
        let currentCamera = mapView.camera
        
        let newCameraCenter = newCamera.centerCoordinate
        
        mapView.camera = newCamera
        let newVisibleCoordinates = mapView.visibleCoordinateBounds
        
        mapView.camera = currentCamera
        
        let inside = MGLCoordinateInCoordinateBounds(newCameraCenter, self.iran)
        let intersects = MGLCoordinateInCoordinateBounds(newVisibleCoordinates.ne, iran) && MGLCoordinateInCoordinateBounds(newVisibleCoordinates.sw, iran)
        
        return inside && intersects
    }
}
