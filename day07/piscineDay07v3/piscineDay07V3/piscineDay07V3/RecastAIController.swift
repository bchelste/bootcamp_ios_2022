//
//  RecastAIController.swift
//  piscineDay07V3
//
//  Created by Artem Potekhin on 19.08.2022.
//

import Foundation
import UIKit
import RecastAI
import CoreLocation

class RecastAIController {
    
    

    let token = "cad015d393a344ae67395b3055ab91c4"
    lazy var bot = RecastAIClient(token: token, language: "en")
    
    var complition: ((Result<CLLocationCoordinate2D, Error>) -> Void)?
    
//    func makeTextRequest(text: String, complition: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
//        self.complition = complition
//        bot.textRequest(text,
//                        successHandler: successHandler(response:),
//                        failureHandle: failureHandler(error:))
//    }
    
    func makeTextRequest(text: String, complition: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        self.complition = complition
        if text == "" {
            complition(.failure(RecastError.emptyLocation))
            return 
        }
        bot.textRequest(text,
                        successHandler: successHandler(response:),
                        failureHandle: failureHandler(error:))
    }
    
    func successHandler(response: Response) {
        if let location = response.get(entity: "location") {
            if let latitude = location["lat"] as? CLLocationDegrees,
                let longitude = location["lng"] as? CLLocationDegrees {
                let currentLocation = CLLocationCoordinate2D(latitude: latitude,
                                                             longitude: longitude)
                complition?(.success(currentLocation))
            }
        } else {
            complition?(.failure(RecastError.emptyLocation))
        }
    }
    
    func failureHandler(error: Error) {
        complition?(.failure(error))
    }
}
