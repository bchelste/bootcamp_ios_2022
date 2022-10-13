//
//  ViewController.swift
//  rush01
//
//  Created by Vitaliy Plaschenkov on 24.08.2022.
//

import UIKit
import MapKit
import CoreLocation

enum TransportType {
    case auto
    case walk
}

class ViewController: UIViewController {
    
    var myPolyline: MKPolyline = MKPolyline()
    var startPosition = MKPointAnnotation()
    var finishPosition = MKPointAnnotation()

    @IBOutlet weak var finishLocation: UITextField!
    @IBOutlet weak var startLocation: UITextField!
    var sourceLocationFirst: CLLocationCoordinate2D?
    var sourceLocationSecond: CLLocationCoordinate2D?
    var transtortSelected = TransportType.auto
    let locationManager = CLLocationManager()
    var locationPerson: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var userLocation: UIButton!

    @IBAction func userLocation(_ sender: UIButton) {
        guard let locationPerson = locationPerson else {
            return
        }
        let region = MKCoordinateRegion(center: locationPerson, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }
    @IBAction func mapChanges(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex){
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }

    @IBAction func transportType(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            transtortSelected = TransportType.auto
        case 1:
            transtortSelected = TransportType.walk
        default:
            break
        }
    }

    @IBAction func getRoute(_ sender: UIButton) {
        print("GET ROUTE button tapped")
        
        let start = startLocation.text ?? ""
        let finish = finishLocation.text ?? ""
        
        if start.isEmpty == true && finish.isEmpty == true{
            animateError(view: finishLocation)
            animateError(view: startLocation)
        }
        
        if checkLocationString(srcOne: start, srcTwo: finish) {
            actionAplication(start: start, finish: finish)
        } else {
            return
        }
    }
    
    @IBOutlet weak var getRoute: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocation.delegate = self
        finishLocation.delegate = self
        mapView.delegate = self

        userLocation.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        getRoute.layer.cornerRadius = 15
        setupManager()
    }
    
    private func setupManager(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    private func animateError(view: UITextField) {
    UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
        view.backgroundColor = .systemRed
    }, completion: {(finish : Bool) in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {
                view.backgroundColor = .white })})
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [CGPoint(x: view.frame.midX - 10, y: view.frame.midY), CGPoint(x: view.frame.midX + 10, y: view.frame.midY), CGPoint(x: view.frame.midX, y: view.frame.midY)]
        animation.autoreverses = true
        animation.duration = 0.2
        view.layer.add(animation, forKey: "position")
    }
    
    //MARK: - getLocation
    
    func getLocation(place: String, order: String, currentTextField: UITextField,  complition: @escaping (CLLocationCoordinate2D?) -> Void ){
        let geoCoder = CLGeocoder()
        
        if place.isEmpty {
            complition(locationPerson)
        } else {
            geoCoder.geocodeAddressString(place) { (location, error) in
                if let error = error{
                    self.animateError(view: currentTextField)
                    print(error)
                    complition(nil)
                }
                // Обработка несуществующей локации
                
                if let resultLocation = location {
                    let tmpString = resultLocation.first!.debugDescription
                    let subtitle = tmpString.prefix(while: { (character) -> Bool in
                        return character != "@"
                    })
                    switch order {
                    case "start":
                        self.startPosition.subtitle = String(subtitle)
                    case "finish":
                        self.finishPosition.subtitle = String(subtitle)
                    default: break
                    }
                    complition(resultLocation.first?.location?.coordinate)
                } else {
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - ROUTS
    
    func routeConstructor(start: CLLocationCoordinate2D,
                          finish: CLLocationCoordinate2D) {
        
        startPosition.coordinate = start
        startPosition.title = "Start position"

        finishPosition.coordinate = finish
        finishPosition.title = "Finish position"

        mapView.showAnnotations([startPosition, finishPosition], animated: true)
        
        let firstItem = MKMapItem(placemark: MKPlacemark(coordinate: start))
        let secondItem = MKMapItem(placemark: MKPlacemark(coordinate: finish))
    
        let request = MKDirections.Request()
        request.source = firstItem
        request.destination = secondItem
        
        // need to give this type from arguments
        if transtortSelected == .auto{
            request.transportType = .automobile
            request.requestsAlternateRoutes = true
        }
        else {
            request.transportType = .walking
            request.requestsAlternateRoutes = true
        }
        let direction = MKDirections(request: request)
        direction.calculate { (response, error) in
            guard let result = response else {
                if let error = error {
                    print("direction calculate error \(error.localizedDescription)")
                }
                return
            }
            let route = result.routes[0]
            print("|||||||||||||||| \(result.routes.count)")
            self.myPolyline = route.polyline
            self.mapView.addOverlay(self.myPolyline)
//            for item in route {
//                self.mapView.addOverlay(item.polyline)
//            }
            // fix forse unwrap
//            self.mapView.setVisibleMapRect((route.first?.polyline.boundingMapRect)!, animated: true)
//            DispatchQueue.main.async {
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//            }
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
    }
    
    //MARK: - action func
    
    func actionAplication(start: String, finish: String) {
        
        mapView.removeOverlay(myPolyline)
        mapView.removeAnnotations([startPosition, finishPosition])
        startPosition = MKPointAnnotation()
        finishPosition = MKPointAnnotation()
        myPolyline = MKPolyline()
        
        self.getLocation(place: start, order: "start", currentTextField: startLocation) { locationOne in
            if let sourceLocation = locationOne {
                print("FIRST LOCATION: \(sourceLocation)")
                self.getLocation(place: finish, order: "finish", currentTextField: self.finishLocation) { locationTwo in
                    if let destenationLocation = locationTwo {
                        print("SECOND LOCATION: \(destenationLocation)")
                        DispatchQueue.main.async {
                            self.routeConstructor(start: sourceLocation, finish: destenationLocation)
                        }
//                        self.routeConstructor(start: sourceLocation, finish: destenationLocation)
                    }
                }
            }
        }
        print("complete route")
    }
    
    func checkLocationString(srcOne: String, srcTwo: String) -> Bool {
        if srcOne.isEmpty && srcTwo.isEmpty {
            DispatchQueue.main.async {
                self.showAlertController(error: "Empty start and finish locations!")
            }
            return false
        } else {
            return true
        }
    }
    
    func showAlertController(error: String) {
        let alert = UIAlertController(title: "Warning",
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.lineWidth = 3
        render.strokeColor = .red
        return render
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationPerson = locations.last?.coordinate
        guard let locationPerson = locationPerson else { return }
            DispatchQueue.main.async {
                self.mapView.setRegion(MKCoordinateRegion(center: locationPerson, latitudinalMeters: 100, longitudinalMeters: 100), animated: true)
            }
    }
   
}

// MARK: - dismiss keyboard with RETURN and TOUCH

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return was tapped")
        if textField == startLocation {
            finishLocation.becomeFirstResponder()
        } else if textField == finishLocation {
            let start = startLocation.text ?? ""
            let finish = finishLocation.text ?? ""
            
            print("start: \(start) and finish: \(finish)")
            if checkLocationString(srcOne: start, srcTwo: finish) {
                actionAplication(start: start, finish: finish)
            }

//            actionAplication(start: start, finish: finish)
            
//          KOSTIL

//            if start != ""{
//            self.getLocation(place: start) { locationOne in
//                if let sourceLocation = locationOne {
//                    print("FIRST LOCATION: \(sourceLocation)")
//                    self.getLocation(place: finish) { locationTwo in
//                        if let destenationLocation = locationTwo {
//                            print("SECOND LOCATION: \(destenationLocation)")
//                            self.routeConstructor(start: sourceLocation, finish: destenationLocation)
//                        }
//                    }
//                }
//            }
            return finishLocation.resignFirstResponder()
        }
//            else{
//                self.getLocation(place: start) { _ in
//                    if let sourceLocation = self.locationPerson {
////                        self.sourceLocationFirst = sourceLocation
//                print("FIRST LOCATION: \(sourceLocation)")
//                self.getLocation(place: finish) { locationTwo in
//                if let destenationLocation = locationTwo {
//                print("SECOND LOCATION: \(destenationLocation)")
//                self.routeConstructor(start: sourceLocation, finish: destenationLocation)
//                            }
//                        }
//                    }
//                }
//                return finishLocation.resignFirstResponder()
//            }
//        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
