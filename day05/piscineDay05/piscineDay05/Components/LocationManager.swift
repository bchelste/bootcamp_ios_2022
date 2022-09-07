//
//  LocationManager.swift
//  piscineDay05
//
//  Created by Artem Potekhin on 15.08.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let locationsStorage: [LocationModel] = [

        LocationModel(title: "Ecole 42",
                      subTitle: "programming school",
                      location: CLLocation(latitude: 48.89671104877445,
                                           longitude: 2.318383373506167)),
        LocationModel(title: "School 21",
                      subTitle: "Moscow campus Ecole 42",
                      location: CLLocation(latitude: 55.797051654713556,
                                           longitude: 37.57973090511807)),
        LocationModel(title: "Old Trafford",
                      subTitle: "Theatre of Dreams Manchester United Football Club",
                      location: CLLocation(latitude: 53.4630621,
                                           longitude: -2.2935288)),
        LocationModel(title: "Etihad Stadium",
                      subTitle: "City of Manchester Stadium Manchester City Football Club",
                      location: CLLocation(latitude: 53.4831381,
                                           longitude: -2.2003953)),
        LocationModel(title: "Parc des Princes",
                      subTitle: "Paris Saint-Germain Football Club",
                      location: CLLocation(latitude: 48.8414356,
                                           longitude: 2.2530487)),
        LocationModel(title: "Stade de France",
                      subTitle: "Équipe nationalle de France de football",
                      location: CLLocation(latitude: 48.9244592,
                                           longitude: 2.3601645)),
        LocationModel(title: "ВТБ Арена",
                      subTitle: "Центральный стадион „Динамо“ имени Льва Яшина",
                      location: CLLocation(latitude: 55.79131048759901,
                                           longitude: 37.56144529355625)),
        LocationModel(title: "Открытие Арена",
                      subTitle: "Домашняя арена клуба «Спартак» (Москва)",
                      location: CLLocation(latitude: 55.817711,
                                           longitude: 37.440214)),
        
    ]

    


    
    let manager = CLLocationManager()
    
    var complition: ((CLLocation) -> Void)?
    
    public func getUserLocation(complition: @escaping ((CLLocation) -> Void)) {
        self.complition  = complition
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        complition?(location)
        manager.stopUpdatingLocation()
        
    }
    
    
}
