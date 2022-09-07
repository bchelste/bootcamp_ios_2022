//
//  WeatherModel.swift
//  piscineDay07V3
//
//  Created by Artem Potekhin on 20.08.2022.
//

import Foundation
import ForecastIO
import RecastAI

enum RecastError: Error {
    case emptyLocation
    case emptyEntities
    
    var localizedDescription: String {
        switch self {
        case .emptyLocation: return "No Location"
        case .emptyEntities: return "empty entities reply"
        }
    }
}

