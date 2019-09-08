//
//  RoutingViewController.swift
//  Demo App
//
//  Created by SaiedKia on 9/3/19.
//  Copyright © 2019 MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox
import MapirServices

class RoutingViewController: UIViewController, MGLMapViewDelegate {
    
    @IBOutlet weak var fromTxt: UITextField!
    @IBOutlet weak var toTxt: UITextField!
    
    var searchResultView:UIView?
    var currentUserPosition:CLLocationCoordinate2D!
    var pointOne:CLLocationCoordinate2D?
    var pointTwo:CLLocationCoordinate2D?
    var places:[MPSSearchResult]?
    let searchView = UITableView()
    var activeTextField:UITextField? = nil
    
    
    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    // MARK: Instance of MapirServices
    let mps = MPSMapirServices.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromTxt.delegate = self
        toTxt.delegate = self
        
        // Creating object of Map View.
        mapView = MGLMapView(frame: view.bounds)
        view.insertSubview(mapView, at: 0)
        
        mapView.delegate = self
        
        // Setting center of the map for better preview.
        mapView.zoomLevel = 11
        currentUserPosition = CLLocationCoordinate2D(latitude: 35.739383, longitude: 51.398894)
        mapView.centerCoordinate = currentUserPosition
        
        searchView.delegate = self
        searchView.dataSource = self
    }
    
    
    
    func search(query:String) {
        
        mps.search(for: query, around: currentUserPosition, selectionOptions: [.poi, .roads], filter: .city("تهران")) { (result) in
            switch result {
            case .success(let searchResult):
                print("getSearchResult method was successful.")
                print("---> Search result is: \(searchResult)")
                self.showResult(result: searchResult)
            case .failure(let error):
                print("getSearchResult failed with error: \(error)")
                self.showResult(result: [MPSSearchResult]())
            }
        }
    }
    
    
    @IBAction func applyRouting(_ sender: Any) {
        if pointTwo != nil && pointOne != nil {
            mps.route(from: pointOne!, to: [pointTwo!], routeMode: .drivingNoExclusion, completionHandler: {(routeRsult) in
                switch routeRsult {
                case .success(_ , let routes):
                    
                    if let routes = routes.first?.geometry {
                       var cordinates = [CLLocationCoordinate2D]()
                       var annotations = [MGLPointAnnotation]()
                        
                       for route in routes {
                           let annotation = MGLPointAnnotation()
                           annotation.coordinate = route

                           cordinates.append(route)
                           annotations.append(annotation)
                       }
                       
                       let polyLines = MGLPolyline(coordinates: cordinates, count: UInt(cordinates.count))
                       self.mapView.addAnnotation(polyLines)
    
                       self.mapView.addAnnotations(annotations)
                    }

                    break
                    
                case .failure(_):
                    break
                }
            })
        }
    }
    
}

// MARK: text fields
extension RoutingViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentValue = textField.text!
        
        if currentValue.count <= 1 && string == "" {
            hideResult()
        } else {
            search(query: textField.text! + (string == "" ? "" : string))
        }
        
        activeTextField = textField
        return true
    }
}

// MARK: search resultView
extension RoutingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func showResult(result:[MPSSearchResult]) {
        hideResult()
        
        let rowHeaight = 50
        
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: activeTextField!.bottomAnchor, constant: 10).isActive = true
        searchView.leadingAnchor.constraint(equalTo: activeTextField!.leadingAnchor, constant: 0).isActive = true
        searchView.trailingAnchor.constraint(equalTo: activeTextField!.trailingAnchor, constant: 0).isActive = true
        searchView.bottomAnchor.constraint(equalTo: activeTextField!.bottomAnchor, constant: CGFloat(result.count * rowHeaight)).isActive = true
        searchView.backgroundColor = .red
        searchView.layer.borderColor = UIColor.black.cgColor
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 5
        
        searchResultView = searchView
        places = result
        searchView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = places![indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if activeTextField == fromTxt {
            pointOne = places?[indexPath.row].coordinates
        } else {
            pointTwo = places?[indexPath.row].coordinates
        }
        
        activeTextField?.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        hideResult()
    }
    
    func hideResult() {
        searchResultView?.removeFromSuperview()
    }
}
