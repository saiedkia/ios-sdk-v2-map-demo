# Getting Started with MAP.IR iOS SDK

## Table of Contents
- [Getting Started with MAP.IR iOS SDK](#getting-started-with-mapir-ios-sdk)
  - [Table of Contents](#table-of-contents)
  - [Add Map.ir SDK to Xcode project.](#add-mapir-sdk-to-xcode-project)
  - [Generating map view using code](#generating-map-view-using-code)
  - [Using Interface Builder to add a map view](#using-interface-builder-to-add-a-map-view)
  - [Getting user current location](#getting-user-current-location)
  - [Placing markers on the map](#placing-markers-on-the-map)
  - [Showing callouts for annotations.](#showing-callouts-for-annotations)
  - [Polylines](#polylines)
  - [Polygons](#polygons)
  - [Custom annotation views and images](#custom-annotation-views-and-images)
  - [Animated annotation views](#animated-annotation-views)
  - [Custom views as callouts](#custom-views-as-callouts)
  - [Point Conversion](#point-conversion)
  - [Restrict map panning](#restrict-map-panning)


## Add Map.ir SDK to Xcode project.

[Map.ir]() SDK is build using Mapbox iOS SDK. in order to comunicate with map.ir servers, you must only use map.ir SDK which is available on the website.

For every project you may follow these steps to add map.ir SDK to your project.

1. Download the SDK from the [iOS SDK Page](corp.map.ir).
2. from the navigation bar select your project, then select general tab.
3. drag and drop the **.framework** file into the **Embedded Binaries** section.
4. Check the copy items if needed. then click finish.
5. Go to the **Build Phases** tab and click the + button. Select **New Run Script Phase**.
6. Add the following code to the shell:
   
    ```bash
    bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Mapbox.framework/strip-frameworks.sh"
    ```
7. Build (⌘ + B) your code and see if there is no errors.
8. no you can import Mapbox in your code:

    ```swift
    import Mapbox
    ```


## Generating map view using code
Add SDK to your project (See [here](#add-mapir-sdk-to-xcode-project)). replace the following code with your `ViewController` class in **ViewController.swift** file.

```swift
class ViewController: UIViewController {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            // Using Map.ir vector map.
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.minimumZoomLevel = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        
        // Set maps center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 30.2, longitude: 50.8), zoomLevel: 9, animated: false)
        view.addSubview(mapView)
    }
}
```
Now run you app.

## Using Interface Builder to add a map view
1. Open **Main.storyboard**.
2. Open Library and find UIView, then drag and drop it into the view controller.
3. Open the identity inspector for the newly added UIView, and set the value of class to be `MGLMapView`.
4. Now, replace the `ViewController` class with the following code.
5. Open up the assistant editor. (make sure its showing ViewController.swift) first select the mapView then ⌃ + Drag the view and drop it above the `viewDidLoad()` function in the assistant editor.
6. in the opened box, name your view. something like  `mapView`.
7. Import Mapbox in **ViewController.swift** file.

    ```swift
    import Mapbox
    ```
8. Now, you can set up your mapView like so:

    ```swift
    @IBOutlet weak var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.minimumZoomLevel = 1
        }
    }
    ```

## Getting user current location

Accessing GPS data and location services in iOS requires user permission. in order to do so you must add a key-valuew pair to your info.plist file.

1. Open the info.plist file
2. Press the + button and add the following key to it.
    ```
    Privacy - Location Always and When In Use Usage Description
    ```
3. Now set the value as you wish. it is going to be shown in prompt that asks for user permission to access location services. for examle: We need your location to show you on the Map

```swift
import Mapbox

class ViewController: UIViewController {
    
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
        
        // Adding user's location annotation.
        // Use this latitude: 35.732530 and longitude: 51.422444 for simulator if needed.
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        mapView.showsUserHeadingIndicator = true
    }
}
```
> Note: If you are using simulator, you must simulate location data. To do it, in your simulator, from top manu choose: Debug > Location > Custom Location. Then enter some random latitude and longitude in iran.

## Placing markers on the map

```swift
import Mapbox

class ViewController: UIViewController {
    
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
        
        let tehranCoordinates = CLLocationCoordinate2D(latitude: 35.6, longitude: 51.3)
        
        let annotaion = MGLPointAnnotation()
        annotaion.coordinate = tehranCoordinates
        mapView.addAnnotation(annotaion)
        
        mapView.zoomLevel = 2
        mapView.centerCoordinate = tehranCoordinates
    }
}
```

## Showing callouts for annotations.

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating object of Map View.
        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        // Making point annotations.
        let annotationA = MGLPointAnnotation()
        annotationA.coordinate = CLLocationCoordinate2D(latitude: 35.732547, longitude: 51.422682)
        annotationA.title = "Map.ir"
        annotationA.subtitle = "Savojinia, Tehran"
        
        let annotationB = MGLPointAnnotation()
        annotationB.coordinate = CLLocationCoordinate2D(latitude: 35.744870, longitude: 51.375341)
        annotationB.title = "Milad Tower"
        annotationB.subtitle = "Tehran"
        
        // Adding annotaions to the mapView
        mapView.addAnnotations([annotationA, annotationB])
        
        // Setting center of the map for better preview.
        mapView.zoomLevel = 11
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.739383, longitude: 51.398894)
    }
    
    // Delegate method to let the annotation show callouts.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
```

## Polylines

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
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
        return UIColor(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
    }
    
}
```

## Polygons

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

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
        
        let coordinates = [CLLocationCoordinate2D(latitude: 35.749245, longitude: 51.080899),
                           CLLocationCoordinate2D(latitude: 35.825123, longitude: 51.473877),
                           CLLocationCoordinate2D(latitude: 35.729642, longitude: 51.619514),
                           CLLocationCoordinate2D(latitude: 35.576021, longitude: 51.434265),
                           CLLocationCoordinate2D(latitude: 35.576021, longitude: 51.434265)]
        
        // Making the polygon with coordinates
        let polygon = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        polygon.title = "Tehran"
        polygon.subtitle = "Iran"
        
        // Adding polygon to the map
        mapView.addAnnotation(polygon)
        
        mapView.zoomLevel = 8
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.716877, longitude: 51.382115)
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return CGFloat(0.2)
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
```

## Custom annotation views and images

Before start, [download]() and add `camera.xcassets` catalog to your project.

```swift
// MGLPointAnnotation subclass
class CustomPointAnnotation: MGLPointAnnotation {
    var usesImage: Bool = false
}
```

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
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
        
        // Create four new point annotations with specified coordinates and titles.
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
        
        // adding an array of 4 points to the map instead of individually
        mapView.addAnnotations([pointA, pointB, pointC, pointD])
        
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.726472, longitude: 51.353191)
        mapView.zoomLevel = 12
    }
    
    // This delegate method is where you tell the map to load a view for a specific annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if let castAnnotation = annotation as? CustomPointAnnotation {
            if castAnnotation.usesImage {
                return nil
            }
        }
        
        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
        let reuseIdentifier = "Point"

        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
            
            annotationView?.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            annotationView?.layer.cornerRadius = (annotationView?.frame.width)! / 2.0
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView?.backgroundColor = UIColor(red: 1, green: 0.4190880954, blue: 0.3932890296, alpha: 1)
        }
        
        return annotationView
    }
    
    // This delegate method is where you tell the map to load a image for a specific annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let castAnnotation = annotation as? CustomPointAnnotation {
            if !castAnnotation.usesImage {
                return nil
            }
        }
        // Assign a reuse identifier to be used by both of the annotation images, taking advantage of their similarities.
        let reuseIdentifier = "Camera"

        // For better performance, always try to reuse existing annotations.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier)

        // If there’s no reusable annotation view available, initialize a new one.
        if annotationImage == nil {
            annotationImage = MGLAnnotationImage(image: UIImage(named: "camera")!, reuseIdentifier: reuseIdentifier)
        }
        
        return annotationImage
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
```

## Animated annotation views

In this example you need a custom annotation class (`AnimatedAnnotationClass`) which inherits from `MGLAnnotationView`.

```swift
// MGLAnnotatoinView subclass
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
```

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
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
```

## Custom views as callouts

In this example you need a `CustomCalloutView` class which conforms to `MGLCalloutView` protocol.

```swift
// MGLCalloutView subclass
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
    
    var leftAccessoryView = UIView() // Unused
    var rightAccessoryView = UIView() // Unused
    
    // Allow the callout to remain open during panning.
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
            // Handle taps and eventually try to send them to the delegate (usually the map view).
            button.addTarget(self, action: #selector(CustomCalloutView.tapCallout), for: .touchUpInside)
        } else {
            // Disable tapping and highlighting.
            button.isUserInteractionEnabled = false
        }
        
        // Prepare our frame, adding extra space at the bottom for the tip.
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

    // MARK: - Callout interaction handlers
    
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
```

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
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
```

## Point Conversion

1. Go to the `main.storyboard` file.
2. Open object library and choose UITapGestureTapRecognizer, drag and drop it on the view controller.
3. select tap gesture recognizer from the top bar then ⌃ + Drag the view and drop it below the `viewDidLoad()` function in the assistant editor.
4. from the connection type choose action and set the sender to be `UITabGestureRecognizer` then name the funcion. this block will be added to your code:
   ```swift
   @IBAction func handleMapTap(_ sender: UITapGestureRecognizer) {

   }
   ```

Now you can use this example to convert tap points to coordinates.

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

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
    }

    @IBAction func handleMapTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            // Convert tap location (CGPoint) to geographic coordinate (CLLocationCoordinate2D).

            let tapPoint = sender.location(in: mapView)
            let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
            
            print("Tap Coordinate: \(tapCoordinate.latitude), \(tapCoordinate.longitude)")
            
            // Remove last annotations from the map
            if mapView.annotations != nil, let existingAnnotations = mapView.annotations {
                mapView.removeAnnotations(existingAnnotations)
            }
            
            // Add a new point annotation at the tap coordinate
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

```

## Restrict map panning

```swift
import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    var mapView: MGLMapView! {
        didSet {
            mapView.styleURL = MGLStyle.mapirVectorStyleURL()
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.minimumZoomLevel = 1
        }
    }
    
    var iran: MGLCoordinateBounds!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        // Iran's bounds
        let northwest = CLLocationCoordinate2D(latitude: 42.0, longitude: 66.0)
        let southeast = CLLocationCoordinate2D(latitude: 22.0, longitude: 42.0)
        
        iran = MGLCoordinateBounds(sw: southeast, ne: northwest)
        
        mapView.zoomLevel = 7
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 35.631642, longitude: 51.349183)
        
    }
    
    // This example uses Iran's boundaries to restrict the camera movement.
    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool {
        
        // Get the current camera to restore it after.
        let currentCamera = mapView.camera
        
        // From the new camera obtain the center to test if it’s inside the boundaries.
        let newCameraCenter = newCamera.centerCoordinate
        
        // Set the map’s visible bounds to newCamera.
        mapView.camera = newCamera
        let newVisibleCoordinates = mapView.visibleCoordinateBounds
        
        // Revert the camera.
        mapView.camera = currentCamera
        
        // Test if the newCameraCenter and newVisibleCoordinates are inside self.iran.
        let inside = MGLCoordinateInCoordinateBounds(newCameraCenter, self.iran)
        let intersects = MGLCoordinateInCoordinateBounds(newVisibleCoordinates.ne, iran) && MGLCoordinateInCoordinateBounds(newVisibleCoordinates.sw, iran)
        
        return inside && intersects
    }
}
```