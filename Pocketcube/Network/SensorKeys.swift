//
//  SensorKeys.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 22/10/20.
//

import Foundation

enum SensorKey: String {
    case gps
    case athmospheric
    case gases

    init(key: String) {
        switch key {
        case "sensor/gases":
            self = .gases
        case "sensor/gps":
            self = .gps
        case "sensor/atmospheric":
            self = .athmospheric
        default:
            self = .athmospheric
        }
    }
}
