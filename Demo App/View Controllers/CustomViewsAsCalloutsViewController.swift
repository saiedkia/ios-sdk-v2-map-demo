//
//  CustomViewsAsCalloutsViewController.swift
//  Demo App
//
//  Created by Alireza Asadi on 11/2/1398 AP.
//  Copyright © 1398 AP MrAlirezaa. All rights reserved.
//

import UIKit
import Mapbox

class CustomViewsAsCalloutsViewController: UIViewController, MGLMapViewDelegate {
    
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
        mapView.delegate = self
        view.addSubview(mapView)
        
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.732547, longitude: 51.422682)
        annotation.title = "Milad Tower"
        annotation.subtitle = "Tehran, Iran"
        
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        return CustomCalloutView(representedObject: annotation)
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        mapView.deselectAnnotation(annotation, animated: true)
        
        let alert = UIAlertController(title: annotation.title!, message: annotation.subtitle!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

class CustomCalloutView: UIView, MGLCalloutView {
    var representedObject: MGLAnnotation
    
    var button: UIButton
    
    override var center: CGPoint {
        set {
            var newCenter = newValue
            newCenter.y -= bounds.midY
            super.center = newCenter
        }
        get {
            return super.center
        }
    }
    
    var leftAccessoryView = UIView()
    var rightAccessoryView = UIView()
    
    var dismissesAutomatically: Bool = false
    var isAnchoredToAnnotation: Bool = true
    
    weak var delegate: MGLCalloutViewDelegate?
    
    init(representedObject: MGLAnnotation) {
        self.representedObject = representedObject
        button = UIButton(type: .system)
        
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 10.0
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tipHeight: CGFloat = 10
    let tipWidth: CGFloat = 20
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        view.addSubview(self)
        
        button.setTitle(representedObject.title!, for: .normal)
        button.sizeToFit()
        
        if isCalloutTappable() {
            button.addTarget(self, action: #selector(CustomCalloutView.tapCallout), for: .touchUpInside)
        } else {
            button.isUserInteractionEnabled = false
        }
        
        let frameHeight = button.bounds.size.height + tipHeight
        let frameWidth = button.bounds.size.width
        let frameOriginX = rect.origin.x + rect.size.width / 2.0 - frameWidth / 2.0
        let frameOriginY = rect.origin.y - tipHeight
        
        self.frame = CGRect(x: frameOriginX, y: frameOriginY, width: frameWidth, height: frameHeight)
        
        if animated {
            self.alpha = 0
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.alpha = 1
            }
        }
    }
    
    func dismissCallout(animated: Bool) {
        if superview != nil {
            if animated {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.removeFromSuperview()
                })
            } else {
                self.removeFromSuperview()
            }
        }
    }
    
    private func isCalloutTappable() -> Bool {
        if let delegate = delegate, delegate.responds(to: #selector(MGLCalloutViewDelegate.calloutViewShouldHighlight(_:))) {
            return delegate.calloutViewShouldHighlight!(self)
        }
        return false
    }
    
    @objc func tapCallout() {
        if isCalloutTappable() && delegate!.responds(to: #selector(MGLCalloutViewDelegate.calloutViewTapped(_:))) {
            delegate!.calloutViewTapped?(self)
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Draw the pointed tip at the bottom.
        let fillColor: UIColor = .darkGray
        
        let tipLeft = rect.origin.x + (rect.size.width / 2.0) - (tipWidth / 2.0)
        let tipBottom = CGPoint(x: rect.origin.x + (rect.size.width / 2.0), y: rect.origin.y + rect.size.height)
        let heightWithoutTip = rect.size.height - tipHeight - 1
        
        let currentContext = UIGraphicsGetCurrentContext()!
        
        let tipPath = CGMutablePath()
        tipPath.move(to: CGPoint(x: tipLeft, y: heightWithoutTip))
        tipPath.addLine(to: CGPoint(x: tipBottom.x, y: tipBottom.y))
        tipPath.addLine(to: CGPoint(x: tipLeft + tipWidth, y: heightWithoutTip))
        tipPath.closeSubpath()
        
        fillColor.setFill()
        currentContext.addPath(tipPath)
        currentContext.fillPath()
    }
    
}
