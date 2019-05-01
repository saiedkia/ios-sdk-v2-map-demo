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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
