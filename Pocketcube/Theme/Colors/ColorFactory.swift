//
//  ColorFactory.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import Foundation


struct ColorFactory {

    static func create(_ app: AppType) -> ColorComponent {
        switch app {
        case .bikeItau:
            return TembiciColor()
        case .ecobici:
            return BikeItauColor()
        case .tembici:
            return BikeItauColor()
        }
    }
}
