//
//  StoryboardBasedVersionViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 10/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class StoryboardBasedVersionViewController: UIViewController {

    @IBOutlet weak var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.minimumZoomLevel = 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
