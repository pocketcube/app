//
//  SensorKeys.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 22/10/20.
//

import Foundation

enum SensorKey: String {
    case temperature
    case oxygen
    case gps

    init(key: String) {
        switch key {
        case "sensor/oxygen":
            self = .oxygen
        case "sensor/temperature":
            self = .temperature
        case "sensor/gps":
            self = .gps
        default:
            self = .temperature
        }
    }
}
