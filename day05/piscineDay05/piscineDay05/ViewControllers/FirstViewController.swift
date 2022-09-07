//
//  FirstViewController.swift
//  piscineDay05
//
//  Created by Artem Potekhin on 14.08.2022.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    func setMapConstraints() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureMapView() {
        mapView.delegate = self
        setMapConstraints()
    }
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Standart", "Satelite", "Hybrid"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .link
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        let normalTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.link]
        segmentedControl.setTitleTextAttributes(normalTitleTextAttributes, for: .normal)
        return segmentedControl
    }()
    
    @objc func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:     mapView.mapType = .standard
        case 1:     mapView.mapType = .satellite
        case 2:     mapView.mapType = .hybrid
        default:    break
        }
    }
    
    func configureSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self,
                                   action: #selector(segmentAction),
                                   for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            segmentedControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    let locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "scope"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .link
        return button
    }()
    
    func configureLocationButton() {
        view.addSubview(locationButton)
        locationButton.addTarget(self,
                                 action: #selector(currentPosition),
                                 for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            locationButton.heightAnchor.constraint(equalTo: segmentedControl.heightAnchor),
            locationButton.widthAnchor.constraint(equalTo: segmentedControl.heightAnchor),
            locationButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            locationButton.leftAnchor.constraint(equalTo: segmentedControl.rightAnchor, constant: 10)
        ])
    }
    
    @objc func currentPosition() {
        print("current position button was tapped")
        for item in self.mapView.annotations {
            if item.title == "My current location" {
                self.mapView.removeAnnotation(item)
            }
        }
        LocationManager.shared.getUserLocation { location in
            DispatchQueue.main.async {
                let pin = MKPointAnnotation()
                pin.coordinate = location.coordinate
                pin.title = "My current location"
                self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate,
                                                          span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                                                 longitudeDelta: 0.5)),
                                       animated: true)
                self.mapView.addAnnotation(pin)
            }
        }
        
    }
    
    func setLocation(item: Int) {
        print("set start location")
        DispatchQueue.main.async {
            let pin = MKPointAnnotation()
            pin.coordinate = LocationManager.shared.locationsStorage[item].location.coordinate
            self.mapView.setRegion(MKCoordinateRegion(center: pin.coordinate,
                                                      span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                                             longitudeDelta: 0.5)),
                                   animated: true)

        }
    }
    
    func setStartLocation() {
        if !LocationManager.shared.locationsStorage.isEmpty {
            setLocation(item: 0)
        } else {
            return
        }
    }
    
    func configureLocationPins() {
        for item in LocationManager.shared.locationsStorage {
            let pin = MKPointAnnotation()
            pin.coordinate = item.location.coordinate
            pin.title = item.title
            pin.subtitle = item.subTitle
            self.mapView.addAnnotation(pin)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureSegmentedControl()
        configureLocationButton()
        configureLocationPins()
        setStartLocation()
        
    }
}

extension FirstViewController: OpenMapDelegate {
    
}

extension FirstViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
        if let title = annotation.title {
            switch title {
            case "Ecole 42":
                annotationView.pinTintColor = UIColor.systemMint
            case "School 21":
                annotationView.pinTintColor = UIColor.black
            case "Old Trafford":
                annotationView.pinTintColor = UIColor.systemRed
            case "Etihad Stadium":
                annotationView.pinTintColor = UIColor.systemBlue
            case "Parc des Princes":
                annotationView.pinTintColor = UIColor.purple
            case "Stade de France":
                annotationView.pinTintColor = UIColor.systemBlue
            case "ВТБ Арена":
                annotationView.pinTintColor = UIColor.systemBlue
            case "Открытие Арена":
                annotationView.pinTintColor = UIColor.systemRed
            case "My current location":
                annotationView.pinTintColor = UIColor.orange
            default: break
            }
        }
        annotationView.canShowCallout = true
        return annotationView
    }
}
