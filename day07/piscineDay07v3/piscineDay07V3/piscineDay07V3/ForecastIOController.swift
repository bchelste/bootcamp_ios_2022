//
//  ForecastIOController.swift
//  piscineDay07V3
//
//  Created by Artem Potekhin on 19.08.2022.
//

import Foundation
import UIKit
import ForecastIO
import CoreLocation

class ForecastIOController {
    let token = "01bd9a9eafb3d1d71c307bf67944a47e"
    
    lazy var forecastClient = DarkSkyClient(apiKey: token)
    
    func getForecast(location: CLLocationCoordinate2D, complition: @escaping (Result<Forecast, Error>) -> Void) {
        forecastClient.getForecast(location: location) { result in
            switch result {
            case .success((let currentForecast, _)):
                complition(.success(currentForecast))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}
